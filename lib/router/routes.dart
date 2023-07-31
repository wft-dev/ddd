import 'package:daily_dairy_diary/constant/strings.dart';
import 'package:daily_dairy_diary/models/Product.dart';
import 'package:daily_dairy_diary/models/Setting.dart';
import 'package:daily_dairy_diary/screens/add_product.dart';
import 'package:daily_dairy_diary/screens/dashboard.dart';
import 'package:daily_dairy_diary/screens/profile.dart';
import 'package:daily_dairy_diary/screens/report.dart';
import 'package:daily_dairy_diary/screens/reset_password.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';

import '../screens/change_password.dart';
import '../screens/confirm_code.dart';
import '../screens/forget_password.dart';
import '../screens/login.dart';
import '../screens/register.dart';
import '../screens/setting_product.dart';
import '../screens/splash.dart';

part 'routes.g.dart';

// SplashRoute
@TypedGoRoute<SplashRoute>(path: SplashRoute.path)
class SplashRoute extends GoRouteData {
  const SplashRoute();
  static const path = '/splash';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const Splash();
  }
}

// LoginRoute
@TypedGoRoute<LoginRoute>(
  path: LoginRoute.path,
)
class LoginRoute extends GoRouteData {
  const LoginRoute();
  static const path = '/login';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const Login();
  }
}

// RegisterRoute
@TypedGoRoute<RegisterRoute>(path: RegisterRoute.path)
class RegisterRoute extends GoRouteData {
  const RegisterRoute();
  static const path = '/register';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const Register();
  }
}

//ConfirmCodeRoute
@TypedGoRoute<ConfirmCodeRoute>(path: ConfirmCodeRoute.path)
class ConfirmCodeRoute extends GoRouteData {
  ConfirmCodeRoute({this.email = '', this.destination, this.name = ''});
  static const path = '/confirmCode';

  final String email;
  final String? destination;
  final String name;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return ConfirmCode(email, destination, name);
  }
}

//ResetPasswordRoute
@TypedGoRoute<ResetPasswordRoute>(path: ResetPasswordRoute.path)
class ResetPasswordRoute extends GoRouteData {
  ResetPasswordRoute({this.email = '', this.destination, this.name = ''});
  static const path = '/resetPassword';

  final String email;
  final String? destination;
  final String name;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return ResetPassword(email, destination, name);
  }
}

// ForgetPasswordRoute
@TypedGoRoute<ForgetPasswordRoute>(path: ForgetPasswordRoute.path)
class ForgetPasswordRoute extends GoRouteData {
  const ForgetPasswordRoute();
  static const path = '/forgetPassword';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const ForgetPassword();
  }
}

// ChangePasswordRoute
@TypedGoRoute<ChangePasswordRoute>(path: ChangePasswordRoute.path)
class ChangePasswordRoute extends GoRouteData {
  const ChangePasswordRoute();
  static const path = '/changePassword';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const ChangePassword();
  }
}

// MyShellRouteData
@TypedShellRoute<MyShellRouteData>(
  routes: <TypedRoute<RouteData>>[
    TypedGoRoute<DashboardRoute>(path: DashboardRoute.path),
    TypedGoRoute<SettingProductRoute>(path: SettingProductRoute.path),
    TypedGoRoute<ReportRoute>(path: ReportRoute.path),
    TypedGoRoute<ProfileRoute>(path: ProfileRoute.path),
  ],
)
class MyShellRouteData extends ShellRouteData {
  const MyShellRouteData();

  @override
  Widget builder(
    BuildContext context,
    GoRouterState state,
    Widget navigator,
  ) {
    return MyShellRouteScreen(child: navigator);
  }
}

class MyShellRouteScreen extends StatelessWidget {
  const MyShellRouteScreen({required this.child, super.key});

  final Widget child;

  int getCurrentIndex(BuildContext context) {
    final String location = GoRouterState.of(context).location;
    if (location == SettingProductRoute.path) {
      return 1;
    }
    if (location == ProfileRoute.path) {
      return 2;
    }
    if (location == ReportRoute.path) {
      return 3;
    }
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    final int currentIndex = getCurrentIndex(context);
    return Scaffold(
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.dashboard,
              size: 20,
            ),
            label: Strings.dashboard,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.settings,
              size: 20,
            ),
            label: Strings.setting,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person_2,
              size: 20,
            ),
            label: Strings.profile,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.report,
              size: 20,
            ),
            label: Strings.report,
          ),
        ],
        onTap: (int index) {
          switch (index) {
            case 0:
              const DashboardRoute().go(context);
              break;
            case 1:
              const SettingProductRoute().go(context);
              break;
            case 2:
              const ProfileRoute().go(context);
              break;
            case 3:
              const ReportRoute().go(context);
              break;
          }
        },
      ),
    );
  }
}

// DashboardRoute
class DashboardRoute extends GoRouteData {
  const DashboardRoute();
  static const path = '/dashboard';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const Dashboard();
  }
}

// ProfileRoute
class ProfileRoute extends GoRouteData {
  const ProfileRoute();
  static const path = '/profile';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const Profile();
  }
}

// SettingProductRoute
class SettingProductRoute extends GoRouteData {
  const SettingProductRoute();
  static const path = '/settingProduct';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const SettingProduct();
  }
}

// ReportRoute
class ReportRoute extends GoRouteData {
  const ReportRoute();
  static const path = '/report';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const Report();
  }
}

// AddProduct
@TypedGoRoute<AddProductRoute>(path: AddProductRoute.path)
class AddProductRoute extends GoRouteData {
  AddProductRoute({this.$extra});
  static const path = '/addProduct';
  final Product? $extra;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return AddProduct($extra);
  }
}
