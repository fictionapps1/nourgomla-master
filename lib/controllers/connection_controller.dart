import 'dart:async';

import 'package:get/get.dart';
import 'package:connectivity/connectivity.dart';
import '../common_widgets/dialogs_and_snacks.dart';
import '../controllers/language_controller.dart';

class ConnectionController extends GetxController {
  final Connectivity _connectivity = Connectivity();
  StreamSubscription<ConnectivityResult> _streamSubscription;
  var connectionStatus = 0.obs;

  @override
  void onInit() {
    _streamSubscription = _connectivity.onConnectivityChanged.listen((event) {
      checkConnection();
    });
    super.onInit();
  }

  @override
  onClose() {
    _streamSubscription.cancel();
    super.onClose();
  }

  Future<bool> checkConnection() async {
    ConnectivityResult result;
    try {
      result = await _connectivity.checkConnectivity();
      bool connected = _updateConnectionStatus(result);
      if (connected) {
        Get.put<LanguageController>(LanguageController(), permanent: true);
      }

      return connected;
    } catch (e) {
      print('Connectivity Error=====> $e');
      return false;
    }
  }

  bool _updateConnectionStatus(ConnectivityResult result) {

    switch (result) {
      case ConnectivityResult.wifi:
        connectionStatus.value = 1;
        return true;

      case ConnectivityResult.mobile:
        connectionStatus.value = 2;
        return true;

      case ConnectivityResult.none:
        connectionStatus.value = 3;

        return false;

      default:
        showErrorDialog('Check Your Connection And Try Again');
        return false;
    }
  }
}
