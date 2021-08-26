import 'package:get/get.dart';
import '../models/category.dart';

class FilterController extends GetxController {
  List<Category> companiesFilterList = [];
  List<Category> trademarksFilterList = [];
  List<Category> typesFilterList = [];
  List<Category> filterEntries = [];
  final List<Category> orderList = <Category>[
    Category(nameEn: "new", nameAr: "new".tr),
    Category(nameEn: "old", nameAr: "old".tr),
    Category(nameEn: "a-z", nameAr: "a-z".tr),
    Category(nameEn: "z-a", nameAr: "z-a".tr),
    Category(nameEn: "lowest_price", nameAr: "lowest_price".tr),
    Category(nameEn: "highest_price", nameAr: "highest_price".tr),
  ];

  String selectedOrder = '';
  String selectedCompany = '';
  String selectedTrademark = '';
  String selectedType = '';

  selectFilter(Category root, Category entry) {
    root.children.forEach((element) {
      element.isSelected = false;
    });
    entry.isSelected = true;

    selectEntryId(
        root.nameEn, entry.id != null ? entry.id.toString() : entry.nameEn);
    update();
  }

  selectEntryId(String rootName, String filterId) {
    switch (rootName) {
      case 'order':
        selectedOrder = filterId;
        break;
      case 'company':
        selectedCompany = filterId;
        break;
      case 'trademark':
        selectedTrademark = filterId;
        break;
      case 'type':
        selectedType = filterId;
        break;
    }
  }

  initFilter({
    List<Category> companiesList,
    List<Category> trademarksList,
    List<Category> typesList,
  }) {
    if (companiesList.isNotEmpty) companiesFilterList = companiesList;
    if (trademarksList.isNotEmpty) trademarksFilterList = trademarksList;
    if (typesList.isNotEmpty) typesFilterList = typesList;
    filterEntries = [
      Category(
        nameEn: 'order',
        nameAr: 'الترتيب',
        children: orderList,
      ),
      Category(
        nameEn: 'company',
        nameAr: 'الشركة',
        children: companiesFilterList,
      ),
      Category(
        nameEn: 'trademark',
        nameAr: 'العلامة التجارية',
        children: trademarksFilterList,
      ),
      Category(
        nameEn: 'type',
        nameAr: 'النوع',
        children: typesFilterList,
      ),
    ];
    update();
  }

  resetFilter() {
    selectedOrder = '';
    selectedCompany = '';
    selectedTrademark = '';
    selectedType = '';

    filterEntries.forEach((element) {
      element.children.forEach((e) {
        e.isSelected = false;
      });
    });
    update();
  }

  resetCompaniesFilter() {
    selectedCompany = '';
    companiesFilterList.forEach((element) {
      element.isSelected = false;
    });
    update();
  }

  resetTradeMarksFilter() {
    selectedTrademark = '';
    trademarksFilterList.forEach((element) {
      element.isSelected = false;
    });
    update();
  }

  resetTypesFilter() {
    selectedType = '';
    typesFilterList.forEach((element) {
      element.isSelected = false;
    });
    update();
  }
}
