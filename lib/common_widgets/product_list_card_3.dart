import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import '../common_widgets/rating_bar_with_raters_count.dart';
import '../controllers/settings_controller.dart';
import '../controllers/user_controller.dart';
import '../ui/account/login_options_screen.dart';
import '../common_widgets/packaging_info_widget_2_lines.dart';
import '../common_widgets/product_cart_sheet.dart';
import '../common_widgets/spin_widget.dart';
import 'cached_image.dart';
import 'corners.dart';
import 'custom_text.dart';
import '../controllers/language_controller.dart';
import '../controllers/cart_controller.dart';
import '../helpers/hex_color.dart';
import '../models/product.dart';
import '../responsive_setup/responsive_builder.dart';
import '../services/api_calls/favourite_service.dart';
import 'dialogs_and_snacks.dart';

class ProductListCard3 extends GetView<CartController> {
  final Product product;
  final String buttonText;
  final int cartProducts;

  /// A function to be triggered when a card is pressed
  final Function onCardPressed;

  /// A function to be triggered when a add to cart is pressed
  final Function onAddToCartPressed;

  /// The color of the Product Card background. Default color is FFFFFF
  final String cardBackgroundColor;

  /// The color of the Button background. Default color is 00DDFF
  final String buttonBackgroundColor;

  /// The color of Product Text Title. Default color is 000000
  final String titleColor;

  /// The color of Product Description Text. Default color is 000000
  final String descriptionColor;

  /// The color of Product Price Text. Default color is 00FF00
  final String priceColor;

  /// The color of Product Quantity Text. Default color is 005533
  final String quantityColor;

  /// The color of the button text. Default color is FFFFFF
  final String buttonTextColor;

  /// The font size of Product Title Text, default size is 15
  final double titleFontSize;

  /// The font size of Product Description Text, default size is 13
  final double descriptionFontSize;

  /// The font size of Product Price Text, default size is 14
  final double priceFontSize;

  /// The font size of Product Quantity Text, default size is 14
  final double quantityFontSize;

  /// The corners shape of the Product Card.
  /// it takes Corners type which is a class contains all four corners
  final Corners cardCorners;

  /// The corners shape of the Product Button.
  /// it takes Corners type which is a class contains all four corners
  final Corners buttonCorners;

  /// The height of Product Image. Default is 130
  final double imageHeight;

  /// The elevation of the Product Card. default is 1
  final double cardElevation;

  const ProductListCard3({
    @required this.product,
    this.buttonText,
    this.cartProducts,
    @required this.onCardPressed,
    this.onAddToCartPressed,
    this.cardBackgroundColor = 'FFFFFF',
    this.buttonBackgroundColor = '00DDFF',
    this.titleColor = '000000',
    this.descriptionColor = '000000',
    this.priceColor = '00FF00',
    this.quantityColor = '005533',
    this.buttonTextColor = 'FFFFFF',
    this.titleFontSize = 15,
    this.descriptionFontSize = 13,
    this.priceFontSize = 14,
    this.quantityFontSize = 14,
    this.cardCorners = const Corners(),
    this.buttonCorners,
    this.imageHeight,
    this.cardElevation = 1,
  });

  @override
  Widget build(BuildContext context) {
    final FavouriteService favouriteService = FavouriteService.instance;
    final UserController _userController = Get.find<UserController>();
    final LanguageController langCon = Get.find<LanguageController>();
    final SettingsController _settingsCon = Get.find<SettingsController>();
    return ResponsiveBuilder(builder: (context, sizingInfo) {
      final height = sizingInfo.screenHeight;
      return InkWell(
        onTap: onCardPressed,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20),
                  bottomLeft: Radius.circular(20)),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: -1,
                  blurRadius: 1,
                  offset: Offset(0, 2), // changes position of shadow
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(20),
                                  bottomLeft: Radius.circular(20)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: -1,
                                  blurRadius: 1,
                                  offset: Offset(
                                      -1, 2), // changes position of shadow
                                ),
                              ],
                            ),
                            child: Stack(
                              children: [
                                Hero(
                                  tag: product.id,
                                  child: ClipRRect(
                                    borderRadius: langCon.lang == 'ar'
                                        ? BorderRadius.only(
                                            bottomLeft: Radius.circular(20),
                                            topRight: Radius.circular(20),
                                          )
                                        : BorderRadius.only(
                                            bottomRight: Radius.circular(20),
                                            topLeft: Radius.circular(20),
                                          ),
                                    child: CachedImage(
                                      product.imagesPath,
                                      height: height / 5.5,
                                      fit: BoxFit.scaleDown,
                                    ),
                                  ),
                                ),
                                Consumer<Product>(builder: (context, prov, _) {
                                  var favStatus = prov.likeProduct;
                                  return Positioned(
                                      top: 0,
                                      left: langCon.lang == 'en' ? 0 : null,
                                      right: langCon.lang == 'ar' ? 0 : null,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.black12,
                                          borderRadius: langCon.lang == 'ar'
                                              ? BorderRadius.only(
                                                  bottomLeft:
                                                      Radius.circular(20),
                                                  topRight: Radius.circular(20),
                                                )
                                              : BorderRadius.only(
                                                  bottomRight:
                                                      Radius.circular(20),
                                                ),
                                        ),
                                        child: IconButton(
                                          padding: EdgeInsets.all(2),
                                          icon: Icon(
                                            favStatus == 1
                                                ? Icons.favorite
                                                : Icons.favorite_border,
                                            size: 28,
                                            color: favStatus == 1
                                                ? Colors.red[400]
                                                : Colors.grey[800],
                                          ),
                                          onPressed: () {
                                            if (_userController.loggedIn) {
                                              favouriteService.addFavoriteItem(
                                                productId: product.id,
                                              );
                                              product.toggleFavoriteStatus();
                                            } else {
                                              showNormalDialog(
                                                  msg:
                                                      'log_in_first_to_add_to_favorites'
                                                          .tr,
                                                  title: '',
                                                  buttonText: 'log_in'.tr,
                                                  onTapped: () {
                                                    Get.back();
                                                    Get.to(LoginOptionsScreen());
                                                  });
                                            }
                                          },
                                        ),
                                      ));
                                }),
                              ],
                            ),
                          ),
                          if (product.ratersCount > 0 &&
                              _settingsCon.reviewEnabled)
                            Container(
                              height: 60,
                              child: RatingBarWithRatersCount(
                                rate: product.rate,
                                raters: product.ratersCount,
                                vPadding: 8,
                                isColumn: true,
                              ),
                            ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 5),
                    Expanded(
                      flex: 3,
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            const SizedBox(height: 1),
                            Text(

                              langCon.lang == 'ar'
                                  ? product.nameAr
                                  : product.nameEn,
                              style: TextStyle(
                                  color: HexColor(titleColor),
                                  fontWeight: FontWeight.bold,
                                  fontSize: titleFontSize,
                                  height: 1.5),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const Divider(height: 8),
                            PackagingInfoWidget2Lines(
                              price: product.package1Price.toString(),
                              salePrice: product.price1Sale.toString(),
                              packagingCount: product.package1Count.toString(),
                              packagingName: product.package1Name,
                              unitName: 'piece'.tr,
                            ),
                            if (product.package2Name != null &&
                                    product.package2Name != ''&&_settingsCon.availablePackaging>1) ...{
                              const Divider(height: 8),
                              PackagingInfoWidget2Lines(
                                price: product.package2Price.toString(),
                                salePrice: product.price2Sale.toString(),
                                packagingCount:
                                    product.package2Count.toString(),
                                packagingName: product.package2Name,
                                unitName: product.package1Name,
                              ),
                            },
                            if (product.package3Name != null &&
                                    product.package3Name != ''&&_settingsCon.availablePackaging>2) ...{
                              const Divider(height: 8),
                              PackagingInfoWidget2Lines(
                                price: product.package3Price.toString(),
                                salePrice: product.price3Sale.toString(),
                                packagingCount:
                                    product.package3Count.toString(),
                                packagingName: product.package3Name,
                                unitName: product.package2Name,
                              ),
                            }
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Obx(
                  () => Container(
                    height: 40,
                    width: sizingInfo.screenWidth,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        if (!controller.isProductInCart(product.id)) ...{
                          Expanded(
                            child: Container(
                              height: 40,
                              child: FlatButton(
                                onPressed: () {
                                  showModalBottomSheet(
                                    context: context,
                                    isScrollControlled: true,
                                    builder: (context) {
                                      return ProductCartSheet(product: product);
                                    },
                                  );
                                },
                                color: _settingsCon.color2,
                                shape: _settingsCon.pointsEnabled &&
                                        product.points > 0
                                    ? RoundedRectangleBorder(
                                        borderRadius: langCon.lang == 'ar'
                                            ? BorderRadius.only(
                                                topLeft: Radius.circular(20))
                                            : BorderRadius.only(
                                                bottomLeft: Radius.circular(20),
                                                topRight: Radius.circular(20)))
                                    : langCon.lang == 'ar'
                                        ? RoundedRectangleBorder(
                                            borderRadius: BorderRadius.only(
                                                bottomLeft:
                                                    Radius.circular(20)))
                                        : RoundedRectangleBorder(
                                            borderRadius: BorderRadius.only(
                                                bottomRight:
                                                    Radius.circular(20))),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Icon(Icons.add_shopping_cart),
                                    Text('add_to_cart'.tr),
                                  ],
                                ),
                              ),
                            ),
                          )
                        },
                        if (controller.isProductInCart(product.id)) ...{
                          Expanded(
                            child: SpinWidget(
                              min: product.minimumOrder,
                              max: product.maxOrder,
                              stock: controller
                                  .getCartById(product.id)
                                  .selectedPackagingStock,
                              value:
                                  controller.getCartById(product.id).quantity,
                              packageType: controller
                                  .getCartById(product.id)
                                  .selectedPackagingName,
                              onChanged: (value) =>
                                  controller.changeQuantity(product.id, value),
                            ),
                          ),
                        },
                        if (_settingsCon.pointsEnabled &&
                            product.points > 0) ...{
                          const SizedBox(width: 30),
                          Container(
                            height: 40,
                            width: 50,
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: langCon.lang == 'ar'
                                  ? BorderRadius.only(
                                      topRight: Radius.circular(20),
                                      bottomLeft: Radius.circular(20),
                                    )
                                  : BorderRadius.only(
                                      topLeft: Radius.circular(20),
                                    ),
                            ),
                            child: GetBuilder<CartController>(
                                init: Get.find(),
                                builder: (con) {
                                  return Center(
                                    child: CustomText(
                                        text: '${product.points.toString()}' +
                                            ' ' +
                                            'points'.tr +
                                            ' '),
                                  );
                                }),
                          ),
                        }
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
