import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/language_controller.dart';
import '../../common_widgets/custom_text.dart';
import '../../ui/vendors/vendors_areas_screen.dart';
import '../../controllers/location_controller.dart';
import '../../controllers/settings_controller.dart';
import '../../ui/search/vendor_search_screen.dart';
import '../../common_widgets/nav_animation_state.dart';
import '../../common_widgets/custom_appbar.dart';
import '../../common_widgets/drawer.dart';
import '../../controllers/home_controller.dart';
import '../../common_widgets/loading_view.dart';
import '../../ui/home/widgets/home_builder.dart';
import '../../ui/search/product_search_screen.dart';
import '../../consts/colors.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends NavAnimationState<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final SettingsController _settingsCon = Get.find<SettingsController>();
  final LocationController _locationCon = Get.find<LocationController>();
  final LanguageController _langCon = Get.find<LanguageController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: APP_BG_COLOR,
        drawer: AppDrawer(),
        key: _scaffoldKey,
        appBar: CustomAppBar(
          scaffoldKey: _scaffoldKey,
          rightWidget: Row(
            children: [
              if (_settingsCon.isMultiVendor)
                GestureDetector(
                  onTap: () {
                    Get.to(VendorAreasScreen());
                  },
                  child: Container(
                    margin: EdgeInsets.all(8),
                    alignment: Alignment.centerRight,
                    width: 200,
                    height: 40,
                    decoration: BoxDecoration(
                      color: _settingsCon.color2,
                      borderRadius: BorderRadius.circular(5),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: -1,
                          blurRadius: 1,
                          offset: Offset(2, 2), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GetBuilder<LocationController>(
                            init: _locationCon,
                            builder: (con) {
                              return CustomText(
                                  text: con.chosenArea != null
                                      ? _langCon.lang == 'ar'
                                          ? con.chosenArea.nameAr
                                          : con.chosenArea.nameEn
                                      : con.userLocation.subAdminArea);
                            }),
                        Center(
                            child: Icon(
                          Icons.location_on_outlined,
                        )),
                      ],
                    ),
                  ),
                ),
              GestureDetector(
                onTap: () {
                  _settingsCon.isMultiVendor
                      ? Get.to(() => VendorSearchScreen())
                      : Get.to(() => SearchScreen());
                },
                child: Container(
                  margin: EdgeInsets.all(8),
                  alignment: Alignment.centerRight,
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: _settingsCon.color2,
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: -1,
                        blurRadius: 1,
                        offset: Offset(2, 2), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Center(
                      child: Icon(
                    Icons.search,
                  )),
                ),
              ),
            ],
          ),
        ),
        body: AnimatedBuilder(
          animation: animationController,
          builder: (BuildContext context, Widget child) {
            return FadeTransition(
                opacity: animation,
                child: Transform(
                    transform: Matrix4.translationValues(
                        0.0, 100 * (1.0 - animation.value), 0.0),
                    child: child));
          },
          child: GetBuilder<HomeController>(
              init: Get.find(),
              builder: (con) {
                return con.homeData.isEmpty ? LoadingView() : HomeBuilder();
              }),
        ),
      ),
    );
  }
}

// Map homeData = {
//   "totalCount": 4,
//   "data": [
//     {
//       "id": 1,
//       "name_ar": "اعلانات المقدمة",
//       "name_en": "header banner",
//       "type": "banners",
//       "show_name": 0,
//       "h_v": null,
//       "products_sort": null,
//       "categories_parent_id": null,
//       "categories_type": null,
//       "created_at": null,
//       "created_by": null,
//       "updated_at": null,
//       "updated_by": null,
//       "data": [
//         {
//           "id": 1,
//           "image_id": 21,
//           "start_date": "2021-04-14",
//           "end_date": "2021-05-29",
//           "status": 1,
//           "created_by": null,
//           "updated_by": null,
//           "created_at": null,
//           "updated_at": null,
//           "type": "category",
//           "target_id": 2,
//           "group_id": 1,
//           "images_path": "media/upload/1615478410.jpg"
//         },
//         {
//           "id": 2,
//           "image_id": 22,
//           "start_date": "2021-04-14",
//           "end_date": "2021-05-29",
//           "status": 1,
//           "created_by": null,
//           "updated_by": null,
//           "created_at": null,
//           "updated_at": null,
//           "type": "category",
//           "target_id": 1,
//           "group_id": 1,
//           "images_path": "media/upload/1615486229.jpg"
//         }
//       ]
//     },
//     {
//       "id": 2,
//       "name_ar": "احدث المنتجات",
//       "name_en": "new products",
//       "type": "products",
//       "show_name": 1,
//       "h_v": "h",
//       "products_sort": "new",
//       "categories_parent_id": null,
//       "categories_type": null,
//       "created_at": null,
//       "created_by": null,
//       "updated_at": null,
//       "updated_by": null,
//       "data": [
//         {
//           "id": 1,
//           "name_ar": "نسله مياة 6 لتر",
//           "name_en": "Nestle water 6 liter",
//           "description_ar": "نسله مياة 6 لتر",
//           "description_en": "Nestle water 6 liter",
//           "minimum_order": 2,
//           "max_order": 5,
//           "special": 0,
//           "points": 3,
//           "package_1_count": 1,
//           "package_1_name": "item",
//           "package_1_stock": 5,
//           "package_1_price": 50,
//           "price_1_sale": 0,
//           "package_1_barcode": "66841889224",
//           "package_2_count": 2,
//           "package_2_name": "box",
//           "package_2_stock": 2,
//           "package_2_price": 100,
//           "price_2_sale": 89,
//           "package_2_barcode": "33211456",
//           "package_3_count": 12,
//           "package_3_name": "container",
//           "package_3_stock": 0,
//           "package_3_price": 600,
//           "price_3_sale": 0,
//           "package_3_barcode": null,
//           "like_product": 1,
//           "images_path": "media/upload/1616260724.jpg",
//           "image_id": 71
//         },
//         {
//           "id": 2,
//           "name_ar": "عصير رمان ",
//           "name_en": "Pomegranate Juice",
//           "description_ar": "عصير رمان جهينة",
//           "description_en": "Juhayna Pomegranate Juice",
//           "minimum_order": 2,
//           "max_order": 5,
//           "special": 0,
//           "points": 3,
//           "package_1_count": 1,
//           "package_1_name": "item",
//           "package_1_stock": 5,
//           "package_1_price": 3,
//           "price_1_sale": 0,
//           "package_1_barcode": null,
//           "package_2_count": 12,
//           "package_2_name": "box",
//           "package_2_stock": 0,
//           "package_2_price": 36,
//           "price_2_sale": 0,
//           "package_2_barcode": "0050989",
//           "package_3_count": 15,
//           "package_3_name": "container",
//           "package_3_stock": 0,
//           "package_3_price": 540,
//           "price_3_sale": 0,
//           "package_3_barcode": null,
//           "like_product": 0,
//           "images_path": "media/upload/1616265041.jpg",
//           "image_id": 79
//         },
//         {
//           "id": 3,
//           "name_ar": "حليب جهينة كامل الدسم",
//           "name_en": "Juhayna full cream milk",
//           "description_ar": "حليب جهينة كامل الدسم",
//           "description_en": "Juhayna full cream milk",
//           "minimum_order": 2,
//           "max_order": 5,
//           "special": 0,
//           "points": 3,
//           "package_1_count": 1,
//           "package_1_name": "item",
//           "package_1_stock": 55,
//           "package_1_price": 5,
//           "price_1_sale": 0,
//           "package_1_barcode": "00223",
//           "package_2_count": 12,
//           "package_2_name": "box",
//           "package_2_stock": 4,
//           "package_2_price": 60,
//           "price_2_sale": 0,
//           "package_2_barcode": "0501989",
//           "package_3_count": 12,
//           "package_3_name": "container",
//           "package_3_stock": 0,
//           "package_3_price": 720,
//           "price_3_sale": 0,
//           "package_3_barcode": null,
//           "like_product": 0,
//           "images_path": "media/upload/1616266415.png",
//           "image_id": 80
//         },
//         {
//           "id": 4,
//           "name_ar": "Test Admin33",
//           "name_en": "Test Admin33",
//           "description_ar": "Test Admin33",
//           "description_en": "Test Admin33",
//           "minimum_order": 7,
//           "max_order": 66,
//           "special": 0,
//           "points": 15,
//           "package_1_count": 20,
//           "package_1_name": "Test Admin333",
//           "package_1_stock": 4,
//           "package_1_price": 21,
//           "price_1_sale": 0,
//           "package_1_barcode": null,
//           "package_2_count": 11,
//           "package_2_name": "Test Admin3333",
//           "package_2_stock": 0,
//           "package_2_price": 123,
//           "price_2_sale": 0,
//           "package_2_barcode": null,
//           "package_3_count": 14,
//           "package_3_name": "Test Admin33333",
//           "package_3_stock": 0,
//           "package_3_price": 163,
//           "price_3_sale": 0,
//           "package_3_barcode": null,
//           "like_product": 0,
//           "images_path": "test",
//           "image_id": 81
//         },
//         {
//           "id": 5,
//           "name_ar": "Testing Admin1",
//           "name_en": "Testing Admin1",
//           "description_ar": "Testing Admin1",
//           "description_en": "Testing Admin1",
//           "minimum_order": 6,
//           "max_order": 7,
//           "special": 0,
//           "points": 3,
//           "package_1_count": 2,
//           "package_1_name": "Testing Admin1",
//           "package_1_stock": 2,
//           "package_1_price": 5,
//           "price_1_sale": 0,
//           "package_1_barcode": null,
//           "package_2_count": 0,
//           "package_2_name": "",
//           "package_2_stock": 0,
//           "package_2_price": 0,
//           "price_2_sale": 0,
//           "package_2_barcode": null,
//           "package_3_count": 0,
//           "package_3_name": "",
//           "package_3_stock": 0,
//           "package_3_price": 0,
//           "price_3_sale": 0,
//           "package_3_barcode": null,
//           "like_product": 0,
//           "images_path": "test",
//           "image_id": 81
//         }
//       ]
//     },
//     {
//       "id": 3,
//       "name_ar": "اقسام",
//       "name_en": "categories",
//       "type": "categories",
//       "show_name": 1,
//       "h_v": "h",
//       "products_sort": null,
//       "categories_parent_id": 0,
//       "categories_type": 0,
//       "created_at": null,
//       "created_by": null,
//       "updated_at": null,
//       "updated_by": null,
//       "data": [
//         {
//           "id": 1,
//           "name_ar": "نسله",
//           "name_en": "Nestlé",
//           "parent_id": 0,
//           "image_id": 66,
//           "sort": null,
//           "status": 1,
//           "type": 2,
//           "created_at": "2021-03-20",
//           "updated_at": "2021-03-21",
//           "updated_by": 19,
//           "created_by": 19,
//           "images_path": "media/upload/1616255394.jpg",
//           "parent_name_ar": null,
//           "parent_name_en": null
//         },
//         {
//           "id": 2,
//           "name_ar": "جهينه",
//           "name_en": "Juhayna",
//           "parent_id": 0,
//           "image_id": 68,
//           "sort": null,
//           "status": 1,
//           "type": 2,
//           "created_at": "2021-03-20",
//           "updated_at": "2021-03-20",
//           "updated_by": 19,
//           "created_by": 19,
//           "images_path": "media/upload/1616255453.jpg",
//           "parent_name_ar": null,
//           "parent_name_en": null
//         },
//         {
//           "id": 3,
//           "name_ar": "منتجات ألبان",
//           "name_en": "Dairy products",
//           "parent_id": 0,
//           "image_id": 69,
//           "sort": null,
//           "status": 1,
//           "type": 1,
//           "created_at": "2021-03-20",
//           "updated_at": "2021-03-20",
//           "updated_by": 19,
//           "created_by": 19,
//           "images_path": "media/upload/1616255585.jpg",
//           "parent_name_ar": null,
//           "parent_name_en": null
//         },
//         {
//           "id": 4,
//           "name_ar": "مشروبات",
//           "name_en": "Drinks",
//           "parent_id": 0,
//           "image_id": 70,
//           "sort": null,
//           "status": 1,
//           "type": 0,
//           "created_at": "2021-03-20",
//           "updated_at": "2021-03-20",
//           "updated_by": 19,
//           "created_by": 19,
//           "images_path": "media/upload/1616255700.jpg",
//           "parent_name_ar": null,
//           "parent_name_en": null
//         }
//       ]
//     },
//     {
//       "id": 4,
//       "name_ar": "شركات",
//       "name_en": "companies",
//       "type": "categories",
//       "show_name": 1,
//       "h_v": "v",
//       "products_sort": null,
//       "categories_parent_id": 0,
//       "categories_type": 2,
//       "created_at": null,
//       "created_by": null,
//       "updated_at": null,
//       "updated_by": null,
//       "data": [
//         {
//           "id": 1,
//           "name_ar": "نسله",
//           "name_en": "Nestlé",
//           "parent_id": 0,
//           "image_id": 66,
//           "sort": null,
//           "status": 1,
//           "type": 2,
//           "created_at": "2021-03-20",
//           "updated_at": "2021-03-21",
//           "updated_by": 19,
//           "created_by": 19,
//           "images_path": "media/upload/1616255394.jpg",
//           "parent_name_ar": null,
//           "parent_name_en": null
//         },
//         {
//           "id": 2,
//           "name_ar": "جهينه",
//           "name_en": "Juhayna",
//           "parent_id": 0,
//           "image_id": 68,
//           "sort": null,
//           "status": 1,
//           "type": 2,
//           "created_at": "2021-03-20",
//           "updated_at": "2021-03-20",
//           "updated_by": 19,
//           "created_by": 19,
//           "images_path": "media/upload/1616255453.jpg",
//           "parent_name_ar": null,
//           "parent_name_en": null
//         }
//       ]
//     }
//   ]
// };
