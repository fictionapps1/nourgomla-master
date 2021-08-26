import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../controllers/language_controller.dart';
import '../controllers/user_controller.dart';
import '../models/product.dart';
import '../controllers/drop_down_controller.dart';
import '../services/api_calls/search_products_service.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter/services.dart';

class SearchController extends GetxController {
  SearchProductsService _searchProductsService = SearchProductsService.instance;
  final LanguageController _langController = Get.find<LanguageController>();
  final TextEditingController textController = TextEditingController();
  DropDownController dropDownController = Get.find<DropDownController>();
  ScrollController scrollController = ScrollController();
  final userController = Get.find<UserController>();
  List<Product> searchList = <Product>[];
  RxBool loading = false.obs;
  int itemsPerPage = 10;
  int startIndex = 0;
  int totalCount = 0;

  onInit() {
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        getMoreProducts(body: {
          'itemsPerPage': itemsPerPage,
          'startIndex': startIndex,
          'user_role_id': userController.userRole,
          'language_id': _langController.langId(),
          'sort_by': dropDownController.selectedItem.values,
          'user_id': userController.userId,
          'name': textController.text,
          'barcode': '',
        });
      }
    });
    super.onInit();
  }

  onClose() {
    scrollController.dispose();
    textController.dispose();
    super.onClose();
  }

  Future getProducts({String barCode}) async {
    try {
      startIndex = 0;
      loading.value = true;
      searchList.clear();
      Map<String, dynamic> searchResult =
          await _searchProductsService.searchProducts({
        'itemsPerPage': itemsPerPage,
        'startIndex': startIndex,
        'user_role_id': userController.userRole,
        'language_id': 1,
        'sort_by': dropDownController.selectedItem.values,
        'user_id': userController.userId,
        'name': textController.text,
        'barcode': barCode ?? '',
      });
      searchList.addAll(searchResult['products']);
      totalCount = searchResult['total_count'];
      loading.value = false;
      startIndex = startIndex + itemsPerPage;
    } catch (e) {
      loading.value = false;
      print("=========================> $e");
    }
  }

  Future getMoreProducts({Map body}) async {
    try {
      if (startIndex < totalCount) {
        loading.value = true;
        Map<String, dynamic> searchResult =
            await _searchProductsService.searchProducts(body);
        searchList.addAll(searchResult['products']);
        startIndex = startIndex + itemsPerPage;
        loading.value = false;
      }
    } catch (e) {
      loading.value = false;
      print("=========================> $e");
    }
  }

  Future<void> scanBarcode() async {
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          "#ff6666", "Cancel", true, ScanMode.BARCODE);
      print(barcodeScanRes);
      if (barcodeScanRes != null) {
        textController.clear();
        searchList.clear();
        await getProducts(barCode: barcodeScanRes);
        update();
      }
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }
  }
}
