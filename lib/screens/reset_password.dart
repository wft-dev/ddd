import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_builder/responsive_builder.dart';

import 'package:daily_dairy_diary/constant/strings.dart';
import 'package:daily_dairy_diary/models/auth_results.dart';
import 'package:daily_dairy_diary/provider/confirm_reset_password_controller.dart';
import 'package:daily_dairy_diary/utils/common_utils.dart';
import 'package:daily_dairy_diary/widgets/all_widgets.dart';

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
    return HideKeyboardWidget(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          elevation: Sizes.p0,
          backgroundColor: AppColors.transparentColor,
          iconTheme: IconThemeData(color: AppColors.darkPurpleColor),
        ),
        body: getBody(),
      ),
    );
  }

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
                buildChangePasswordForm(),
                Box.gapH2,
                buildSaveButton(),
                Box.gapH2,
              ],
            ),
          ],
        ),
      ),
    );
  }

  // This [Form] is used for enter code and new password for reset the password.
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
            obscure: true,
            validator: (value) => Validations.validatePassword(
                value, Strings.newPassword.toLowerCase()),
            textInputAction: TextInputAction.done,
          ),
        ],
      ),
    );
  }

  // This [AppButton] is used for confirm the reset password.
  AppButton buildSaveButton() {
    ref.listen<AsyncValue>(confirmResetPasswordControllerProvider, (_, state) {
      state.showAlertDialogOnError(context: context, ref: ref);
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
                widget.email, newPasswordController.text, codeController.text);
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
