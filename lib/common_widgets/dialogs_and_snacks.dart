import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import '../controllers/rating_controller.dart';
import '../models/rate.dart';
import '../controllers/settings_controller.dart';
import 'custom_text.dart';
import 'custom_textfield.dart';

showErrorDialog(String errMsg) {
  Get.defaultDialog(
      backgroundColor: Colors.white,
      radius: 20,
      title: 'error'.tr,
      content: CustomText(text: errMsg),
      actions: [
        TextButton(
            onPressed: () {
              Get.back();
            },
            child: Text('ok'.tr))
      ]);
}

showRatingDialog(
    {RatingController ratingCon, int productId, Rate rateToUpdate}) {
  final SettingsController _settingsCon = Get.find<SettingsController>();
  ratingCon.msg.value = '';
  if (rateToUpdate != null) {
    ratingCon.comment.value = rateToUpdate.comment;
    ratingCon.rating.value = rateToUpdate.rate.toDouble();
  }
  Get.defaultDialog(
      title: 'rate_product'.tr,
      actions: [
        RoundedLoadingButton(
          child:
              Text('confirm_rating'.tr, style: TextStyle(color: Colors.white)),
          controller: ratingCon.btnController,
          height: 40,
          width: 120,
          onPressed: () {
            if (productId != null) {
              ratingCon.submitRating(productId);
            } else {
              ratingCon.rateToUpdate = rateToUpdate;
              ratingCon.updateRating();
            }
          },
          color: _settingsCon.color2,
        ),
      ],
      content: Obx(
        () => Column(
          children: [
            RatingBar.builder(
              initialRating: ratingCon.rating.value,
              minRating: 1,
              itemCount: 5,
              itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (context, _) => Icon(
                Icons.star,
                color: Colors.amber,
              ),
              onRatingUpdate: (rating) {
                ratingCon.changeRating(rating);
                print(rating);
              },
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: CustomTextField(
                initVal: rateToUpdate?.comment,
                onChanged: (val) {
                  ratingCon.comment.value = val;
                },
                maxLines: 3,
                label: "enter_comment".tr,
                keyboardType: TextInputType.multiline,
              ),
            ),
            if (ratingCon.msg.value != '') ...{
              CustomText(
                text: ratingCon.msg.value,
                color: ratingCon.success.value ? Colors.green : Colors.red,
              ),
            },
          ],
        ),
      ));
}

showNormalDialog(
    {String title,
    String msg,
    Function onTapped,
    String buttonText,
    bool dismissible = true}) {
  Get.defaultDialog(
      barrierDismissible: dismissible,
      radius: 20,
      title: title,
      content: CustomText(text: msg),
      actions: [
        TextButton(
            onPressed: onTapped ??
                () {
                  Get.back();
                },
            child: Text(buttonText ?? 'ok'.tr))
      ]);
}

showTwoButtonsDialog(
    {String title,
    String msg,
    Function onOkTapped,
    Function onCancelTapped,
    String okText,
    barrierDismissible,
    String cancelText}) {
  Get.defaultDialog(
      barrierDismissible: barrierDismissible ?? true,
      radius: 20,
      title: title ?? '',
      content: CustomText(
        text: msg,
        color: Colors.green,
      ),
      actions: [
        FlatButton(
            color: Colors.green[100],
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            onPressed: onOkTapped ??
                () {
                  Get.back();
                },
            child: Text(okText ?? 'ok'.tr)),
        FlatButton(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            color: Colors.red[100],
            onPressed: onCancelTapped ??
                () {
                  Get.back();
                },
            child: Text(cancelText ?? 'cancel'.tr))
      ]);
}

showSnack(String msg) {
  SettingsController _settingsController = Get.find<SettingsController>();
  Get.showSnackbar(GetBar(
    messageText: CustomText(text: msg),
    backgroundColor: _settingsController.color2,
    duration: Duration(seconds: 2),
    animationDuration: Duration(milliseconds: 200),
  ));
}

showLoadingDialog() {
  Get.defaultDialog(
    radius: 20,
    title: '',
    barrierDismissible: false,
    content: Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: CircularProgressIndicator(),
          ),
          CustomText(text: 'Loading ...'),
        ],
      ),
    ),
  );
}
