import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../ui/search/vendor_search_screen.dart';
import '../ui/chat/chat_screen.dart';
import '../ui/complaints_and_suggestions/complaints_and_suggestions_screen.dart';
import '../controllers/settings_controller.dart';
import '../ui/favorites/favoritesScreen.dart';
import '../ui/survey/survey_screen.dart';
import '../ui/user_addresses/user_addresses.dart';
import '../ui/user_orders/user_orders_screen.dart';
import 'custom_text.dart';
import '../controllers/language_controller.dart';
import '../ui/screen_navigator/screen_navigator.dart';
import '../controllers/categories_controller.dart';
import '../controllers/bottom_nav_bar_controller.dart';
import '../controllers/user_controller.dart';
import '../ui/account/login_options_screen.dart';
import '../ui/settings/settings_screen.dart';

class AppDrawer extends StatelessWidget {
  final SettingsController _settingsCon = Get.find<SettingsController>();

  final separator = Container(
    height: 2,
    color: Color(0xFFF3F5FF),
  );
  final userController = Get.find<UserController>();
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if(!_settingsCon.isMultiVendor)...{
            SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: CustomText(
                  text: 'app_categories'.tr,
                  size: 17,
                  weight: FontWeight.bold,
                ),
              ),
              GetBuilder<CategoriesController>(
                  init: Get.find(),
                  builder: (con) {
                    return Flexible(
                      child: ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: con.categoriesTypes.length,
                          itemBuilder: (context, index) {
                            return GetBuilder<BottomNavBarController>(
                                init: Get.find(),
                                builder: (navController) {
                                  return InkWell(
                                    onTap: () {
                                      Get.back();
                                      navController.currentIndex(1);
                                      con.categoryType.value =
                                          con.categoriesTypes[index].id;
                                      Get.to(
                                              ()=>ScreenNavigator(categoryIndex: index));
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        height: 40,
                                        alignment: Alignment.centerLeft,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.grey[200])),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: GetBuilder<LanguageController>(
                                              init: Get.find(),
                                              builder: (langCon) {
                                                return CustomText(
                                                  text: langCon.lang == 'ar'
                                                      ? con.categoriesTypes[index]
                                                      .nameAr
                                                      : con.categoriesTypes[index]
                                                      .nameEn,
                                                  size: 17,
                                                  color: _settingsCon.color2,
                                                );
                                              }),
                                        ),
                                      ),
                                    ),
                                  );
                                });
                          }),
                    );
                  }),
            },

            SizedBox(height: 20),
            Flexible(
              child: Container(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Expanded(
                    //     child: DrawerButton(
                    //   text: 'Home',
                    //   icon: Icons.home,
                    //   onTap: () {},
                    // )),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: CustomText(
                        text: 'tools'.tr,
                        size: 17,
                        weight: FontWeight.bold,
                      ),
                    ),
                    DrawerButton(
                      text: 'app_settings'.tr,
                      icon: Icons.settings,
                      onTap: () {
                        Get.back();
                        Get.to(() => SettingsScreen());
                      },
                    ),
                    DrawerButton(
                      text: 'search_for_product'.tr,
                      icon: Icons.search,
                      onTap: () {
                        Get.back();

                        // Get.to(() => SearchScreen());
                        Get.to(() => VendorSearchScreen());
                      },
                    ),
                    DrawerButton(
                        icon: Icons.favorite_border,
                        text: 'my_favorites'.tr,
                        onTap: () {
                          Get.back();
                          Get.to(userController.loggedIn
                              ? () => FavoritesScreen()
                              : () => LoginOptionsScreen());
                        }),
                    DrawerButton(
                      icon: Icons.add_shopping_cart,
                      text: 'my_orders'.tr,
                      onTap: () {
                        Get.back();
                        if (userController.loggedIn) {
                          Get.to(() => UserOrdersScreen());
                        } else {
                          Get.to(() => LoginOptionsScreen());
                        }
                      },
                    ),

                    DrawerButton(
                        icon: Icons.location_on_outlined,
                        text: 'my_addresses'.tr,
                        onTap: () {
                          Get.back();
                          Get.to(userController.loggedIn
                              ? () => UserAddressesScreen()
                              : () => LoginOptionsScreen());
                        }),

                    DrawerButton(
                        icon: Icons.question_answer_outlined,
                        text: 'survey'.tr,
                        onTap: () {
                          Get.back();
                          Get.to(userController.loggedIn
                              ? () => SurveyScreen('1')
                              : () => LoginOptionsScreen());

                        }),
                    DrawerButton(
                        icon: Icons.chat_outlined,
                        text: 'chat_with_us'.tr,
                        onTap: () {
                          Get.back();
                          Get.to(userController.loggedIn
                              ? () => ChatScreen('oeBBdsy8VZcMQqzdPu8J')
                              : () => LoginOptionsScreen());

                        }),
                    // DrawerButton(
                    //     icon: Icons.chat_outlined,
                    //     text: 'Admin Chat'.tr,
                    //     onTap: () {
                    //       Get.back();
                    //       Get.to(userController.loggedIn
                    //           ? () => UsersChatsList()
                    //           : () => WelcomeScreen());
                    //
                    //     }),
                    DrawerButton(
                        icon: Icons.headset_mic_outlined,
                        text: 'complaints_and_suggestions'.tr,
                        onTap: () {
                          Get.back();
                          Get.to(ComplaintsAndSuggestionsScreen());

                        }),

                    DrawerButton(
                        text: userController.loggedIn
                            ? 'log_out'.tr
                            : 'log_in'.tr,
                        icon: userController.loggedIn
                            ? Icons.logout
                            : Icons.login,
                        onTap: () {
                          Get.back();
                          userController.logOut();
                          Get.to(() => LoginOptionsScreen());
                        }),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DrawerButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final Function onTap;

  const DrawerButton({this.text, this.icon, this.onTap});

  @override
  Widget build(BuildContext context) {
    final SettingsController _settingsCon = Get.find<SettingsController>();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: InkWell(
          onTap: onTap,
          child: Container(
            decoration:
                BoxDecoration(border: Border.all(color: Colors.grey[200])),
            height: 40,
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    text: text,
                    size: 17,
                    color: _settingsCon.color2,
                  ),
                  Icon(icon, color: _settingsCon.color2),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
