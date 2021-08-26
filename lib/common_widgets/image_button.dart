import 'package:flutter/material.dart';
import 'cached_image.dart';

class ImageButton extends StatelessWidget {
  final double width;
  final double height;
  final double padding;
  final double borderRadius;
  final String imageUrl;
  final Function() onPressed;
  final BoxFit boxFit;

  const ImageButton({
     this.width,
     this.height,
    @required this.borderRadius,
    @required this.imageUrl,
    @required this.onPressed,
    @required this.boxFit, this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: Container(
          margin: EdgeInsets.all(padding??8),
          width: width,
          height: height,
          // child: Image.network(
          //   imageUrl,
          //   fit: boxFit,
          // ),
          child: CachedImage(
            imageUrl,
            height: height,
            width: width,
            fit: boxFit,
            radius: borderRadius,
          ),
        ),
      ),
    );
  }
}
