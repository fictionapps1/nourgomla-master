import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../ui/rating/rating_screen.dart';
import '../../common_widgets/dialogs_and_snacks.dart';
import '../../common_widgets/nav_animation_state.dart';
import '../../common_widgets/custom_appbar.dart';
import '../../common_widgets/drawer.dart';
import 'widgets/acc_widgets_list.dart';
import '../../common_widgets/common_button.dart';
import '../../common_widgets/corners.dart';
import '../../common_widgets/custom_text.dart';
import '../../controllers/settings_controller.dart';
import '../../controllers/user_controller.dart';
import '../../ui/account/login_options_screen.dart';
import '../../ui/favorites/favoritesScreen.dart';
import '../../ui/user_addresses/user_addresses.dart';
import '../../ui/user_orders/user_orders_screen.dart';
import '../../ui/user_profile/profile_screen.dart';

class AccountScreen extends StatefulWidget {
  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends NavAnimationState<AccountScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final SettingsController _settingsCon = Get.find<SettingsController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        drawer: AppDrawer(),
        appBar: CustomAppBar(
          scaffoldKey: _scaffoldKey,
          centerWidget: CustomText(
            text: 'account'.tr,
            size: 18,
            weight: FontWeight.bold,
          ),
        ),
        body: AnimatedBuilder(
          animation: animationController,
          builder: (BuildContext context, Widget child) {
            return FadeTransition(
                opacity: animation,
                child: Transform(
                    transform: Matrix4.translationValues(
                        0.0, 100 * (1.0 - animation.value), 0.0),
                    child: child));
          },
          child: SingleChildScrollView(
            physics: ScrollPhysics(),
            child: GetBuilder<UserController>(
                init: Get.find<UserController>(),
                builder: (userController) {
                  return Column(
                    children: [
                      Container(
                        height: 400,
                        width: double.infinity,
                        color: _settingsCon.color1,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            userController.loggedIn
                                ? Column(
                                    children: [
                                      Container(
                                        height: 120,
                                        width: 120,
                                        child: CircleAvatar(
                                          radius: 60,
                                          backgroundColor: Colors.white12,
                                          foregroundColor: Colors.black,
                                          child: CustomText(
                                            text: userController
                                                .currentUser.firstName[0] +
                                                ' ' +
                                                userController
                                                    .currentUser.lastName[0],
                                            size: 40,
                                            weight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      CustomText(
                                          text: userController
                                              .currentUser.firstName,
                                          size: 20,
                                          weight: FontWeight.bold),
                                      SizedBox(height: 10),
                                      CustomText(
                                          text:
                                              userController.currentUser.phone),
                                      // Text(userController.currentUser.id.toString()),
                                      SizedBox(height: 30),
                                    ],
                                  )
                                : SizedBox(),
                            CommonButton(
                              text: userController.loggedIn
                                  ? 'edit_profile'.tr
                                  : 'log_in'.tr,
                              onTap: () {
                                if (userController.loggedIn) {
                                  Get.to(() => ProfileScreen());
                                } else {
                                  Get.to(() => LoginOptionsScreen());
                                }
                              },
                              corners: Corners(10, 10, 10, 10),
                              containerColor: Colors.white,
                              height: 50,
                              width: 250,
                              textColor: 'FF000000',
                            )
                          ],
                        ),
                      ),
                      AccountWidget(
                          icon: Icons.favorite_border,
                          accountItemText: 'my_favorites'.tr,
                          onPressed: () => Get.to(userController.loggedIn
                              ?()=> FavoritesScreen()
                              : ()=> LoginOptionsScreen())),
                      AccountWidget(
                        icon: Icons.add_shopping_cart,
                        accountItemText: 'my_orders'.tr,
                        onPressed: () {
                          if (userController.loggedIn) {
                            Get.to(() => UserOrdersScreen());
                          } else {
                            Get.to(() => LoginOptionsScreen());
                          }
                        },
                      ),

                      AccountWidget(
                          icon: Icons.location_on_outlined,
                          accountItemText: 'my_addresses'.tr,
                          onPressed: () => Get.to(userController.loggedIn
                              ? ()=> UserAddressesScreen()
                              :()=>  LoginOptionsScreen())),
                      if(_settingsCon.reviewEnabled)
                      AccountWidget(
                          icon: Icons.star_border,
                          accountItemText: 'my_rates'.tr,
                          onPressed: () => Get.to(userController.loggedIn
                              ? ()=> RatingScreen(isUserRates:true)
                              :()=>  LoginOptionsScreen())),
                      if (userController.loggedIn)
                        AccountWidget(
                          icon: Icons.logout,
                          accountItemText: 'log_out'.tr,
                          onPressed: () {
                            showTwoButtonsDialog(
                                msg: 'do_you_really_want_to_log_out'.tr,
                                onCancelTapped: () => Get.back(),
                                onOkTapped: () {
                                  Get.back();
                                  userController.logOut();
                                });
                          },
                        ),
                      // AccountWidgets(
                      //     icon: Icons.info_outline,
                      //     accountItemText: 'Help !',
                      //     onPressed: () => Get.to(Container())),
                      // AccountWidgets(
                      //     icon: Icons.info_outline,
                      //     accountItemText: 'Privacy Policies',
                      //     onPressed: () => Get.to(Container())),
                    ],
                  );
                }),
          ),
        ),
      ),
    );

    // ListView.builder(
    //     physics: NeverScrollableScrollPhysics(),
    //     shrinkWrap: true,
    //     padding: const EdgeInsets.all(8),
    //     itemCount: controller.accountList.length,
    //     itemBuilder: (BuildContext context, index) {
    //       return AccountWidgets(
    //           accountItemImageUrl: '',
    //           cardElevation: 1,
    //           icon: controller.accountList[index].icon,
    //           accountItemText:
    //           '${controller.accountList[index].text}',
    //           onPressed: () {
    //             controller.onAccountItemPressed(
    //                 controller.accountList[index].pageName);
    //           });
    //     }),

    /*CustomScrollView(
                slivers: <Widget>[
                  const SliverAppBar(
                    pinned: true,
                    expandedHeight: 250.0,
                    flexibleSpace: FlexibleSpaceBar(
                      title: Text('Demo'),
                    ),
                  ),
                  ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      padding: const EdgeInsets.all(8),
                      itemCount: controller.accountList.length,
                      itemBuilder: (BuildContext context, index) {
                        return AccountWidgets(accountItemImageUrl: '',cardElevation: 1,accountItemText:'${controller.accountList[index].text}',onPressed:(){
                          controller.onAccountItemPressed(controller.accountList[index].pageName);});
                      }

                  ),
                ],

              );*/
  }
}
