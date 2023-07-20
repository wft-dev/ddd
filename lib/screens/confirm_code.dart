import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
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
    return Scaffold(
      appBar: AppBar(
        title: const Text(Strings.confirmCode),
      ),
      body: Form(
        key: _formKey,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                Strings.confirmationMessage(widget.destination, widget.name),
                style: CustomTextStyle.loginTitleStyle().copyWith(fontSize: 18),
              ),
              AppTextFormField(
                controller: codeController,
                label: Strings.code,
                validator: Validations.validateOTP,
                textInputAction: TextInputAction.next,
              ),
              buildConfirmCodeButton(),
              SizedBox(height: Sizes.p2.sh),
              Text(
                Strings.resendVerifyCode,
                style: CustomTextStyle.loginTitleStyle().copyWith(fontSize: 18),
              ),
            ],
          ),
        ),
      ),
    );
  }

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

  @override
  void dispose() {
    codeController.dispose();
    super.dispose();
  }
}
