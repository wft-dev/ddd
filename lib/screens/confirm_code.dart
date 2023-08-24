import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:daily_dairy_diary/constant/constant.dart';
import 'package:daily_dairy_diary/provider/resend_code_controller.dart';
import 'package:daily_dairy_diary/router/router_listenable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../constant/strings.dart';
import '../models/auth_results.dart';
import '../provider/confirm_user_controller.dart';
import '../router/routes.dart';
import '../utils/common_utils.dart';
import '../widgets/all_widgets.dart';

class ConfirmCode extends ConsumerStatefulWidget {
  const ConfirmCode(this.email, this.destination, this.name, {Key? key})
      : super(key: key);
  final String? destination;
  final String name;
  final String email;

  @override
  ConsumerState<ConfirmCode> createState() => ConfirmCodeState();
}

class ConfirmCodeState extends ConsumerState<ConfirmCode> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController codeController = TextEditingController(text: "");

  @override
  void initState() {
    super.initState();
  }

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
        body: getBody(),
      ),
    );
  }

  // This is used for display all widgets.
  Widget getBody() {
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
                  textAlign: TextAlign.center,
                  Strings.confirmationMessage(widget.destination, widget.name),
                  style: CustomTextStyle.titleHeaderStyle()
                      .copyWith(fontSize: Sizes.p5.sw),
                ),
                Box.gapH2,
                buildEmailForm(),
                Box.gapH2,
                buildConfirmCodeButton(),
                Box.gapH2,
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    Strings.resendVerifyCode,
                    style: CustomTextStyle.textFieldLabelStyle(),
                  ),
                ),
                Box.gapH1,
                buildResendCodeButton(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // This [Form] is used for enter confirmation code.
  Form buildEmailForm() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          AppTextFormField(
            controller: codeController,
            label: Strings.code,
            validator: Validations.validateOTP,
            textInputAction: TextInputAction.done,
          ),
        ],
      ),
    );
  }

  // This [AppButton] is used for confirm the code.
  AppButton buildConfirmCodeButton() {
    ref.listen<AsyncValue>(confirmUserControllerProvider, (_, state) {
      state.showAlertDialogOnError(context);
      if (!state.hasError && state.hasValue && !state.isLoading) {
        state.whenData(
          (result) async {
            final AuthResults signUpResult = result;
            if (signUpResult is SignUpResultValue) {
              final signUpStep = signUpResult.result!.nextStep.signUpStep;
              if (signUpStep == AuthSignUpStep.done) {
                ref.read(routerListenableProvider.notifier).userIsLogin(true);
                const DashboardRoute().go(context);
              }
            }
          },
        );
      }
    });
    return AppButton(
      text: Strings.confirm,
      onPress: () async {
        if (!_formKey.currentState!.validate()) return;
        await ref
            .read(confirmUserControllerProvider.notifier)
            .confirmUserWithCode(widget.email, codeController.text);
      },
    );
  }

  // This [AppButton] is used for resend the confirmation the code.
  AppButton buildResendCodeButton() {
    ref.listen<AsyncValue>(resendCodeControllerProvider, (_, state) {
      state.showAlertDialogOnError(context);
      if (!state.hasError && state.hasValue && !state.isLoading) {
        state.whenData((result) async {
          final AuthResults resendCodeResult = result;
          if (resendCodeResult is ResendSignUpCodeResultValue) {
            showExceptionAlertDialog(
              context: context,
              title: Strings.success,
              exception: Strings.sendVerificationSuccess,
            );
          }
        });
      }
    });

    return AppButton(
      text: Strings.resend,
      onPress: () async {
        await ref
            .read(resendCodeControllerProvider.notifier)
            .resendSignUpUserCode(widget.email);
      },
    );
  }

  @override
  void dispose() {
    codeController.dispose();
    super.dispose();
  }
}
