import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import '../responsive_setup/responsive_builder.dart';
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
import '../services/api_calls/favourite_service.dart';
import 'dialogs_and_snacks.dart';
import 'rating_bar_with_raters_count.dart';

class ProductCard3 extends GetView<CartController> {
  final Product product;
  final int cartProducts;

  /// A function to be triggered when a card is pressed
  final Function onCardPressed;

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

  const ProductCard3({
    @required this.product,
    this.cartProducts,
    @required this.onCardPressed,
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
    this.imageHeight = 180,
    this.cardElevation = 1,
  });

  @override
  Widget build(BuildContext context) {
    final FavouriteService favouriteService = FavouriteService.instance;
    final UserController _userController = Get.find<UserController>();
    final SettingsController _settingsCon = Get.find<SettingsController>();
    return ResponsiveBuilder(builder: (context, sizingInfo) {
      final height = sizingInfo.screenHeight;
      return InkWell(
        onTap: onCardPressed,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(20), bottomLeft: Radius.circular(20)),
          ),
          elevation: cardElevation,
          child: GetBuilder<LanguageController>(
              init: Get.find(),
              builder: (langCon) {
                return Obx(
                  () => Stack(
                    children: [
                      Column(
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
                                      0, 2), // changes position of shadow
                                ),
                              ],
                            ),
                            child: Stack(
                              children: [
                                Hero(
                                  tag: product.id,
                                  child: CachedImage(
                                    product.imagesPath,
                                    height: height / 7.2,
                                    width: double.maxFinite,
                                    radius: 15,
                                    fit: BoxFit.scaleDown,
                                  ),
                                ),
                                Consumer<Product>(builder: (context, prov, _) {
                                  var favStatus = prov.likeProduct;
                                  return Positioned(
                                      top: 0,
                                      left: 0,
                                      child: Container(
                                        height: height / 18,
                                        width: height / 18,
                                        decoration: BoxDecoration(
                                            color: Colors.grey[200],
                                            borderRadius: BorderRadius.only(
                                                bottomRight:
                                                    Radius.circular(20))),
                                        child: IconButton(
                                          padding: EdgeInsets.all(2),
                                          icon: Icon(
                                            favStatus == 1
                                                ? Icons.favorite
                                                : Icons.favorite_border,
                                            size: 22,
                                            color: favStatus == 1
                                                ? Colors.red[400]
                                                : Colors.grey[700],
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
                                if (_settingsCon.pointsEnabled &&
                                    product.points > 0)
                                  Positioned(
                                      bottom: 0,
                                      right: 0,
                                      child: Container(
                                        height: height / 18,
                                        width: height / 18,
                                        decoration: BoxDecoration(
                                            color: Colors.black12,
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(20),
                                            )),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            CustomText(
                                                text:
                                                    '${product.points.toString()}'),
                                            CustomText(
                                                size: 12, text: 'points'.tr),
                                          ],
                                        ),
                                      )),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                const SizedBox(height: 5),
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
                                if (product.ratersCount > 0&&
                                    _settingsCon.reviewEnabled) ...{
                                  RatingBarWithRatersCount(
                                    rate:product.rate,
                                    raters: product.ratersCount,
                                    vPadding: 8,
                                  ),
                                  const Divider(height: 8),
                                },
                                PackagingInfoWidget2Lines(
                                  price: product.package1Price.toString(),
                                  salePrice: product.price1Sale.toString(),
                                  packagingCount:
                                      product.package1Count.toString(),
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
                                },
                                const SizedBox(height: 5),
                              ],
                            ),
                          ),
                        ],
                      ),
                      if (!controller.isProductInCart(product.id)) ...{
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Container(
                            height: height / 18,
                            width: double.infinity,
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
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(20),
                              )),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Icon(Icons.add_shopping_cart),
                                  CustomText(
                                    text: 'add_to_cart'.tr,
                                    size: 17,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      },
                      if (controller.isProductInCart(product.id)) ...{
                        Positioned(
                          right: 0,
                          left: 0,
                          bottom: 0,
                          child: SpinWidget(
                            textStyle: TextStyle(fontSize: 14),
                            min: product.minimumOrder,
                            max: product.maxOrder,
                            stock: controller
                                .getCartById(product.id)
                                .selectedPackagingStock,
                            value: controller.getCartById(product.id).quantity,
                            packageType: controller
                                .getCartById(product.id)
                                .selectedPackagingName,
                            onChanged: (value) =>
                                controller.changeQuantity(product.id, value),
                          ),
                        ),
                      },
                    ],
                  ),
                );
              }),
        ),
      );
    });
  }
}
