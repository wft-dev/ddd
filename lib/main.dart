import 'package:daily_dairy_diary/constant/constant.dart';
import 'package:daily_dairy_diary/repositories/remember_me_repository.dart';
import 'package:daily_dairy_diary/widgets/loading_overlay.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'config/aws_amplify.dart';
import 'router/router_listenable.dart';
import 'router/routes.dart';
import 'utils/state_logger.dart';

Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  final sharedPreferences = await SharedPreferences.getInstance();

  await AWSAmplifyConfigure.configureAWSAmplify();
  final container = ProviderContainer(
    overrides: [
      rememberMeRepositoryProvider.overrideWithValue(
        RememberMeRepository(sharedPreferences),
      ),
    ],
  );
  runApp(
    ProviderScope(
        parent: container, observers: [StateLogger()], child: const MyApp()),
  );
}

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();

// Root of the app.
class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  GoRouter _router(notifier) => GoRouter(
        navigatorKey: rootNavigatorKey,
        refreshListenable: notifier,
        initialLocation: SplashRoute.path,
        debugLogDiagnostics: true,
        routes: $appRoutes,
        redirect: notifier.redirect,
      );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.watch(routerListenableProvider.notifier);

    return ResponsiveApp(builder: (context) {
      return MaterialApp.router(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(fontFamily: Fonts.mPLUSRoundedBlack),
        routerConfig: _router(notifier),
        builder: (context, child) => LoadingOverlay(child: child!),
      );
    });
  }
}
