import 'dart:async';
import 'package:flutter/material.dart';

import '../router/routes.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  SplashState createState() => SplashState();
}

class SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () => const LoginRoute().go(context));
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Text('splash'),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
