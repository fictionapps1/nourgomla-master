import 'package:flutter/material.dart';
import '../controllers/settings_controller.dart';
import 'cached_image.dart';
import 'package:get/get.dart';

class CustomAppBar extends PreferredSize {
  final SettingsController _settingsCon = Get.find<SettingsController>();
  final double height;
  final Widget rightWidget;
  final Widget leftWidget;
  final Widget bottomWidget;
  final Widget centerWidget;
  final String image;
  final GlobalKey<ScaffoldState> scaffoldKey;


  CustomAppBar({
    this.scaffoldKey,
    this.rightWidget,
    this.leftWidget,
    this.centerWidget,
    this.image,
    this.height = kToolbarHeight,
    this.bottomWidget,
  });

  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: preferredSize.height,
      color: _settingsCon.color1,
      alignment: Alignment.center,
      child: Stack(
        children: [
          if (image != null)
            Align(
                alignment: Alignment.center,
                child: CachedImage(image, notFromOurApi: true)),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      leftWidget ?? SizedBox(),
                      IconButton(
                          icon: Icon(Icons.menu),
                          onPressed: () {
                            print('Tapped');
                            scaffoldKey.currentState.openDrawer();
                          })
                    ],
                  ),
                  centerWidget ?? SizedBox(),
                  rightWidget ?? SizedBox(),
                ],
              ),
              bottomWidget != null
                  ? Padding(
                      padding: const EdgeInsets.only(
                          left: 12.0, right: 12.0, top: 5),
                      child: bottomWidget)
                  : SizedBox(),
            ],
          ),
        ],
      ),
    );
  }
}
