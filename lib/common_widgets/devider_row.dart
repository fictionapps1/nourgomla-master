import 'package:flutter/material.dart';
import 'custom_text.dart';

class DividerRow extends StatelessWidget {
  final String text;

  DividerRow(this.text);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: Divider(
              thickness: 1.5,
            )),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: CustomText(text: text, size: 20, weight: FontWeight.w500),
        ),
        Expanded(
            child: Divider(
              thickness: 1.5,
            )),
      ],
    );
  }
}