import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CircularImage extends StatelessWidget {
  final String imageURL;
  final double size;
  final Color borderColor;
  final BoxFit fit;
  final double borderWidth;

  const CircularImage({
    super.key,
    required this.imageURL,
    required this.size,
    required this.borderColor,
    this.fit = BoxFit.fill,
    this.borderWidth = 2,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: borderColor,
        shape: BoxShape.circle,
      ),
      child: Padding(
        padding: EdgeInsets.all(borderWidth),
        child: Container(
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white, // inner circle color
          ),
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(300.0)),
            child: imageURL != ''
                ? Image.asset(
                    imageURL,
                    fit: fit,
                  )
                : CachedNetworkImage(
                    imageUrl: imageURL,
                    fit: fit,
                    errorWidget: (context, url, dynamic error) =>
                        const Icon(Icons.camera_alt_rounded),
                  ),
          ),
        ),
      ),
    );
  }
}
