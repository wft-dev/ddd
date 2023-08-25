import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:daily_dairy_diary/constant/constant.dart';
import 'package:daily_dairy_diary/router/router_listenable.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../constant/strings.dart';
import '../models/auth_results.dart';
import '../provider/register_controller.dart';
import '../router/routes.dart';
import '../utils/common_utils.dart';
import '../widgets/all_widgets.dart';

class Register extends ConsumerStatefulWidget {
  const Register({super.key});
  @override
  ConsumerState<Register> createState() => RegisterState();
}

class RegisterState extends ConsumerState<Register> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKeySecond = GlobalKey<FormState>();

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
  bool isTermConditionChecked = false;
  bool isTermConditionError = false;
  String phoneNumber = '';
  final focusPhoneNumber = FocusNode();

  @override
  Widget build(BuildContext context) {
    return HideKeyboardWidget(
      child: Scaffold(
          extendBodyBehindAppBar:
              true, // This makes the body extend behind the app bar
          appBar: AppBar(
            elevation: Sizes.p0, // Remove the shadow
            backgroundColor: AppColors.transparentColor,
            iconTheme: IconThemeData(color: AppColors.darkPurpleColor),
          ),
          body: getBody()),
    );
  }

  Widget getBody() {
    return CircularContainer(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Box.gapH2,
            Text(
              Strings.createAnAccount,
              style: CustomTextStyle.titleHeaderStyle(),
            ),
            Box.gapH2,
            buildEmailSignUpForm(),
            buildTermCondition(),
            Box.gapH2,
            buildRegisterButton(),
            Box.gapH2,
            loginSignUpButton(context, Strings.haveAnAccount, Strings.login),
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
            validator: (value) => Validations.validatePassword(
                value, Strings.password.toLowerCase()),
            textInputAction: TextInputAction.next,
          ),
          AppTextFormField(
            controller: confirmPasswordController,
            label: Strings.confirmPassword,
            obscure: true,
            validator: (value) => Validations.validateConfirmPassword(
                value, passwordController.text),
            textInputAction: TextInputAction.next,
            onEditingCompleted: () {
              FocusScope.of(context).requestFocus(focusPhoneNumber);
            },
          ),
          PhoneNumberTextField(
            focus: focusPhoneNumber,
            controller: phoneNumberController,
            label: Strings.phoneNumber,
            // validator: (value) {
            //   print(value);
            //   return null;
            // },
            onInputChanged: (number) {
              phoneNumber = '${number.phoneNumber}';
            },
            textInputAction: TextInputAction.done,
          ),
          // AppTextFormField(
          //   controller: phoneNumberController,
          //   label: Strings.phoneNumber,
          //   textInputAction: TextInputAction.done,
          // ),
        ],
      ),
    );
  }

  AppButton buildRegisterButton() {
    ref.listen<AsyncValue>(registerControllerProvider, (_, state) {
      print('loginControllerProvider state, $state');
      state.showAlertDialogOnError(context);
      if (!state.hasError && state.hasValue && !state.isLoading) {
        state.whenData(
          (result) async {
            final AuthResults signUpResult = result;
            if (signUpResult is SignUpResultValue) {
              final signUpStep = signUpResult.result!.nextStep.signUpStep;
              if (signUpStep == AuthSignUpStep.confirmSignUp) {
                final codeDetail =
                    signUpResult.result!.nextStep.codeDeliveryDetails;
                ConfirmCodeRoute(
                        email: emailController.text,
                        destination: codeDetail?.destination,
                        name: codeDetail!.deliveryMedium.name)
                    .push(context);
              } else if (signUpStep == AuthSignUpStep.done) {
                ref.read(routerListenableProvider.notifier).userIsLogin(true);
                const DashboardRoute().go(context);
              }
            }
          },
        );
      }
    });
    return AppButton(
      text: Strings.register,
      onPress: () async {
        if (!_formKey.currentState!.validate() ||
            (isTermConditionChecked == false)) {
          if (!isTermConditionChecked) {
            setState(() {
              isTermConditionError = !isTermConditionChecked;
            });
          }
          return;
        }
        await ref.read(registerControllerProvider.notifier).registerUser(
            firstNameController.text,
            lastNameController.text,
            emailController.text,
            passwordController.text,
            phoneNumberController.text.isEmpty ? '' : phoneNumber);
      },
    );
  }

  AppCheckbox buildTermCondition() {
    return AppCheckbox(
      errorText: isTermConditionChecked != true && isTermConditionError
          ? Strings.selectTermAndCondition
          : '',
      listTileCheckBox: isTermConditionChecked,
      title: Strings.termAndCondition,
      onChange: (value) async {
        setState(() {
          isTermConditionChecked = !isTermConditionChecked;
          isTermConditionError = !isTermConditionChecked;
        });
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
