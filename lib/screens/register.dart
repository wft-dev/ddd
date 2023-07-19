import 'package:daily_dairy_diary/provider/register_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../constant/strings.dart';
import '../utils/common_utils.dart';
import '../widgets/all_widgets.dart';

class Register extends ConsumerStatefulWidget {
  const Register({super.key});
  @override
  ConsumerState<Register> createState() => RegisterState();
}

class RegisterState extends ConsumerState<Register> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController firstNameController =
      TextEditingController(text: "");
  final TextEditingController lastNameController =
      TextEditingController(text: "");
  final TextEditingController emailController = TextEditingController(text: "");
  final TextEditingController passwordController =
      TextEditingController(text: "");
  final TextEditingController confirmPasswordController =
      TextEditingController(text: "");
  final TextEditingController phoneNumberController =
      TextEditingController(text: "");

  bool? success;
  String? userEmail;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(Strings.register),
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
            buildEmailSignUpForm(),
            buildButton(),
          ],
        ),
      ),
    );
  }

  Form buildEmailSignUpForm() {
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
            controller: emailController,
            label: Strings.email,
            validator: Validations.validateEmail,
            textInputAction: TextInputAction.next,
          ),
          AppTextFormField(
            controller: passwordController,
            label: Strings.password,
            obscure: true,
            validator: Validations.validatePassword,
            textInputAction: TextInputAction.next,
          ),
          AppTextFormField(
            controller: confirmPasswordController,
            label: Strings.confirmPassword,
            obscure: true,
            validator: (value) => Validations.validateConfirmPassword(
                value, passwordController.text),
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

  AppButton buildButton() {
    ref.listen<AsyncValue>(registerControllerProvider,
        (_, state) => state.showAlertDialogOnError(context));
    return AppButton(
      text: Strings.register,
      onPress: () async {
        if (!_formKey.currentState!.validate()) return;
        await ref.read(registerControllerProvider.notifier).registerUser(
            firstNameController.text,
            lastNameController.text,
            emailController.text,
            passwordController.text,
            phoneNumberController.text);
      },
    );
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    phoneNumberController.dispose();
    super.dispose();
  }
}
