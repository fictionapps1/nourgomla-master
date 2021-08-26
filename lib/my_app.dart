import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'ui/no_connection_screen.dart';
import 'config/app_translation.dart';
import 'config/binding/main_binding.dart';
import 'ui/splash/splash_screen.dart';
import 'controllers/language_controller.dart';
import 'controllers/connection_controller.dart';

class MyApp extends GetView<ConnectionController> {
  // final LanguageController langCon;
  // MyApp(this.langCon);

  @override
  Widget build(BuildContext context) {
    print(
        'CONNECTION STATUS===========================> ${controller.connectionStatus.value}');
    return Obx(() {
      if (controller.connectionStatus.value == 3 ||
          controller.connectionStatus.value == 0) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Nour Gomla',
          home: NoConnectionScreen(),
        );
      } else {
        final LanguageController langCon = Get.find<LanguageController>();

        return GetMaterialApp(
          initialBinding: MainBinding(),
          defaultTransition: Transition.downToUp,
          debugShowCheckedModeBanner: false,
          translations: AppTranslation(),
          locale: Locale(langCon.lang),
          fallbackLocale: Locale('en'),
          title: 'Nour Gomla',
          home: SplashScreen(),
        );
      }
    });
  }
}
