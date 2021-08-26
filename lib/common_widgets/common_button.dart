import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'corners.dart';
import '../helpers/hex_color.dart';

class CommonButton extends StatelessWidget {
  /// Is the height of container box.
  /// Default is 15
  final double height;

  /// Is the height of container box.
  /// Default is 15
  final double width;

  /// Is the font size of the text.
  /// default is 14
  final double fontSize;

  /// Is an array of dx and dy positions
  /// Top is 0 dy, Center is 0.5 dy and Bottom is 1.0 dy
  /// left is 0.0 dx, Center is 0.5 dx and Right is 1.0 dx
  /// Default is [0.5,0.5] Centered
  final List<double> alignmentXY;

  /// Is the position of the text below or above the image
  final String position;

  /// is the corners of the box.
  /// starting from topLeft, topRight, bottomLeft and bottomRight
  final Corners corners;

  /// Is the text to be displayed in the box
  final String text;

  /// Is the color of text.
  /// Default is FFFFFF
  final String textColor;

  /// Is the color of the main container box.
  /// Default is FFFFFF
  final Color containerColor;

  /// Is the image source which will be inside the container box
  final String imageSource;

  /// A function to be triggered when the user click on the box
  final Function onTap;

  CommonButton({
    this.height = 70,
    this.width = 100,
    this.fontSize = 14,
    this.alignmentXY = const [0.5, 0.5],
    this.position = 'down',
    this.corners = const Corners(),
    this.containerColor = Colors.green,
    this.textColor = 'FFFFFF',
    this.imageSource,
    @required this.text,
    @required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: FittedBox(
        child: Container(
          width: width,
          height: height,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            color: containerColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(corners.topLeft),
              topRight: Radius.circular(corners.topRight),
              bottomLeft: Radius.circular(corners.bottomLeft),
              bottomRight: Radius.circular(corners.bottomRight),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            verticalDirection: position == 'down'
                ? VerticalDirection.down
                : VerticalDirection.up,
            children: [
              if (imageSource != null) ...[
                CachedNetworkImage(
                  imageUrl: imageSource,
                  fit: BoxFit.fill,
                  memCacheHeight: height.round(),
                  memCacheWidth: width.round(),
                  height: height * 0.40,
                  width: width,
                ),
                SizedBox(height: 3),
              ],
              Align(
                alignment: FractionalOffset(alignmentXY[0], alignmentXY[1]),
                child: Text(
                  text,
                  overflow: TextOverflow.fade,
                  style: TextStyle(
                    color: HexColor(textColor),
                    fontSize: fontSize,
                  ),
                ),
              ),
              SizedBox(height: 3),
            ],
          ),
        ),
      ),
    );
  }
}
