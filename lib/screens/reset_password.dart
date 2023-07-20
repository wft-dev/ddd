import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../constant/strings.dart';
import '../models/auth_results.dart';
import '../provider/confirm_reset_password_controller.dart';
import '../repositories/auth_repository.dart';
import '../utils/common_utils.dart';
import '../widgets/all_widgets.dart';

class ResetPassword extends ConsumerStatefulWidget {
  const ResetPassword(this.email, this.destination, this.name, {Key? key})
      : super(key: key);
  final String? destination;
  final String name;
  final String email;

  @override
  ConsumerState<ResetPassword> createState() => ResetPasswordState();
}

class ResetPasswordState extends ConsumerState<ResetPassword> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController codeController = TextEditingController(text: "");
  final TextEditingController newPasswordController =
      TextEditingController(text: "");

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
              Strings.confirmationMessage(widget.destination, widget.name),
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
        children: <Widget>[
          AppTextFormField(
            controller: codeController,
            label: Strings.code,
            validator: Validations.validateOTP,
            textInputAction: TextInputAction.next,
          ),
          AppTextFormField(
            controller: newPasswordController,
            label: Strings.newPassword,
            validator: (value) => Validations.validatePassword(
                value, Strings.newPassword.toLowerCase()),
            textInputAction: TextInputAction.done,
          ),
        ],
      ),
    );
  }

  AppButton buildSaveButton() {
    ref.listen<AsyncValue>(confirmResetPasswordControllerProvider, (_, state) {
      state.showAlertDialogOnError(context);
      if (!state.hasError && state.hasValue && !state.isLoading) {
        state.whenData(
          (result) async {
            final AuthResults resetResult = result;
            if (resetResult is ResetPasswordResultValue) {
              if (resetResult.result!.isPasswordReset) {
                showExceptionAlertDialog(
                  context: context,
                  title: Strings.success,
                  exception: Strings.resetPasswordSuccess,
                );
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
            .read(confirmResetPasswordControllerProvider.notifier)
            .confirmUserResetPassword(
                widget.email, codeController.text, newPasswordController.text);
      },
    );
  }

  @override
  void dispose() {
    codeController.dispose();
    newPasswordController.dispose();
    super.dispose();
  }
}
