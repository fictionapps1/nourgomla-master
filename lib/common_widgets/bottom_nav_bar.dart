import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/settings_controller.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function onPressed;

  const BottomNavBar({
    this.currentIndex,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final SettingsController _settingsCon = Get.find<SettingsController>();
    return BottomNavigationBar(
      onTap: onPressed,
      currentIndex: currentIndex,
      selectedItemColor: _settingsCon.color4,
      unselectedItemColor: Colors.grey[600],
      elevation: 0,
      type: BottomNavigationBarType.fixed,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: "home".tr,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.category),
          label: _settingsCon.isMultiVendor?"vendors".tr:"sections".tr,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.shopping_cart),
          label: "cart".tr,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: "account".tr,
        ),
      ],
    );
  }
}
