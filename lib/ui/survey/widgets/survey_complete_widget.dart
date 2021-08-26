import 'package:flutter/material.dart';
import '../../../common_widgets/cached_image.dart';
import '../../../common_widgets/custom_text.dart';
import 'package:get/get.dart';
class SurveyCompleteWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CachedImage(
            'https://cdn1.iconfinder.com/data/icons/youtuber/256/thumbs-up-like-gesture-512.png',
            height: 200,
            notFromOurApi: true,
            width: 200,
          ),
          CustomText(
              text: 'survey_done'.tr,
              size: 25,
              weight: FontWeight.bold,
              color: Colors.green),
        ],
      ),
    );
  }
}