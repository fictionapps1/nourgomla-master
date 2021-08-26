import 'package:flutter/material.dart';
import '../../../common_widgets/custom_text.dart';

class AreaRow extends StatelessWidget {
  final int cost;
  final String area;
  final Function onTap;

  AreaRow({this.cost, this.area, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: 40,
          color: Colors.grey[200],
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(text: area),
                CustomText(text: '$cost'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
