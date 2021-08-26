import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import '../common_widgets/dialogs_and_snacks.dart';
import '../ui/products/product_details_screen.dart';
import '../ui/products/products_page.dart';

class FcmController extends GetxController {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseMessaging _fcm = FirebaseMessaging();
  StreamSubscription iosSubscription;
  String token = '';

  @override
  void onInit() {
    super.onInit();
    if (Platform.isIOS) {
      iosSubscription = _fcm.onIosSettingsRegistered.listen((data) {
        // save the token  OR subscribe to a topic here
      });

      _fcm.requestNotificationPermissions(IosNotificationSettings());
    }
    _saveDeviceToken();
    _fcm.subscribeToTopic('all');
    configureFcm();
  }

  @override
  void onClose() {
    iosSubscription.cancel();
    super.onClose();
  }

  configureFcm() {
    _fcm.configure(
      onMessage: (Map<String, dynamic> message) async {
        print(
            "onMessage======================================================>  : $message");
        // showNormalDialog(
        //     title: message['notification']['title'],
        //     msg: message['notification']['body'],
        //     onTapped: () {
        //       Get.back();
        //     });

        if (message['data']['page'] == 'product') {
          Get.to(
                () => ProductDetailsScreen(
                productId: int.parse(message['data']['id']), type: '1'),
          );
        }
        if (message['data']['page'] == 'category') {
          Get.to(
                () => ProductsPage(categoryId: int.parse(message['data']['id'])),
          );
        }
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
        showNormalDialog(
            title: message['notification']['title'],
            msg: message['notification']['body'],
            onTapped: () {
              Get.back();
            });
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
        showNormalDialog(
            title: message['notification']['title'],
            msg: message['notification']['body'],
            onTapped: () {
              Get.back();
            });
      },
    );
  }

  _saveDeviceToken() async {
    String uid = 'jeffd23';
    String fcmToken = await _fcm.getToken();
    token = fcmToken;
    update();
    print(
        'FCM TOKEN===========================================*****  >>  $fcmToken');
    // Save it to Firestore
    if (fcmToken != null) {
      var tokens =
      _db.collection('users').doc(uid).collection('tokens').doc(fcmToken);

      await tokens.set({
        'token': fcmToken,
        'createdAt': FieldValue.serverTimestamp(), // optional
        'platform': Platform.operatingSystem // optional
      });
    }
  }
}
