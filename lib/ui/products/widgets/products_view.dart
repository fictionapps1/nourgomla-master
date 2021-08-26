import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../ui/products/widgets/product_builder_1.dart';
import '../../../ui/products/widgets/product_builder_2.dart';
import '../../../ui/products/widgets/product_builder_3.dart';
import '../../../controllers/filter_contoller.dart';
import '../../../controllers/settings_controller.dart';
import '../../../controllers/categories_view_controller.dart';
import '../../../models/product.dart';
import '../../../ui/filter/widgets/horizontal_list_companies_filter.dart';
import '../../../ui/filter/widgets/horizontal_list_trademarks_filter.dart';
import '../../../ui/filter/widgets/Horizontal_list_types_filter.dart';
import '../../../common_widgets/empty_view.dart';

class ProductsView extends GetView<CategoriesViewController> {
  final FilterController _filterController = Get.put(FilterController());
  final SettingsController _settingsCon = Get.find<SettingsController>();
  final List<Product> products;
  ProductsView({
    @required this.products,
    @required this.categoryImage,
    @required this.applyFilter,
  });
  final String categoryImage;
  final Function applyFilter;
  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        if (_filterController.companiesFilterList.isNotEmpty &&
            _settingsCon.filter1barEnabled) ...{
          HorizontalListCompaniesFilter(
            categories: _filterController.companiesFilterList,
            categoryImage: categoryImage,
            applyFilter: applyFilter,
            filterText: 'filter_by_company'.tr,
          ),
        },
        if (_filterController.trademarksFilterList.isNotEmpty &&
            _settingsCon.filter2barEnabled) ...{
          HorizontalListTrademarksFilter(
            categories: _filterController.trademarksFilterList,
            categoryImage: categoryImage,
            applyFilter: applyFilter,
            filterText: 'filter_by_trademark'.tr,
          ),
        },
        if (_filterController.typesFilterList.isNotEmpty &&
            _settingsCon.filter3barEnabled) ...{
          HorizontalListTypesFilter(
            categories: _filterController.typesFilterList,
            categoryImage: categoryImage,
            applyFilter: applyFilter,
            filterText: 'filter_by_type'.tr,
          ),
        },
        if (products.isNotEmpty) ...{

          _settingsCon.productBuilderType == '1'
              ? ProductBuilder1(products: products)
              : _settingsCon.productBuilderType == '2'
                  ? ProductBuilder2(products: products)
                  : _settingsCon.productBuilderType == '3'
                      ? ProductBuilder3(products: products)
                      : _settingsCon.productBuilderType == '4'
                          ? ProductBuilder1(products: products)
                          : ProductBuilder1(products: products)
        } else ...{
          EmptyView(text: 'no_products_found'.tr),
        }
      ],
    );
  }
}
