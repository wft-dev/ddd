import 'package:daily_dairy_diary/provider/confirm_email_controller.dart';
import 'package:daily_dairy_diary/provider/resend_email_code_controller.dart';
import 'package:daily_dairy_diary/provider/update_user_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../constant/strings.dart';
import '../models/auth_results.dart';
import '../provider/update_password_controller.dart';
import '../utils/common_utils.dart';
import '../widgets/all_widgets.dart';

class ChangeEmail extends ConsumerStatefulWidget {
  const ChangeEmail(this.destination, this.name, {Key? key}) : super(key: key);
  final String? destination;
  final String name;

  @override
  ConsumerState<ChangeEmail> createState() => ChangeEmailState();
}

class ChangeEmailState extends ConsumerState<ChangeEmail> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController confirmCodeController =
      TextEditingController(text: "");

  @override
  Widget build(BuildContext context) {
    return ScaffoldAppBar(
      barTitle: Strings.emailChanged,
      child: getBody(),
    );
  }

  // This is used for display all widgets.
  Widget getBody() {
    return Container(
      height: ResponsiveAppUtil.height * Sizes.p01.sh,
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius:
            BorderRadius.vertical(bottom: Radius.circular(Sizes.p12.sw)),
      ),
      child: SingleChildScrollView(
        padding: EdgeInsets.only(
            bottom: Sizes.p4.sh, left: Sizes.p5.sw, right: Sizes.p5.sw),
        child: buildRoundedContainer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Box.gapH2,
              Text(
                textAlign: TextAlign.center,
                Strings.changeEmail,
                style: CustomTextStyle.titleHeaderStyle()
                    .copyWith(fontSize: Sizes.p6.sw, color: AppColors.redColor),
              ),
              Box.gapH2,
              Text(
                textAlign: TextAlign.center,
                Strings.confirmationMessage(widget.destination, widget.name),
                style: CustomTextStyle.titleHeaderStyle()
                    .copyWith(fontSize: Sizes.p5.sw),
              ),
              Box.gapH2,
              buildForm(),
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
        ),
      ),
    );
  }

  // This [Form] display code.
  Form buildForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          AppTextFormField(
            controller: confirmCodeController,
            label: Strings.code,
            validator: Validations.validateOTP,
            textInputAction: TextInputAction.next,
          ),
        ],
      ),
    );
  }

  // This [AppButton] is used for confirm the code.
  AppButton buildConfirmCodeButton() {
    ref.listen<AsyncValue>(confirmEmailControllerProvider, (_, state) {
      state.showAlertDialogOnError(context);
      if (!state.hasError && state.hasValue && !state.isLoading) {
        state.whenData(
          (result) async {
            final AuthResults confirmEmailResult = result;
            if (confirmEmailResult is ConfirmEmailResultValue) {
              ref.invalidate(updateUserControllerProvider);
              showAlertActionDialog(
                context: context,
                title: Strings.success,
                content: Strings.successMessage(
                    Strings.email, ActionType.update.name),
                onYesPress: () => context.pop(),
              );
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
            .read(confirmEmailControllerProvider.notifier)
            .confirmEmailWithCode(confirmCodeController.text);
      },
    );
  }

  // This [AppButton] is used for resend the confirmation the code.
  AppButton buildResendCodeButton() {
    ref.listen<AsyncValue>(resendEmailCodeControllerProvider, (_, state) {
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
            .read(resendEmailCodeControllerProvider.notifier)
            .resendSignUpUserCode();
      },
    );
  }

  @override
  void dispose() {
    confirmCodeController.dispose();
    super.dispose();
  }
}
