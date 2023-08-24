import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:daily_dairy_diary/models/user.dart';
import 'package:daily_dairy_diary/router/router_listenable.dart';
import 'package:daily_dairy_diary/utils/show_alert_dialog.dart';
import 'package:daily_dairy_diary/widgets/app_alert.dart';
import 'package:daily_dairy_diary/widgets/loading_overlay.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:image_picker/image_picker.dart';

import '../constant/strings.dart';
import '../provider/product_controller.dart';
import '../provider/update_user_controller.dart';
import '../repositories/auth_repository.dart';
import '../router/routes.dart';
import '../utils/common_utils.dart';
import '../widgets/all_widgets.dart';

class Profile extends ConsumerStatefulWidget {
  const Profile({super.key});
  @override
  ConsumerState<Profile> createState() => ProfileState();
}

class ProfileState extends ConsumerState<Profile> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController firstNameController =
      TextEditingController(text: "");
  final TextEditingController lastNameController =
      TextEditingController(text: "");
  final TextEditingController phoneNumberController =
      TextEditingController(text: "");
  String? pickedImage;
  bool isImageSelected = false;
  final focusPhoneNumber = FocusNode();
  String phoneNumber = '';
  String? countyCode;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldAppBar(
      barTitle: Strings.profile,
      child: getBody(),
    );
  }

  // Get profile data from update user provider.
  void getProfileData() {
    final profileData = ref.watch(updateUserControllerProvider);
    profileData.whenData((result) async {
      User user = result;
      if (!isImageSelected) {
        pickedImage = user.picture;
      }
      if (user.name.isNotEmpty) {
        List splitUserName = user.name.splitSpaceString();
        firstNameController.text = splitUserName[Sizes.pInt0];
        lastNameController.text = splitUserName[Sizes.pInt1];
      }
      String phoneNumber = user.phoneNumber.toString();
      if (phoneNumber.isNotEmpty) {
        PhoneNumber number =
            await PhoneNumber.getRegionInfoFromPhoneNumber(phoneNumber);
        String parsableNumber = await PhoneNumber.getParsableNumber(number);
        setState(() {
          countyCode = number.isoCode;
        });
        phoneNumberController.text = parsableNumber;
      }
    });
  }

  // This is used for display all widgets.
  Widget getBody() {
    ref.listen<AsyncValue>(updateUserControllerProvider, (_, state) {
      state.showAlertDialogOnError(context);
    });
    final profileData = ref.watch(updateUserControllerProvider);
    // profileData.isLoadingShow(context);

    getProfileData();
    return Container(
      height: ResponsiveAppUtil.height * Sizes.p01.sh,
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(Sizes.p12.sw),
        ),
      ),
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: Sizes.p5.sw),
          child: Container(
            padding: EdgeInsets.only(bottom: Sizes.p4.sh),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buildRoundedContainer(
                  child: Column(
                    children: [
                      Center(
                        child: GestureDetector(
                          onTap: () {
                            PickImage()
                                .imageFormGallery(
                              context: context,
                            )
                                .then((value) {
                              if (value != null) {
                                setState(() {
                                  pickedImage = value;
                                  isImageSelected = true;
                                });
                              }
                            });
                          },
                          child: CircularImage(
                            isImageSelected: isImageSelected,
                            imageURL: pickedImage ?? '',
                            size: Sizes.p100,
                            borderColor: AppColors.lightPurpleColor,
                          ),
                        ),
                      ),
                      Box.gapH2,
                      buildProfileForm(),
                      Box.gapH2,
                      buildSaveButton(),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: Sizes.p5.sw),
                  child: Column(
                    children: [
                      Box.gapH2,
                      buildChangePasswordButton(),
                      Box.gapH2,
                      buildLogoutButton(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // This [Form] display first name, last name, phone number.
  Form buildProfileForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          AppTextFormField(
            controller: firstNameController,
            label: Strings.firstName,
            validator: Validations.validateFirstName,
            textInputAction: TextInputAction.next,
          ),
          AppTextFormField(
            controller: lastNameController,
            label: Strings.lastName,
            validator: Validations.validateLastName,
            textInputAction: TextInputAction.next,
            onEditingCompleted: () {
              FocusScope.of(context).requestFocus(focusPhoneNumber);
            },
          ),
          PhoneNumberTextField(
            focus: focusPhoneNumber,
            controller: phoneNumberController,
            label: Strings.phoneNumber,
            borderColor: AppColors.whiteColor,
            fillColor: AppColors.whiteColor,
            countyCode: countyCode,
            // validator: (value) {
            //   print(value);
            //   return null;
            // },
            onInputChanged: (number) {
              phoneNumber = '${number.phoneNumber}';
            },
            textInputAction: TextInputAction.done,
          ),
        ],
      ),
    );
  }

  // This [AppButton] is used to save profile data.
  AppButton buildSaveButton() {
    return AppButton(
      text: Strings.save,
      onPress: () async {
        if (!_formKey.currentState!.validate()) return;
        File? pickedImageFile =
            pickedImage != null && isImageSelected ? File(pickedImage!) : null;
        await ref.read(updateUserControllerProvider.notifier).updateUser(
            firstNameController.text,
            lastNameController.text,
            phoneNumberController.text.isEmpty ? '' : phoneNumber,
            pickedImageFile);
      },
    );
  }

  //  This [AppButton] is going to change password screen.
  AppButton buildChangePasswordButton() {
    return AppButton(
      text: Strings.changePassword,
      onPress: () async {
        const ChangePasswordRoute().push(context);
      },
    );
  }

  //  This [AppButton] is used for logout.
  AppButton buildLogoutButton() {
    return AppButton(
      text: Strings.logout,
      onPress: () async {
        var value = await showDialog<bool>(
          context: context,
          builder: (BuildContext context) {
            return const AppAlert(
              title: Strings.logout,
              content: Strings.wantToLogout,
            );
          },
        );
        value ??= false;
        if (value) {
          await ref.read(authRepositoryProvider).signOut();
          // ref.read(routerListenableProvider.notifier);
          // ref.watch(currentUserRepositoryProvider).value;
          if (mounted) {
            ref.read(routerListenableProvider.notifier).userIsLogin(false);
            const LoginRoute().go(context);
          }
        }
      },
    );
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    phoneNumberController.dispose();
    super.dispose();
  }
}
