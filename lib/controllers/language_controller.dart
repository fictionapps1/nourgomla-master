import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../services/api_calls/language_services.dart';
import '../services/local_storage/lang_storage.dart';

class LanguageController extends GetxController {
  LanguageServices _languageServices = LanguageServices.instance;
  LocalStorage _localStorage = LocalStorage();
  String lang;

  RxMap<String, String> langData = <String, String>{}.obs;

  @override
  void onInit() {
    initLangData();
    super.onInit();
  }

  initLangData() async {
    lang = await _localStorage.getFromLocalStorge == null
        ? "ar"
        : await _localStorage.getFromLocalStorge;
    Get.updateLocale(Locale(lang));
    print(
        "CURRENT LANGUAGE============>  ${await _localStorage.getFromLocalStorge}");
    langData.assignAll(await getLabels(langId()));
  }

  String langId() => lang == 'ar' ? '1' : '2';

  void toggleLanguage(String localValue) async {
    lang = localValue;
    update();
    _localStorage.saveInLocalStorge(localValue);
    langData.clear();
    langData.assignAll(await getLabels(langId()));
    print("CURRENT LANGUAGE============>  $lang");
  }

  Future<Map<String, String>> getLabels(String langId) async {
    try {
      final labels = await _languageServices.getLabels(langId);
      print("LABELS ==============================================>  $labels");
      return labels;
    } catch (e) {
      print(e);
      return null;
    }
  }
}
