import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../common_widgets/loading_view.dart';
import '../../controllers/dynamic_link_controller.dart';
import '../../models/rate.dart';
import '../../services/api_calls/products_service.dart';
import '../../common_widgets/images_slider.dart';
import '../../common_widgets/product_cart_sheet.dart';
import '../../common_widgets/spin_widget.dart';
import '../../common_widgets/custom_text.dart';
import '../../controllers/bottom_nav_bar_controller.dart';
import '../../controllers/cart_controller.dart';
import '../../controllers/settings_controller.dart';
import '../../models/cart.dart';
import '../../models/product.dart';
import '../../ui/products/widgets/product_info.dart';
import '../../ui/screen_navigator/screen_navigator.dart';
import 'package:flutter_share/flutter_share.dart';

class ProductDetailsScreen extends StatefulWidget {
  final Product product;
  final String type;
  final int productId;

  const ProductDetailsScreen({this.product, this.type = '2', this.productId});

  @override
  _ProductDetailsScreenState createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  ProductsService _productsService = ProductsService.instance;
  final SettingsController _settingsCon = Get.find<SettingsController>();
  final CartController controller = Get.find<CartController>();
  final BottomNavBarController navController =
      Get.find<BottomNavBarController>();
  Product productDetails;
  List<String> images;
  List<Rate> rates;
  Future _productFuture;

  @override
  void initState() {
    getProductDetails();
    super.initState();
  }

  getProductDetails() async {
    productDetails = widget.product;
    _productFuture = _productsService.getProductDetails(
        type: widget.type,
        productId:
            productDetails != null ? productDetails.id : widget.productId);
    Map productData = await _productFuture;
    if (productDetails == null) {
      productDetails = productData['details'];
    }

    images = productData['images'];
    rates = productData['rates'];
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        resizeToAvoidBottomInset: true,
        body: FutureBuilder<Map>(
            future: _productFuture,
            builder: (context, snapshot) {
              if (snapshot.hasData &&
                  snapshot.connectionState == ConnectionState.done) {
                {
                  return Column(
                    children: [
                      Expanded(
                        child: Container(
                          child: CustomScrollView(
                            slivers: [
                              SliverAppBar(
                                expandedHeight:
                                    MediaQuery.of(context).size.height * 0.45,
                                floating: true,
                                pinned: true,
                                snap: false,
                                actions: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: InkWell(
                                      onTap: () async {
                                        final dynamicLinkCon =
                                            Get.put(DynamicLinkController());
                                        final String link = await dynamicLinkCon
                                            .createSharableDynamicLink(
                                                productDetails.id, true);
                                        share(link);
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.green.withOpacity(.8),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Icon(
                                            Icons.share_outlined,
                                            color: Colors.white,
                                            size: 25,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                                leading: Center(
                                  child: InkWell(
                                    onTap: () {
                                      Get.back();
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.black54,
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Icon(
                                          Icons.close,
                                          color: Colors.white,
                                          size: 25,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                backgroundColor: _settingsCon.color1,
                                flexibleSpace: FlexibleSpaceBar(
                                  background: Hero(
                                    tag:
                                        '${productDetails.id}+productDetails.imagesPath',
                                    child: ImagesSlider(
                                      images: images.isNotEmpty
                                          ? images
                                          : ([productDetails.imagesPath]),
                                      autoPlay: false,
                                    ),
                                  ),
                                ),
                              ),
                              ProductInfo(
                                  rates: rates,
                                  product: productDetails != null
                                      ? productDetails
                                      : productDetails),
                            ],
                          ),
                        ),
                      ),
                      Obx(
                        () {
                          if (controller.isProductInCart(productDetails.id)) {
                            CartItem cart =
                                controller.getCartById(productDetails.id);
                            return Container(
                              height: 50,
                              color: Colors.grey[300],
                              child: SpinWidget(
                                min: productDetails.minimumOrder,
                                max: productDetails.maxOrder,
                                value: cart.quantity,
                                onChanged: (value) => controller.changeQuantity(
                                    productDetails.id, value),
                                packageType: cart.selectedPackagingName,
                              ),
                            );
                          } else
                            return Container(
                              height: MediaQuery.of(context).size.height / 14,
                              width: double.infinity,
                              child: FlatButton(
                                onPressed: () {
                                  showModalBottomSheet(
                                    context: context,
                                    isScrollControlled: true,
                                    builder: (context) => ProductCartSheet(
                                      product: productDetails,
                                    ),
                                  );
                                },
                                color: _settingsCon.color1,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    const Icon(Icons.add_shopping_cart),
                                    CustomText(
                                      text: 'add_to_cart'.tr,
                                      size: 18,
                                      weight: FontWeight.w500,
                                    ),
                                  ],
                                ),
                              ),
                            );
                        },
                      ),
                      Obx(() {
                        if (controller.isProductInCart(productDetails.id)) {
                          return GetBuilder(
                              init: controller,
                              builder: (controller) {
                                return InkWell(
                                  onTap: () {

                                    Get.offAll(() => ScreenNavigator());
                                    Future.delayed(Duration.zero, () {
                                      navController.currentIndex.value = 2;
                                    });
                                  },
                                  child: Container(
                                    height:
                                        MediaQuery.of(context).size.height / 14,
                                    width: MediaQuery.of(context).size.width,
                                    color: Colors.green,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        const Icon(
                                          Icons.shopping_cart,
                                          color: Colors.black,
                                        ),
                                        CustomText(
                                          text: 'go_to_cart'.tr,
                                          color: Colors.black,
                                          size: 18,
                                          weight: FontWeight.w500,
                                        ),
                                        Center(
                                          child: CustomText(
                                            text: controller
                                                    .getCartById(
                                                        productDetails.id)
                                                    .totalPrice
                                                    .toString() +
                                                'egp'.tr,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              });
                        }
                        {
                          return Container();
                        }
                      })
                    ],
                  );
                }
              } else {
                return LoadingView();
              }
            }),
      ),
    );
  }

  Future<void> share(String link) async {
    await FlutterShare.share(
        title: 'Example share',
        text: 'Example share text',
        linkUrl: link,
        chooserTitle: 'Example Chooser Title');
  }
}
