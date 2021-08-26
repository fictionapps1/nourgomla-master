import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../common_widgets/dialogs_and_snacks.dart';
import '../../../common_widgets/rating_bar_with_raters_count.dart';
import '../../../common_widgets/rating_with_comment.dart';
import '../../../controllers/user_controller.dart';
import '../../../ui/account/login_options_screen.dart';
import '../../../ui/rating/rating_screen.dart';
import '../../../common_widgets/custom_text.dart';
import '../../../controllers/rating_controller.dart';
import '../../../controllers/settings_controller.dart';
import '../../../models/rate.dart';
import '../../../controllers/language_controller.dart';
import '../../../controllers/cart_controller.dart';
import '../../../models/product.dart';
import 'product_info_tile.dart';


class ProductInfo extends GetView<CartController> {
  final Product product;
  final List<Rate> rates;
  const ProductInfo({@required this.product, this.rates});
  @override
  Widget build(BuildContext context) {
    final RatingController _ratingCon =
        Get.put(RatingController(productId: product.id));
    final SettingsController _settingsCon = Get.find<SettingsController>();
    final UserController _userCon = Get.find<UserController>();
    return SliverList(
      delegate: SliverChildListDelegate(
        [
          GetBuilder<LanguageController>(
              init: Get.find(),
              builder: (langCon) {
                return ListTile(
                  title: Text(
                    langCon.lang == 'ar' ? product.nameAr : product.nameEn,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                    ),
                  ),
                  trailing: _settingsCon.reviewEnabled
                      ? InkWell(
                          onTap: () {
                            if (_userCon.loggedIn) {
                              showRatingDialog(
                                  ratingCon: _ratingCon, productId: product.id);
                            } else {
                              showTwoButtonsDialog(
                                  msg: 'you_need_to_login_first'.tr,
                                  onOkTapped: () {
                                    Get.back();
                                    Get.to(() => LoginOptionsScreen());
                                  });
                            }
                          },
                          child: Container(
                            width: 120,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                if (product.ratersCount > 0)
                                  RatingBarWithRatersCount(
                                      rate: product.rate,
                                      raters: product.ratersCount),
                                CustomText(
                                  text: 'rate_product'.tr,
                                  color: Colors.lightBlue,
                                ),
                              ],
                            ),
                          ),
                        )
                      : SizedBox(),
                  subtitle: Text(langCon.lang == 'ar'
                      ? product.descriptionAr
                      : product.descriptionEn),
                );
              }),
          ProductInfoTile(
            title: 'price'.tr + "  ${product.package1Name}  ",
            info: product.package1Price.toString(),
          ),
          if (product.package2Name != null && product.package2Name != ''&&_settingsCon.availablePackaging>1)
            ProductInfoTile(
              title: 'price'.tr + "  ${product.package2Name}  ",
              info: product.package2Price.toString(),
            ),
          if (product.package3Name != null && product.package3Name != ''&&_settingsCon.availablePackaging>2)
            ProductInfoTile(
              title: 'price'.tr + "  ${product.package3Name}  ",
              info: product.package3Price.toString(),
            ),
          // ProductInfoTile(
          //   title: 'Special',
          //   info: product.special.toString(),
          // ),
          ProductInfoTile(
            title: 'points'.tr,
            info: product.points.toString(),
          ),
          // ProductInfoTile(
          //   title: 'stock'.tr + '  ${product.package1Name}  ',
          //   info:
          //       '${product.package1Name}  ${product.package1Stock.toString()}',
          // ),
          // if (product.package2Name != null && product.package2Name != '')
          //   ProductInfoTile(
          //     title: 'stock'.tr + '  ${product.package2Name}  ',
          //     info:
          //         '${product.package2Name}  ${product.package2Stock.toString()}',
          //   ),
          // if (product.package3Name != null && product.package3Name != '')
          //   ProductInfoTile(
          //     title: 'stock'.tr + '  ${product.package3Name}  ',
          //     info:
          //         '${product.package3Name}  ${product.package3Stock.toString()}',
          //   ),
          const SizedBox(height: 5),
          if (rates.length > 0) ...{
            Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 12.0, horizontal: 8.0),
                  child: Container(
                    height: 175,
                    decoration: BoxDecoration(
                        border: Border.all(width: .5),
                        borderRadius: BorderRadius.circular(15)),
                    child: Center(
                      child: Container(
                        height: 160,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: rates.length,
                            itemBuilder: (context, index) =>
                                RatingWithCommentWidget(
                                  rate: rates[index],
                                  padding: 8,
                                )),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  child: Container(
                    color: Colors.grey[200],
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: CustomText(
                        text: 'rates'.tr,
                        weight: FontWeight.bold,
                        size: 18,
                      ),
                    ),
                  ),
                  top: 0,
                  right: 40,
                ),
                Positioned(
                  child: InkWell(
                    onTap: () {
                      Get.to(() => RatingScreen(productId: product.id));
                    },
                    child: Container(
                      color: Colors.grey[200],
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: CustomText(
                          text: 'load_all_rates'.tr,
                          size: 18,
                          color: Colors.lightBlue,
                        ),
                      ),
                    ),
                  ),
                  bottom: 0,
                  left: 40,
                ),
              ],
            ),
            const SizedBox(height: 20),
          }
        ],
      ),
    );
  }
}
