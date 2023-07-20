import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../constant/strings.dart';
import '../models/auth_results.dart';
import '../provider/update_password_controller.dart';
import '../utils/common_utils.dart';
import '../widgets/all_widgets.dart';

class ChangePassword extends ConsumerStatefulWidget {
  const ChangePassword({super.key});
  @override
  ConsumerState<ChangePassword> createState() => ChangePasswordState();
}

class ChangePasswordState extends ConsumerState<ChangePassword> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController oldPasswordController =
      TextEditingController(text: "");
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
        children: <Widget>[
          AppTextFormField(
            controller: oldPasswordController,
            label: Strings.oldPassword,
            validator: (value) => Validations.validatePassword(
                value, Strings.oldPassword.toLowerCase()),
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
    ref.listen<AsyncValue>(updatePasswordControllerProvider, (_, state) {
      state.showAlertDialogOnError(context);
      if (!state.hasError && state.hasValue && !state.isLoading) {
        state.whenData(
          (result) async {
            final AuthResults passwordResult = result;
            if (passwordResult is UpdatePasswordResultValue) {
              showExceptionAlertDialog(
                context: context,
                title: Strings.success,
                exception: Strings.passwordUpdate,
              );
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
            .read(updatePasswordControllerProvider.notifier)
            .updateUserPassword(
                oldPasswordController.text, newPasswordController.text);
      },
    );
  }

  @override
  void dispose() {
    oldPasswordController.dispose();
    newPasswordController.dispose();
    super.dispose();
  }
}
