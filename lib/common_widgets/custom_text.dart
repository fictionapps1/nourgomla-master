import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;
  final double size;
  final Color color;
  final FontWeight weight;
  final String fontFamily;
  final TextAlign textAlign;
  final double lineSpacing;
  final TextDecoration decoration;

  CustomText(
      {@required this.text,
      this.size,
      this.color,
      this.weight,
      this.fontFamily,
      this.textAlign,
      this.lineSpacing,
      this.decoration});

  @override
  Widget build(BuildContext context) {
    return Text(
      text ?? '',
      textAlign: textAlign ?? TextAlign.center,
      overflow: TextOverflow.ellipsis,
      maxLines: 4,
      style: TextStyle(
        height: lineSpacing ?? null,
        fontSize: size ?? null,
        color: color,
        fontWeight: weight ?? FontWeight.normal,
        fontFamily: fontFamily,
        decoration: decoration,

      ),
    );
  }
}
