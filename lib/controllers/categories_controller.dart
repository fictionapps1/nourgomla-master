import 'package:get/get.dart';
import '../models/category.dart';
import '../models/category_type.dart';
import '../services/api_calls/category_services.dart';

class CategoriesController extends GetxController
    with StateMixin<List<Category>> {
  CategoryServices _categoryServices = CategoryServices.instance;
  List<CategoryType> categoriesTypes = [];

  RxInt categoryType = 1.obs;
  RxString queryName = ''.obs;

  @override
  void onInit() {
    super.onInit();
    initCategories();
    getCategoriesType();
    debounce<String>(queryName, (value) => initCategories());
    ever<int>(categoryType, (value) => initCategories());
  }

  Future initCategories() async {
    try {
      change([], status: RxStatus.loading());
      Map<String, dynamic> categoriesData =
          await _categoryServices.getCategories(
        type: categoryType.value.toString(),
        parentId: '',
        queryName: queryName.value,
        vendorId: '',
      );
      List<Category> categories = categoriesData['categories'];
      if (categories.isNotEmpty) {
        change(categories, status: RxStatus.success());
      } else {
        change([], status: RxStatus.empty());
      }
    } catch (e) {
      print(e);
      change(null, status: RxStatus.error(e.toString()));
    }
  }

  Future<List<CategoryType>> getCategoriesType() async {
    try {
      categoriesTypes = await _categoryServices.getCategoriesType();
      update();
      return categoriesTypes;
    } catch (e) {
      print(e);
      return [];
    }
  }
}
