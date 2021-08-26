import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:get/get.dart';
import '../services/api_calls/dynamic_link_service.dart';

class DynamicLinkController extends GetxController {
  @override
  void onInit() {
    DynamicLinkService _dynamicLinkService = DynamicLinkService();
    _dynamicLinkService.handleDynamicLinks();
    super.onInit();
  }

  Future<String> createSharableDynamicLink(int id, bool isProduct) async {
    final DynamicLinkParameters parameters = DynamicLinkParameters(
      uriPrefix: 'https://nourgomla.page.link',
      link: Uri.parse(
          'http://api.nourgomla.com/public/${isProduct ? 'product' : 'category'}?id=$id'),
      androidParameters: AndroidParameters(
        packageName: 'com.fictionapps.nourgomla',
      ),
      // NOT ALL ARE REQUIRED ===== HERE AS AN EXAMPLE =====
      iosParameters: IosParameters(
        bundleId: 'com.fictionapps.nourgomla.ios',
        minimumVersion: '1.0.1',
        appStoreId: '123456789',
      ),
      googleAnalyticsParameters: GoogleAnalyticsParameters(
        campaign: 'nourgomla-promo',
        medium: 'social',
        source: 'orkut',
      ),
      itunesConnectAnalyticsParameters: ItunesConnectAnalyticsParameters(
        providerToken: '123456',
        campaignToken: 'nourgomla-promo',
      ),
      socialMetaTagParameters: SocialMetaTagParameters(
        title: 'nourgomla of a Dynamic Link',
        description: 'This link works whether app is installed or not!',
      ),
    );

    final ShortDynamicLink shortDynamicLink = await parameters.buildShortLink();
    final Uri shortUrl = shortDynamicLink.shortUrl;
    return shortUrl.toString();
  }
}
