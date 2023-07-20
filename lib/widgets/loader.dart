import 'package:flutter/material.dart';

class Loader extends StatelessWidget {
  const Loader(
      {Key? key,
      this.opacity = 1,
      this.dismissible = false,
      this.color = Colors.black,
      this.loadingTxt = 'Loading...'})
      : super(key: key);

  final double opacity;
  final bool dismissible;
  final Color color;
  final String loadingTxt;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Opacity(
          opacity: opacity,
          child: const ModalBarrier(dismissible: false, color: Colors.black),
        ),
        Center(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.only(left: 16, top: 16, right: 16),
              child: CircularProgressIndicator(),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(loadingTxt),
            )
          ],
        )),
      ],
    );
  }
}
