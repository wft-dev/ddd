import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:daily_dairy_diary/models/Product.dart';
import 'package:daily_dairy_diary/screens/add_product.dart';
import 'package:daily_dairy_diary/screens/dashboard.dart';
import 'package:daily_dairy_diary/screens/profile.dart';
import 'package:daily_dairy_diary/screens/report.dart';
import 'package:daily_dairy_diary/screens/reset_password.dart';
import 'package:daily_dairy_diary/screens/change_email.dart';
import 'package:daily_dairy_diary/utils/common_utils.dart';
import 'package:daily_dairy_diary/screens/change_password.dart';
import 'package:daily_dairy_diary/screens/confirm_code.dart';
import 'package:daily_dairy_diary/screens/forget_password.dart';
import 'package:daily_dairy_diary/screens/login.dart';
import 'package:daily_dairy_diary/screens/register.dart';
import 'package:daily_dairy_diary/screens/setting_product.dart';
import 'package:daily_dairy_diary/screens/splash.dart';

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
  ConfirmCodeRoute({
    this.email = '',
    this.destination,
    this.name = '',
    this.password = '',
  });
  static const path = '/confirmCode';

  final String email;
  final String? destination;
  final String name;
  final String password;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return ConfirmCode(email, destination, name, password);
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

  // Get current index form selected location.
  int getCurrentIndex(BuildContext context) {
    final String location = GoRouterState.of(context).location;
    if (location == ReportRoute.path) {
      return 1;
    }
    if (location == SettingProductRoute.path) {
      return 2;
    }
    if (location == ProfileRoute.path) {
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
        backgroundColor: AppColors.alphaPurpleColor,
        selectedItemColor: AppColors.whiteColor,
        unselectedItemColor: AppColors.dimPurpleColor,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        currentIndex: currentIndex,
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          buildBottomBarItem(
              checkSelectedIndex(currentIndex, 0), AppImages.homeImage),
          buildBottomBarItem(
              checkSelectedIndex(currentIndex, 1), AppImages.reportsImage),
          buildBottomBarItem(
              checkSelectedIndex(currentIndex, 2), AppImages.settingsImage),
          buildBottomBarItem(
              checkSelectedIndex(currentIndex, 3), AppImages.userImage),
        ],
        onTap: (int index) {
          switch (index) {
            case 0:
              const DashboardRoute().go(context);
              break;
            case 1:
              const ReportRoute().go(context);
              break;
            case 2:
              const SettingProductRoute().go(context);
              break;
            case 3:
              const ProfileRoute().go(context);
              break;
          }
        },
      ),
    );
  }

  // Check current index match with the selected index.
  bool checkSelectedIndex(int currentIndex, int selectedIndex) {
    return currentIndex == selectedIndex ? true : false;
  }

  // [BottomNavigationBarItem] is used to show bottom icon without label.
  BottomNavigationBarItem buildBottomBarItem(
      bool isBarSelected, String imageName) {
    return BottomNavigationBarItem(
      icon: Container(
        height: Sizes.p8.sh,
        width: Sizes.p11.sw,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isBarSelected
              ? AppColors.darkPurpleColor
              : AppColors.alphaPurpleColor,
        ),
        child: ImageIcon(
          AssetImage(imageName),
          size: Sizes.p10,
        ),
      ),
      label: '',
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

//ChangeEmailRoute
@TypedGoRoute<ChangeEmailRoute>(path: ChangeEmailRoute.path)
class ChangeEmailRoute extends GoRouteData {
  ChangeEmailRoute({this.destination, this.name = ''});
  static const path = '/changeEmail';

  final String? destination;
  final String name;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return ChangeEmail(destination, name);
  }
}
