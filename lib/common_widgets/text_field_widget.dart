import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'corners.dart';
import '../helpers/hex_color.dart';

class TextFieldWidget extends StatelessWidget {
  final String hint;

  /// Is the height of container box.
  /// Default is 15
  final double height;

  /// Is the height of container box.
  /// Default is 15
  final double width;

  /// Is the font size of the text.
  /// default is 14
  final double fontSize;

  final TextEditingController textEditingController;

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

  /// Is the color of text.
  /// Default is FFFFFF
  final String textColor;

  /// Is the color of the main container box.
  /// Default is FFFFFF
  final String containerColor;

  /// Function Onchange
  final Function onChanged;

  /// Controller
  final TextEditingController controller;
  final TextInputType inputType;

  final double contentPadding;

  final bool enable;
  final IconData icon;
  final int maxLines;
  final int maxChar;
  final String initVal;
  final Function(String val) validator;
  final Function(String val) onSaved;

  const TextFieldWidget({
    this.hint,
    this.height = 50,
    this.width = 100,
    this.fontSize = 14,
    this.alignmentXY = const [0.5, 0.5],
    this.position = 'down',
    this.corners = const Corners(),
    this.containerColor = 'FFFFFF',
    this.textColor = 'FFFFFF',
    this.textEditingController,
    this.onChanged,
    this.enable,
    this.controller,
    this.contentPadding,
    this.icon,
    this.inputType,
    this.maxLines,
    this.initVal,
    this.maxChar,
    this.validator,
    this.onSaved,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: HexColor(containerColor).withOpacity(.5),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(corners.topLeft),
          topRight: Radius.circular(corners.topRight),
          bottomLeft: Radius.circular(corners.bottomLeft),
          bottomRight: Radius.circular(corners.bottomRight),
        ),
      ),
      child: Container(
        // color: Colors.red,
        child: TextFormField(
          validator: validator,
          keyboardType: inputType,
          controller: controller,
          enabled: enable,
          maxLines: maxLines ?? 1,
          initialValue: initVal,
          onSaved: onSaved,
          decoration: InputDecoration(
            prefixIcon: icon != null ? Icon(Icons.search) : SizedBox(),
            hintText: hint,
            contentPadding:
                contentPadding != null ? EdgeInsets.all(contentPadding) : null,
            enabledBorder: InputBorder.none,
            hintStyle: TextStyle(color: Colors.black54),
            border: InputBorder.none,
          ),
          onChanged: onChanged,
        ),
      ),
    );
  }
}
