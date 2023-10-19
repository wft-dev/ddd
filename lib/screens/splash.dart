import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:daily_dairy_diary/utils/common_utils.dart';
import 'package:daily_dairy_diary/router/routes.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  SplashState createState() => SplashState();
}

class SplashState extends State<Splash> with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: Duration(seconds: Sizes.p2.toInt()),
    vsync: this,
  )..repeat(reverse: false);
  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.easeInCubic,
  );
  Timer? timer;

  @override
  void initState() {
    super.initState();
    timer = Timer(const Duration(seconds: Sizes.pInt1), () {
      FlutterNativeSplash.remove();
    });
    timer = Timer(Duration(seconds: Sizes.p2.toInt()), () {
      const LoginRoute().go(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(AppImages.bgImage),
          fit: BoxFit.fill,
        ),
      ),
      child: animatedLogoWidget(),
    );
  }

  // Show animated logo on the top of the splash background.
  Widget animatedLogoWidget() {
    return FadeTransition(
      opacity: _animation,
      child: Container(
        alignment: Alignment.center,
        child: SizedBox(
          width: Sizes.p30.sh,
          height: Sizes.p30.sh,
          child: Image.asset(AppImages.logoImage, fit: BoxFit.cover),
        ),
      ),
    );
  }

  @override
  void dispose() {
    timer?.cancel();
    _controller.dispose();
    super.dispose();
  }
}
