import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import '../controllers/language_controller.dart';
import '../controllers/rating_controller.dart';
import '../models/rate.dart';
import '../responsive_setup/responsive_builder.dart';
import 'custom_text.dart';
import 'dialogs_and_snacks.dart';

class RatingWithCommentWidget extends StatelessWidget {
  final LanguageController _lanCon = Get.find<LanguageController>();
  final Rate rate;
  final double padding;
  final bool isUserRates;

  RatingWithCommentWidget(
      {this.rate, this.padding = 0, this.isUserRates = false});
  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(builder: (context, sizingInfo) {
      return Padding(
        padding: EdgeInsets.all(padding),
        child: Container(
          width: sizingInfo.screenWidth - 35,
          child: Card(
            elevation: 0.3,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      isUserRates
                          ? Container(
                              width: sizingInfo.screenWidth / 2.3,
                              child: Text(
                                _lanCon.lang == 'ar'
                                    ? rate.productNameAr
                                    : rate.productNameEn,
                                textAlign: TextAlign.start,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            )
                          : CustomText(
                              text: rate.userName, weight: FontWeight.bold),
                      RatingBarIndicator(
                        rating: rate.rate.toDouble(),
                        itemBuilder: (context, index) => Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        itemCount: 5,
                        itemSize: 15.0,
                      ),
                      if (isUserRates)
                        InkWell(
                            child: Icon(
                              Icons.edit,
                              color: Colors.green,
                            ),
                            onTap: () {
                              showRatingDialog(
                                  ratingCon: Get.put(RatingController()),
                                  rateToUpdate: rate);
                            })
                    ],
                  ),
                  SizedBox(height: 15),
                  Text(
                    rate.comment,
                    textAlign: TextAlign.start,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
