import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:daily_dairy_diary/utils/common_utils.dart';
import 'package:daily_dairy_diary/widgets/all_widgets.dart';
import 'package:flutter/material.dart';

// This widget is used to display the [CachedNetworkImage] widget.
class CircularImage extends StatelessWidget {
  final String imageURL;
  final double size;
  final Color borderColor;
  final BoxFit fit;
  final double borderWidth;
  final bool isImageSelected;

  const CircularImage({
    super.key,
    required this.imageURL,
    required this.size,
    required this.borderColor,
    this.fit = BoxFit.fill,
    this.borderWidth = 2,
    this.isImageSelected = false,
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
            child: isImageSelected == true
                ? Image.file(
                    File(imageURL),
                    fit: fit,
                  )
                : CachedNetworkImage(
                    imageUrl: imageURL,
                    fit: fit,
                    placeholder: (context, url) => Container(
                      alignment: Alignment.center,
                      child:
                          buildCircularProgressIndicator(), // you can add pre loader image as well to show loading.
                    ),
                    errorWidget: (context, url, dynamic error) => Icon(
                        Icons.camera_alt_rounded,
                        color: AppColors.darkPurpleColor),
                  ),
          ),
        ),
      ),
    );
  }
}
