import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:daily_dairy_diary/constant/constant.dart';
import 'package:daily_dairy_diary/provider/login_resend_code_controller.dart';
import 'package:daily_dairy_diary/provider/providers.dart';
import 'package:daily_dairy_diary/router/router_listenable.dart';

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
    return HideKeyboardWidget(
      child: Scaffold(
        body: getBody(),
      ),
    );
  }

  // This is used for display all widgets.
  Widget getBody() {
    final getRemember = ref.watch(getRememberProvider);
    if (getRemember.check) {
      emailController.text = getRemember.email;
      passwordController.text = getRemember.password;
      isRememberMeChecked = getRemember.check;
    }
    return CircularContainer(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Box.gapH2,
                Text(
                  Strings.signInAccount,
                  style: CustomTextStyle.titleHeaderStyle(),
                ),
                Box.gapH2,
                buildEmailSignUpForm(),
                buildRememberCheckbox(),
                buildButton(),
                Box.gapH4,
                Align(
                  alignment: Alignment.center,
                  child: GestureDetector(
                    onTap: () {
                      const ForgetPasswordRoute().push(context);
                    },
                    child: Text(Strings.forgetPassword,
                        style: CustomTextStyle.buttonTitleStyle().copyWith(
                            color: AppColors.pinkColor,
                            fontSize: Sizes.p3_3.sw,
                            fontWeight: FontWeight.w600)),
                  ),
                ),
                Box.gapH2,
                loginSignUpButton(
                    context, Strings.doNotAccount, Strings.signUp),
                Box.gapH4,
                buildGoogleButton(),
                Box.gapH2,
              ],
            ),
          ],
        ),
      ),
    );
  }

  // This [Form] is used for enter email, password.
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

  // This [AppButton] is used for login.
  AppButton buildButton() {
    ref.listen<AsyncValue>(loginControllerProvider, (_, state) {
      print('loginControllerProvider state, $state');
      state.showAlertDialogOnError(context);
      if (!state.hasError && state.hasValue && !state.isLoading) {
        state.whenData(
          (result) async {
            final AuthResults signInResult = result;
            if ((signInResult is SignInResultValue) &&
                (signInResult.result != null)) {
              final signInStep = signInResult.result!.nextStep.signInStep;
              if (signInStep == AuthSignInStep.confirmSignInWithNewPassword) {
                showExceptionAlertDialog(
                  context: context,
                  title: Strings.error,
                  exception: Strings.newPasswordContinue,
                );
              } else if (signInStep == AuthSignInStep.confirmSignUp) {
                await ref
                    .read(loginResendCodeControllerProvider.notifier)
                    .resendSignUpUserCode(emailController.text);
              } else if (signInStep == AuthSignInStep.done) {
                ref.read(routerListenableProvider.notifier).userIsLogin(true);
                const DashboardRoute().go(context);
              }
            }
          },
        );
      }
      // user?.when(
      //     signInResultValue: (result) =>
      //         print("user ${result?.nextStep.signInStep}"),
      //     signUpResult: (AuthSignInStep result) {});
    });
    ref.listen<AsyncValue>(loginResendCodeControllerProvider, (_, state) {
      state.showAlertDialogOnError(context);
      if (!state.hasError && state.hasValue && !state.isLoading) {
        state.whenData((result) async {
          final AuthResults resendCodeResult = result;
          if ((resendCodeResult is ResendSignUpCodeResultValue) &&
              (resendCodeResult.result != null)) {
            final codeDetail = resendCodeResult.result!.codeDeliveryDetails;
            ConfirmCodeRoute(
                    email: emailController.text,
                    destination: codeDetail.destination,
                    name: codeDetail.deliveryMedium.name)
                .push(context);
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

  // This [AppButton] is used for google login.
  AppButton buildGoogleButton() {
    return AppButton(
      text: Strings.google,
      onPress: () async {
        await ref.read(loginControllerProvider.notifier).googleLogInUser();
      },
    );
  }

  // This [AppCheckbox] is used for save login detail.
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
