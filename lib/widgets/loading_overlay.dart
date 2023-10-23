import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:daily_dairy_diary/utils/common_utils.dart';
import 'package:daily_dairy_diary/widgets/common_widget.dart';

// This [LoadingOverlay] class is used to load the [ProgressIndicator] on the widgets.
class LoadingOverlay extends StatefulWidget {
  const LoadingOverlay({
    Key? key,
    this.child,
    this.isLoading = false,
    this.delay = const Duration(milliseconds: 0),
  }) : super(key: key);

  final Widget? child;
  final Duration delay;
  final bool isLoading;

  static LoadingOverlayState? of(BuildContext context) {
    return context.findAncestorStateOfType<LoadingOverlayState>();
  }

  @override
  State<LoadingOverlay> createState() => LoadingOverlayState();
}

class LoadingOverlayState extends State<LoadingOverlay> {
  bool _isLoading = false;

  // Show the loading overlay if the state is loading.
  void show() {
    setState(() {
      _isLoading = true;
    });
  }

  // Hide the loading overlay if the state is not loading.
  void hide() {
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return buildProgress();
  }

  // Build LoadingOverlay.
  buildProgress() {
    return Stack(
      children: [
        widget.child ?? Container(),
        if (widget.isLoading || _isLoading)
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: Sizes.p4, sigmaY: Sizes.p4),
            child: Opacity(
              opacity: Sizes.p02,
              child: ModalBarrier(
                  dismissible: false, color: AppColors.darkPurpleColor),
            ),
          ),
        if (widget.isLoading || _isLoading)
          Center(
            child: FutureBuilder(
              future: Future.delayed(widget.delay),
              builder: (context, snapshot) {
                return snapshot.connectionState == ConnectionState.done
                    ? buildCircularProgressIndicator()
                    : const SizedBox();
              },
            ),
          ),
      ],
    );
  }
}
