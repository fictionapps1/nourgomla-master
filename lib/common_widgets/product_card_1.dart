import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
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

class ProductCard1 extends GetView<CartController> {
  final bool isFromHomeScreen;
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

  const ProductCard1({
    @required this.product,
    this.cartProducts,
    this.isFromHomeScreen=false,
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
    return InkWell(
      onTap: onCardPressed,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        elevation: cardElevation,
        child: GetBuilder<LanguageController>(
            init: Get.find(),
            builder: (langController) {
              return Obx(
                () => Stack(
                  children: [
                    Column(
                      children: [
                        Stack(
                          children: [
                            Hero(
                              tag: product.id,
                              child: CachedImage(
                                product.imagesPath,
                                height: 180,
                                width: 200,
                                radius: 20,
                                fit: BoxFit.fill,
                              ),
                            ),
                            Consumer<Product>(builder: (context, prov, _) {
                              var favStatus = prov.likeProduct;
                              return Positioned(
                                  top: 0,
                                  left: 0,
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.black26,
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(20),
                                            bottomRight: Radius.circular(20))),
                                    child: IconButton(
                                      padding: EdgeInsets.all(2),
                                      icon: Icon(
                                        favStatus == 1
                                            ? Icons.favorite
                                            : Icons.favorite_border,
                                        size: 28,
                                        color: favStatus == 1?Colors.red[400]:Colors.white,
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
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              const SizedBox(height: 10),
                              Text(
                                langController.lang == 'ar'
                                    ? product.nameAr
                                    : product.nameEn,
                                style: TextStyle(
                                  color: HexColor(titleColor),
                                  fontWeight: FontWeight.bold,
                                  fontSize: titleFontSize,
                                ),
                                maxLines: 1,
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
                                Divider(),
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
                                Divider(),
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
                        if(isFromHomeScreen)
                        SizedBox(height: 40),
                        if(_settingsCon.pointsEnabled&&product.points>0)...{
                          GetBuilder<CartController>(
                              init: Get.find(),
                              builder: (con) {

                                return Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: 50, left: 8, right: 8),
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                      children: [
                                        CustomText(
                                            text:
                                            ' ${product.points.toString()} ' +
                                                'points'.tr),
                                        if (con.isProductInCart(product.id))
                                          Padding(
                                            padding:
                                            const EdgeInsets.only(top: 8.0),
                                            child: CustomText(
                                                text: 'total_points'.tr +
                                                    '  ' +
                                                    con
                                                        .getCartById(product.id)
                                                        .cartItemPoints
                                                        .toString()),
                                          ),
                                      ],
                                    ),
                                  ),
                                );
                              }),
                        }else...{
                          SizedBox(height: 50),
                        }

                      ],
                    ),

                    if (!controller.isProductInCart(product.id)) ...{
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          height: 50,
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
                                    bottomRight: Radius.circular(20))),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
  }
}
