import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../ui/vendors/all_vendors_screen.dart';
import '../../controllers/settings_controller.dart';
import '../../common_widgets/bottom_nav_bar.dart';
import '../../common_widgets/custom_text.dart';
import '../../controllers/bottom_nav_bar_controller.dart';
import '../../controllers/drop_down_controller.dart';
import '../../ui/account/account_screen.dart';
import '../../ui/cart/cart_screen.dart';
import '../../ui/home/home_screen.dart';
import '../../ui/sections/sections_screen.dart';
import '../../controllers/dynamic_link_controller.dart';

class ScreenNavigator extends StatelessWidget {
  final dropController = Get.put(DropDownController(), permanent: true);
  final SettingsController _settingsCon = Get.find<SettingsController>();

  final dynamicLinkCon =
  Get.put<DynamicLinkController>(DynamicLinkController());

  final int categoryIndex;

  ScreenNavigator({this.categoryIndex});

  Widget getScreen(int index) {
    final List<Widget> homeWidgets = [
      HomeScreen(),
      _settingsCon.isMultiVendor
          ? AllVendorsScreen()
          : SectionsScreen(categoryIndex),
      CartScreen(),
      AccountScreen(),
    ];
    return homeWidgets[index];
  }

  @override
  Widget build(BuildContext context) {
    Future<bool> onWillPop() async {
      return (await showDialog(
        context: context,
        builder: (context) => new AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20)),
          title: CustomText(
            text: 'are_you_sure'.tr,
            size: 18,
            weight: FontWeight.bold,
          ),
          content: Text(
            'do_you_want_to_exit_the_app'.tr,
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text('cancel'.tr),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: Text('ok'.tr),
            ),
          ],
        ),
      )) ??
          false;
    }

    return WillPopScope(
      onWillPop: onWillPop,
      child: GetX(
          init: Get.find<BottomNavBarController>(),
          builder: (BottomNavBarController controller) {
            return Scaffold(
              body: getScreen(controller.currentIndex.value),
              bottomNavigationBar: BottomNavBar(
                  currentIndex: controller.currentIndex.value,
                  onPressed: (index) {
                    controller.currentIndex(index);
                  }),
            );
          }),
    );
  }
}
