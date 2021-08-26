import 'dart:async';

import 'package:get/get.dart';

class TimerController extends GetxController {
  Timer _timer;

  RxBool timerStarted = false.obs;
  RxInt secCounter = 60.obs;

  void startTimer() {
    timerStarted(true);
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      secCounter.value--;
      if (secCounter.value <= 0) {
        timerStarted(false);

        secCounter.value = 60;
        _timer.cancel();
      }
    });
  }

  @override
  void onClose() {
    _timer.cancel();
    super.onClose();
  }
}
