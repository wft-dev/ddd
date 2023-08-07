import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:daily_dairy_diary/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
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

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(Strings.profile),
        ),
        body: getBody());
  }

  Widget getBody() {
    ref.listen<AsyncValue>(updateUseControllerProvider, (_, state) {
      state.showAlertDialogOnError(context);
      if (!state.hasError && state.hasValue && !state.isLoading) {
        state.whenData((result) {
          User user = result;
          if (!isImageSelected) {
            pickedImage = user.picture;
          }
          List splitUserName = user.name.splitSpaceString();
          firstNameController.text = splitUserName[0];
          lastNameController.text = splitUserName[1];
          phoneNumberController.text = user.phoneNumber.toString();
        });
      }
    });
    // final userDetail = ref.watch(updateUseControllerProvider);

    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "",
              style: CustomTextStyle.loginTitleStyle().copyWith(fontSize: 16),
            ),
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
                  size: 100,
                  borderColor: Colors.green,
                ),
              ),
            ),
            SizedBox(height: Sizes.p2.sh),
            buildProfileForm(),
            buildSaveButton(),
            SizedBox(height: Sizes.p2.sh),
            buildChangePasswordButton(),
            SizedBox(height: Sizes.p2.sh),
            buildLogoutButton()
          ],
        ),
      ),
    );
  }

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
          ),
          AppTextFormField(
            controller: phoneNumberController,
            label: Strings.phoneNumber,
            textInputAction: TextInputAction.done,
          ),
        ],
      ),
    );
  }

  AppButton buildSaveButton() {
    return AppButton(
      text: Strings.save,
      onPress: () async {
        if (!_formKey.currentState!.validate()) return;
        File? pickedImageFile =
            pickedImage != null && isImageSelected ? File(pickedImage!) : null;
        await ref.read(updateUseControllerProvider.notifier).updateUser(
            firstNameController.text,
            lastNameController.text,
            phoneNumberController.text,
            pickedImageFile);
      },
    );
  }

  AppButton buildChangePasswordButton() {
    return AppButton(
      text: Strings.changePassword,
      onPress: () async {
        const ChangePasswordRoute().go(context);
      },
    );
  }

  AppButton buildLogoutButton() {
    return AppButton(
      text: Strings.logout,
      onPress: () async {
        await ref.read(authRepositoryProvider).signOut();
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
