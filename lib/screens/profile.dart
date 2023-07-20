import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../constant/strings.dart';
import '../provider/todo_controller.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(Strings.profile),
        ),
        body: getBody());
  }

  Widget getBody() {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "",
              style: CustomTextStyle.loginTitleStyle().copyWith(fontSize: 36),
            ),
            SizedBox(height: Sizes.p2.sh),
            buildProfileForm(),
            buildSaveButton(),
            SizedBox(height: Sizes.p2.sh),
            buildChangePasswordButton(),
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
        await ref.read(updateUseControllerProvider.notifier).updateUser(
            firstNameController.text,
            lastNameController.text,
            phoneNumberController.text);
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

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    phoneNumberController.dispose();
    super.dispose();
  }
}
