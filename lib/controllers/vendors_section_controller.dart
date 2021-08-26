import 'package:get/get.dart';
import '../services/api_calls/vendors_services.dart';
import '../models/category.dart';

class VendorsSectionController extends GetxController {
  VendorsServices _vendorsServices = VendorsServices.instance;
  List<Category> vendors = [];
  @override
  void onInit() {
    initCategories();
    super.onInit();
  }

  Future initCategories() async {
    try {
      vendors = await _vendorsServices.getAllVendors();
    } catch (e) {
      print(e);
    }
  }
}
