//1
import 'package:daily_dairy_diary/repositories/remember_me_repository.dart';
import 'package:daily_dairy_diary/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'config/aws_amplify.dart';
import 'router/routes.dart';
import 'screens/login.dart';
import 'utils/state_logger.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final sharedPreferences = await SharedPreferences.getInstance();

  await AWSAmplifyConfigure.configureAWSAmplify();
  final container = ProviderContainer(
    overrides: [
      rememberMeRepositoryProvider.overrideWithValue(
        RememberMeRepository(sharedPreferences),
      ),
    ],
  );
  runApp(ProviderScope(
      parent: container, observers: [StateLogger()], child: MyApp()));
}

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();

class MyApp extends ConsumerWidget {
  MyApp({super.key});
  // final notifier = ref.watch(routerListenableProvider.notifier);

  final GoRouter _router = GoRouter(
    navigatorKey: rootNavigatorKey,
    // refreshListenable: notifier,
    initialLocation: LoginRoute.path,
    debugLogDiagnostics: true,
    routes: $appRoutes,
    // redirect: notifier.redirect,
  );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ResponsiveApp(builder: (context) {
      return MaterialApp.router(
        routerConfig: _router,
        title: 'App',
      );
    });
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Builder(builder: (BuildContext context) {
        return const Center(
          child: Login(),
        );
      }),
    );
  }
}
