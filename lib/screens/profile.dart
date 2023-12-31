import 'dart:io';

import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:daily_dairy_diary/models/auth_results.dart';
import 'package:daily_dairy_diary/models/user.dart';
import 'package:daily_dairy_diary/router/router_listenable.dart';
import 'package:daily_dairy_diary/widgets/loading_overlay.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:daily_dairy_diary/constant/strings.dart';
import 'package:daily_dairy_diary/provider/update_user_controller.dart';
import 'package:daily_dairy_diary/repositories/auth_repository.dart';
import 'package:daily_dairy_diary/router/routes.dart';
import 'package:daily_dairy_diary/utils/common_utils.dart';
import 'package:daily_dairy_diary/widgets/all_widgets.dart';

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
  final TextEditingController emailController = TextEditingController(text: "");
  final TextEditingController phoneNumberController =
      TextEditingController(text: "");
  final countyCodeNotifier = ValueNotifier<String?>(null);

  String? pickedImage;
  bool isImageSelected = false;
  final focusPhoneNumber = FocusNode();
  String phoneNumber = '';
  bool isGoogleLogin = false;

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

    ref.listen<AsyncValue>(updateUserControllerProvider, (_, state) {
      state.showAlertDialogOnError(context: context, ref: ref);
      state.isLoadingShow(context);
      if (!state.hasError && state.hasValue && !state.isLoading) {
        state.whenData(
          (result) async {
            final AuthResults updateUserResultValue = result;
            if (updateUserResultValue is UpdateUserResultValue) {
              if (updateUserResultValue.result != null) {
                final updateUserResult = updateUserResultValue.result!;
                bool isUpdateProfile = false;
                bool isEmailChanged = false;

                updateUserResult.forEach((key, value) {
                  switch (value.nextStep.updateAttributeStep) {
                    case AuthUpdateAttributeStep.confirmAttributeWithCode:
                      isUpdateProfile = false;
                      isEmailChanged = true;
                      final destination =
                          value.nextStep.codeDeliveryDetails?.destination;
                      ChangeEmailRoute(
                              destination: destination,
                              name: value.nextStep.codeDeliveryDetails!
                                  .deliveryMedium.name)
                          .push(context);

                      break;
                    case AuthUpdateAttributeStep.done:
                      isUpdateProfile = true;
                      break;
                  }
                });
                if (isUpdateProfile && !isEmailChanged) {
                  ShowSnackBar.showSnackBar(
                      context,
                      Strings.successMessage(
                          Strings.profile, ActionType.update.name));
                }
              }
            }
          },
        );
      }
    });
    profileData.isLoadingShow(context);

    profileData.whenData((result) async {
      final AuthResults updateUserResultValue = result;
      if (updateUserResultValue is UpdateUserResultValue) {
        if (updateUserResultValue.user != null) {
          User user = updateUserResultValue.user!;

          print(user);
          if (!isImageSelected) {
            pickedImage = user.picture;
          }
          if (user.name.isNotEmpty) {
            List splitUserName = user.name.splitSpaceString();
            if (splitUserName.isNotEmpty) {
              firstNameController.text = splitUserName[Sizes.pInt0];
            }
            if (splitUserName.length == Sizes.p2.toInt() ||
                splitUserName.length == Sizes.p3.toInt()) {
              lastNameController.text = splitUserName[Sizes.pInt1] ?? '';
            }
          }
          emailController.text = user.email;
          String phoneNumber = user.phoneNumber.toString();

          if (user.providerType == ProviderType.google.name.capitalizeFirst()) {
            isGoogleLogin = true;
          }
          if (user.phoneNumber.isNotEmpty) {
            PhoneNumber number =
                await PhoneNumber.getRegionInfoFromPhoneNumber(phoneNumber);
            String parsableNumber = await PhoneNumber.getParsableNumber(number);
            phoneNumberController.text = parsableNumber;
            countyCodeNotifier.value = number.isoCode;
          }
        }
      }
    });
  }

  // This is used for display all widgets.
  Widget getBody() {
    getProfileData();

    return SingleChildScrollView(
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
                          if (!isGoogleLogin) {
                            showImageActionSheet();
                          }
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
                    if (!isGoogleLogin) ...[
                      Box.gapH2,
                      buildUpdateButton(),
                    ],
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Sizes.p5.sw),
                child: Column(
                  children: [
                    if (!isGoogleLogin) ...[
                      Box.gapH2,
                      buildChangePasswordButton(),
                    ],
                    Box.gapH2,
                    buildLogoutButton(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Show action sheet for pick the image from the camera and gallery.
  void showImageActionSheet() {
    showActionSheetDialog(
      context: context,
      title: Strings.pickImage,
      actions: <Widget>[
        CupertinoActionSheetAction(
          isDefaultAction: true,
          onPressed: () => handleImageActionSheet(
              actionType: Strings.gallery, context: context),
          child: const Text(Strings.gallery),
        ),
        CupertinoActionSheetAction(
          isDefaultAction: true,
          onPressed: () => handleImageActionSheet(
              actionType: Strings.camera, context: context),
          child: const Text(Strings.camera),
        )
      ],
    );
  }

  // Handle the click on the gallery button and camera button.
  Future<void> handleImageActionSheet(
      {required String actionType, required BuildContext context}) async {
    context.pop(false);
    String? value;
    if (actionType == Strings.camera) {
      value = await PickImage().imageFormCamera(context: context);
    } else if (actionType == Strings.gallery) {
      value = await PickImage().imageFormGallery(context: context);
    }
    if (value != null) {
      setState(() {
        pickedImage = value;
        isImageSelected = true;
      });
    }
  }

  // This [Form] display first name, last name, phone number.
  Form buildProfileForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          AppTextFormField(
            enabled: !isGoogleLogin,
            controller: firstNameController,
            label: Strings.firstName,
            validator: Validations.validateFirstName,
            textInputAction: TextInputAction.next,
          ),
          AppTextFormField(
            enabled: !isGoogleLogin,
            controller: lastNameController,
            label: Strings.lastName,
            validator: Validations.validateLastName,
            textInputAction: TextInputAction.next,
            onEditingCompleted: () {
              FocusScope.of(context).requestFocus(focusPhoneNumber);
            },
          ),
          AppTextFormField(
            enabled: !isGoogleLogin,
            controller: emailController,
            label: Strings.email,
            validator: Validations.validateEmail,
            textInputAction: TextInputAction.next,
          ),
          ValueListenableBuilder(
              valueListenable: countyCodeNotifier,
              builder: (context, value, _) {
                return PhoneNumberTextField(
                  enabled: !isGoogleLogin,
                  focus: focusPhoneNumber,
                  controller: phoneNumberController,
                  label: Strings.phoneNumber,
                  borderColor: AppColors.whiteColor,
                  fillColor: AppColors.whiteColor,
                  countyCode: countyCodeNotifier.value,
                  // validator: (value) {
                  //   print(value);
                  //   return null;
                  // },
                  onInputChanged: (number) {
                    phoneNumber = '${number.phoneNumber}';
                  },
                  textInputAction: TextInputAction.done,
                );
              }),
        ],
      ),
    );
  }

  // This [AppButton] is used to save profile data.
  AppButton buildUpdateButton() {
    return AppButton(
      text: Strings.update,
      onPress: () async {
        if (!_formKey.currentState!.validate()) return;
        File? pickedImageFile =
            pickedImage != null && isImageSelected ? File(pickedImage!) : null;
        await ref.read(updateUserControllerProvider.notifier).updateUser(
            firstNameController.text,
            lastNameController.text,
            emailController.text,
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
        showAlertActionDialog(
          context: context,
          title: Strings.logout,
          content: Strings.wantToLogout,
          isShowCancel: true,
          defaultActionText: Strings.yes,
          onYesPress: () async {
            LoadingOverlay.of(context)?.show();
            await ref
                .read(authRepositoryProvider)
                .signOut(isGoogleLogin ? ProviderType.google : null);
            if (mounted) {
              ref.read(routerListenableProvider.notifier).userIsLogin(false);
              LoadingOverlay.of(context)?.hide();
              const LoginRoute().go(context);
            }
          },
        );
      },
    );
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    phoneNumberController.dispose();
    countyCodeNotifier.dispose();

    super.dispose();
  }
}
