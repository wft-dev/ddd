import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../constant/strings.dart';
import '../models/auth_results.dart';
import '../provider/login_controller.dart';
import '../provider/remember_me_controller.dart';
import '../provider/resend_code_controller.dart';
import '../repositories/remember_me_repository.dart';
import '../router/routes.dart';
import '../utils/common_utils.dart';
import '../widgets/all_widgets.dart';

class Login extends ConsumerStatefulWidget {
  const Login({super.key});
  @override
  ConsumerState<Login> createState() => LoginState();
}

class LoginState extends ConsumerState<Login> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController(text: "");
  final TextEditingController passwordController =
      TextEditingController(text: "");

  bool isRememberMeChecked = false;
  String? userEmail;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(Strings.login),
        ),
        body: getBody());
  }

  Widget getBody() {
    final getRemember = ref.watch(getRememberProvider);
    if (getRemember.check) {
      emailController.text = getRemember.email;
      passwordController.text = getRemember.password;
      isRememberMeChecked = getRemember.check;
    }
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "",
                  style:
                      CustomTextStyle.loginTitleStyle().copyWith(fontSize: 36),
                ),
                SizedBox(height: Sizes.p2.sh),
                buildEmailSignUpForm(),
                buildRememberCheckbox(),
                buildButton(),
                SizedBox(height: Sizes.p2.sh),
                Align(
                    alignment: Alignment.topRight,
                    child: GestureDetector(
                      onTap: () {
                        const ForgetPasswordRoute().push(context);
                      },
                      child: Text(
                        Strings.forgetPassword,
                        style: CustomTextStyle.registerButtonStyle()
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                    )),
                SizedBox(height: Sizes.p2.sh),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      Strings.doNotAccount,
                      style: CustomTextStyle.registerButtonStyle(),
                    ),
                    GestureDetector(
                      onTap: () {
                        const RegisterRoute().push(context);
                      },
                      child: Text(
                        Strings.register,
                        style: CustomTextStyle.registerButtonStyle()
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
              ],
            ),
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
            textInputAction: TextInputAction.done,
          ),
        ],
      ),
    );
  }

  AppButton buildButton() {
    ref.listen<AsyncValue>(loginControllerProvider, (_, state) {
      print('loginControllerProvider state, $state');
      state.showAlertDialogOnError(context);
      if (!state.hasError && state.hasValue && !state.isLoading) {
        state.whenData(
          (result) async {
            final AuthResults signInResult = result;
            if (signInResult is SignInResultValue) {
              final signInStep = signInResult.result!.nextStep.signInStep;
              if (signInStep == AuthSignInStep.confirmSignInWithNewPassword) {
                showExceptionAlertDialog(
                  context: context,
                  title: Strings.error,
                  exception: Strings.newPasswordContinue,
                );
              } else if (signInStep == AuthSignInStep.confirmSignUp) {
                await ref
                    .read(resendCodeControllerProvider.notifier)
                    .resendSignUpUserCode(emailController.text);
              } else if (signInStep == AuthSignInStep.done) {
                const ProfileRoute().go(context);
              }
              print("user122 ${signInResult.result?.nextStep.signInStep}");
            }
          },
        );
      }
      // user?.when(
      //     signInResultValue: (result) =>
      //         print("user ${result?.nextStep.signInStep}"),
      //     signUpResult: (AuthSignInStep result) {});
    });
    ref.listen<AsyncValue>(resendCodeControllerProvider, (_, state) {
      state.showAlertDialogOnError(context);
      if (!state.hasError && state.hasValue && !state.isLoading) {
        state.whenData((result) async {
          final AuthResults resendCodeResult = result;
          if (resendCodeResult is ResendSignUpCodeResultValue) {
            final codeDetail = resendCodeResult.result!.codeDeliveryDetails;
            ConfirmCodeRoute(
                    email: emailController.text,
                    destination: codeDetail.destination,
                    name: codeDetail.deliveryMedium.name)
                .go(context);
          }
        });
      }
    });
    // final AuthResults? user = ref.watch(loginControllerProvider).value;
    // user?.when(
    //     signInResultValue: (result) =>
    //         print("user ${result?.nextStep.signInStep}"), signUpResult: (AuthSignInStep result) {  });
    return AppButton(
      text: Strings.login,
      onPress: () async {
        if (!_formKey.currentState!.validate()) return;
        await ref
            .read(loginControllerProvider.notifier)
            .logInUser(emailController.text, passwordController.text);
      },
    );
  }

  AppCheckbox buildRememberCheckbox() {
    return AppCheckbox(
      listTileCheckBox: isRememberMeChecked,
      title: Strings.rememberMe,
      onChange: (value) async {
        setState(() {
          isRememberMeChecked = !isRememberMeChecked;
        });
        await ref
            .read(rememberMeControllerProvider.notifier)
            .completeRememberMe(
                checkValue: value,
                email: value ? emailController.text : '',
                password: value ? passwordController.text : '');
      },
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
