import 'package:daily_dairy_diary/provider/login_controller.dart';
import 'package:daily_dairy_diary/provider/remember_me_controller.dart';
import 'package:daily_dairy_diary/repositories/remember_me_repository.dart';
import 'package:flutter/material.dart';
import 'package:daily_dairy_diary/router/routes.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../constant/strings.dart';
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
            validator: Validations.validatePassword,
            textInputAction: TextInputAction.done,
          ),
        ],
      ),
    );
  }

  AppButton buildButton() {
    ref.listen<AsyncValue>(loginControllerProvider, (_, state) {
      state.showAlertDialogOnError(context);
    });
    return AppButton(
      text: Strings.login,
      onPress: () async {
        if (!_formKey.currentState!.validate()) return;
        await ref
            .read(loginControllerProvider.notifier)
            .logInUser(emailController.text, passwordController.text);
        // ignore: use_build_context_synchronously
        const ProfileRoute().go(context);
      },
    );
  }

  AppCheckbox buildRememberCheckbox() {
    // final state = ref.watch(rememberMeControllerProvider);
    // ref.listen<AsyncValue>(
    //   rememberMeControllerProvider,
    //   (_, state) => state.showAlertDialogOnError(context),
    // );
    // print("state ${state.isLoading}");

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
