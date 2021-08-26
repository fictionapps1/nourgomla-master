import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/settings_controller.dart';
import '../../../ui/home/widgets/banners_group_h_list.dart';
import '../../../common_widgets/custom_text.dart';
import '../../../controllers/language_controller.dart';
import '../../../controllers/home_controller.dart';
import '../../../models/product.dart';
import '../../../ui/home/widgets/categories_list_builder.dart';
import '../../../ui/home/widgets/home_images_slider.dart';
import '../../../ui/home/widgets/products_list_builder.dart';
import 'horizontal_list_one_line.dart';
import 'vendors_list_builder.dart';

class HomeBuilder extends StatelessWidget {
  final HomeController homeController = Get.find<HomeController>();
  final SettingsController settingsCon = Get.find<SettingsController>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(child: buildHomeElements(context));
  }

  Column buildHomeElements(BuildContext context) {
    final List homeDataList = homeController.homeData['data'];
    final width = MediaQuery.of(context).size.width;
    List<Widget> children = [];
    homeDataList.forEach((element) {
      final String type = element['type'];
      final List data = element['data'];
      final bool showTitle = element['show_name'] == 1 ? true : false;
      final bool isVertical = element['h_v'] == 'v' ? true : false;
      final String nameAr = element['name_ar'];
      final String nameEn = element['name_en'];

      switch (type) {
        case 'banners':
          if (data.isNotEmpty) {
            if (showTitle) {
              children.add(buildTitle(titleAr: nameAr, titleEn: nameEn));
            }
            List images = [];
            List routesIds = [];
            List typesData = [];

            data.forEach((e) {
              images.add(e['images_path']);
              routesIds.add(e['target_id']);
              typesData.add(e['type']);
            });
            children.add(Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Container(
                  height: width / 2.25,
                  child: HomeImagesSlider(
                    images: images,
                    routsIds: routesIds,
                    typesData: typesData,
                  )),
            ));
          }

          break;
        case 'banners_group':
          if (data.isNotEmpty) {
            if (showTitle) {
              children.add(buildTitle(titleAr: nameAr, titleEn: nameEn));
            }
            List images = [];
            List routesIds = [];
            List typesData = [];

            data.forEach((e) {
              images.add(e['images_path']);
              routesIds.add(e['target_id']);
              typesData.add(e['type']);
            });
            children.add(Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Container(
                  height: width / 1.4,
                  child: BannersGroupList(
                    images: images,
                    routsIds: routesIds,
                    typesData: typesData,
                  )),
            ));
          }

          break;
        case 'banners_h_list':
          if (data.isNotEmpty) {
            if (showTitle) {
              children.add(buildTitle(titleAr: nameAr, titleEn: nameEn));
            }
            List images = [];
            List routesIds = [];
            List typesData = [];

            data.forEach((e) {
              images.add(e['images_path']);
              routesIds.add(e['target_id']);
              typesData.add(e['type']);
            });
            children.add(Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Container(
                  height: 120,
                  child: HorizontalListOneLine(
                    images: images,
                    routsIds: routesIds,
                    typesData: typesData,
                  )),
            ));
          }

          break;
        case 'products':
          if (data.isNotEmpty) {
          if (showTitle) {
            children.add(buildTitle(titleAr: nameAr, titleEn: nameEn));
          }
          List<Product> products =
              data.map((e) => Product.fromJson(e)).toList();
          if (isVertical) {
            children.add(ProductsListBuilderVertical(products: products));
          } else {
            children.add(ProductsListBuilder(
                isVertical: isVertical, products: products));
          }}
          break;
        case 'categories':
          if (data.isNotEmpty) {
            List images = [];
            List titlesAr = [];
            List titlesEn = [];
            List routesIds = [];
            data.forEach((e) {
              images.add(e['images_path']);
              titlesAr.add(e['name_ar']);
              titlesEn.add(e['name_en']);
              routesIds.add(e['id']);
            });
            if (showTitle) {
              children.add(buildTitle(titleAr: nameAr, titleEn: nameEn));
            }
            children.add(CategoryListBuilder(
              isVertical: isVertical,
              images: images,
              showTitles: false,
              titlesAr: titlesAr,
              titlesEn: titlesEn,
              routsIds: routesIds,
            ));
          }

          break;
        case 'vendor_category':
          if (data.isNotEmpty&&settingsCon.isMultiVendor) {
          List images = [];
          List titlesAr = [];
          List titlesEn = [];
          List routesIds = [];
          data.forEach((e) {
            images.add(e['images_path']);
            titlesAr.add(e['name_ar']);
            titlesEn.add(e['name_en']);
            routesIds.add(e['id']);
          });
          if (showTitle) {
            children.add(buildTitle(titleAr: nameAr, titleEn: nameEn));
          }
          children.add(VendorsListBuilder(
            isVertical: isVertical,
            images: images,
            showTitles: false,
            titlesAr: titlesAr,
            titlesEn: titlesEn,
            routsIds: routesIds,
          ));}
          break;
      }
    });
    return Column(children: children);
  }

  Padding buildTitle({titleAr, titleEn}) {
    return Padding(
      padding: const EdgeInsets.only(top: 18, bottom: 8),
      child: GetBuilder<LanguageController>(
          init: Get.find(),
          builder: (con) {
            return CustomText(
              text: con.lang == 'ar' ? titleAr : titleEn,
              size: 20,
              weight: FontWeight.bold,
            );
          }),
    );
  }
}
