import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../constant/strings.dart';
import '../models/auth_results.dart';
import '../provider/reset_password_controller.dart';
import '../repositories/auth_repository.dart';
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
    return Scaffold(
        appBar: AppBar(
          title: const Text(Strings.changePassword),
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
            buildChangePasswordForm(),
            buildSaveButton(),
          ],
        ),
      ),
    );
  }

  Form buildChangePasswordForm() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          AppTextFormField(
            controller: emailController,
            label: Strings.email,
            validator: Validations.validateEmail,
            textInputAction: TextInputAction.next,
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            alignment: Alignment.center,
            child: ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  // await ref.read(authRepositoryProvider).resetPassword(
                  //       emailController.text,
                  //     );
                }
              },
              child: const Text('Submit'),
            ),
          ),
        ],
      ),
    );
  }

  AppButton buildSaveButton() {
    ref.listen<AsyncValue>(resetPasswordControllerProvider, (_, state) {
      state.showAlertDialogOnError(context);
      if (!state.hasError && state.hasValue && !state.isLoading) {
        state.whenData(
          (result) async {
            final AuthResults resetResult = result;
            if (resetResult is ResetPasswordResultValue) {
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
          },
        );
      }
    });
    return AppButton(
      text: Strings.save,
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
