import 'package:daily_dairy_diary/screens/dashboard.dart';
import 'package:daily_dairy_diary/screens/profile.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';

import '../screens/forget_password.dart';
import '../screens/login.dart';
import '../screens/register.dart';
import '../screens/setting.dart';
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
    return const ForgetPassword();
  }
}

// DashboardRoute
@TypedGoRoute<DashboardRoute>(path: DashboardRoute.path)
class DashboardRoute extends GoRouteData {
  const DashboardRoute();
  static const path = '/dashboard';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const Dashboard();
  }
}

// ProfileRoute
@TypedGoRoute<ProfileRoute>(path: ProfileRoute.path)
class ProfileRoute extends GoRouteData {
  const ProfileRoute();
  static const path = '/profile';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const Profile();
  }
}

// SettingRoute
@TypedGoRoute<SettingRoute>(path: SettingRoute.path)
class SettingRoute extends GoRouteData {
  const SettingRoute();
  static const path = '/setting';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const Setting();
  }
}
