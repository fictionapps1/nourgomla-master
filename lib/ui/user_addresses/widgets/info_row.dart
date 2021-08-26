import 'package:flutter/material.dart';
import '../../../common_widgets/custom_text.dart';

class InfoRow extends StatelessWidget {
  final String title;
  final String details;

  InfoRow({this.title, this.details});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CustomText(
          text: title,
          size: 18,
          weight: FontWeight.w500,
        ),
        SizedBox(width: 10),
        Expanded(
          child: CustomText(
            textAlign: TextAlign.start,
            text: details,
          ),
        ),
      ],
    );
  }
}
