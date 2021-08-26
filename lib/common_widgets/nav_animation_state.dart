import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/settings_controller.dart';

abstract class NavAnimationState<T extends StatefulWidget> extends State<T>
    with SingleTickerProviderStateMixin {
  final SettingsController _settingsCon = Get.find<SettingsController>();
  AnimationController animationController;
  Animation<double> animation;

  @override
  void initState() {
    animationController = _settingsCon.animationController(this);
    animation = _settingsCon.animation(animationController);
    animationController.forward();
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }
}
