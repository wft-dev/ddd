import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../constant/strings.dart';
import '../models/auth_results.dart';
import '../provider/reset_password_controller.dart';
import '../router/routes.dart';
import '../utils/common_utils.dart';
import '../widgets/all_widgets.dart';

class ForgetPassword extends ConsumerStatefulWidget {
  const ForgetPassword({super.key});

  @override
  ConsumerState<ForgetPassword> createState() => ForgetPasswordState();
}

class ForgetPasswordState extends ConsumerState<ForgetPassword> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController(text: "");

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

  // This is used for display all widgets.
  Widget getBody() {
    return CircularContainer(
      heightSize: Sizes.p05,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Box.gapH4,
            Text(
              Strings.forgetYourPassword,
              style: CustomTextStyle.titleHeaderStyle(),
            ),
            Box.gapH2,
            buildEmailForm(),
            Box.gapH2,
            buildSaveButton(),
          ],
        ),
      ),
    );
  }

  // This [Form] is used for enter email.
  Form buildEmailForm() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          AppTextFormField(
            controller: emailController,
            label: Strings.email,
            validator: Validations.validateEmail,
            textInputAction: TextInputAction.done,
          ),
        ],
      ),
    );
  }

  // This [AppButton] is used for send code to email for reset the password.
  AppButton buildSaveButton() {
    ref.listen<AsyncValue>(resetPasswordControllerProvider, (_, state) {
      state.isLoadingShow(context);
      state.showAlertDialogOnError(context: context, ref: ref);
      if (!state.hasError && state.hasValue && !state.isLoading) {
        state.whenData(
          (result) async {
            final AuthResults resetResult = result;
            if (resetResult is ResetPasswordResultValue) {
              if (resetResult.result != null) {
                final updateStep = resetResult.result!.nextStep.updateStep;
                switch (updateStep) {
                  case AuthResetPasswordStep.confirmResetPasswordWithCode:
                    final codeDetail =
                        resetResult.result!.nextStep.codeDeliveryDetails;
                    ResetPasswordRoute(
                            email: emailController.text,
                            destination: codeDetail?.destination,
                            name: codeDetail!.deliveryMedium.name)
                        .push(context);
                    break;
                  case AuthResetPasswordStep.done:
                    showExceptionAlertDialog(
                      context: context,
                      title: Strings.success,
                      exception: Strings.resetPasswordSuccess,
                    );
                    break;
                }
              }
            }
          },
        );
      }
    });
    return AppButton(
      text: Strings.submit,
      onPress: () async {
        if (!_formKey.currentState!.validate()) return;
        await ref
            .read(resetPasswordControllerProvider.notifier)
            .resetUserPassword(emailController.text);
      },
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }
}
