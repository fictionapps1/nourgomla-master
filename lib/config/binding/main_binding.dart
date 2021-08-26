
import 'package:get/get.dart';
import 'package:nourgomla/controllers/fcm_controller.dart';
import '../../controllers/location_controller.dart';
import '../../controllers/settings_controller.dart';
import '../../controllers/search_controller.dart';
import '../../controllers/cart_controller.dart';
import '../../controllers/orders_controller.dart';
import '../../controllers/user_controller.dart';

class MainBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<FcmController>(FcmController(), permanent: true);
    Get.put<UserController>(UserController(), permanent: true);
    Get.put<LocationController>(LocationController(), permanent: true);
    Get.put<SettingsController>(SettingsController(), permanent: true);
    Get.put<CartController>(CartController(), permanent: true);
    Get.lazyPut<SearchController>(() => SearchController());
    Get.lazyPut<OrdersController>(() => OrdersController());
  }
}
