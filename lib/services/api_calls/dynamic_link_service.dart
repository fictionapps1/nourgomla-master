import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:get/get.dart';
import '../../ui/products/product_details_screen.dart';
import '../../ui/products/products_page.dart';

class DynamicLinkService {
  Future handleDynamicLinks() async {
    // 1. Get the initial dynamic link if the app is opened with a dynamic link
    final PendingDynamicLinkData data =
        await FirebaseDynamicLinks.instance.getInitialLink();

    // 2. handle link that has been retrieved
    _handleDeepLink(data);

    // 3. Register a link callback to fire if the app is opened up from the background
    // using a dynamic link.
    FirebaseDynamicLinks.instance.onLink(
        onSuccess: (PendingDynamicLinkData dynamicLink) async {
      // 3a. handle link that has been retrieved
      _handleDeepLink(dynamicLink);
    }, onError: (OnLinkErrorException e) async {
      print('Link Failed: ${e.message}');
    });
  }

  void _handleDeepLink(PendingDynamicLinkData data) {
    final Uri deepLink = data?.link;
    if (deepLink != null) {
      print('_handleDeepLink | deeplink: $deepLink');
      var isProduct = deepLink.pathSegments.contains('product');
      var isCategory = deepLink.pathSegments.contains('category');
      var id = deepLink.queryParameters['id'];
      if (isProduct) {
        print('DEEP LINK PRODUCT ID********************>> $id');
        Get.to(ProductDetailsScreen(productId: int.parse(id),type: '1',));
      }
      if (isCategory) {
        print('DEEP LINK CATEGORY ID********************>> $id');
        Get.to((ProductsPage(categoryId: int.parse(id),)));
      }
    }
  }
}
