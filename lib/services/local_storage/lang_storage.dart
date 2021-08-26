import 'package:get_storage/get_storage.dart';

class LocalStorage {
  /// saveInLocalStorge
  void saveInLocalStorge(String langLocal) async =>
      await GetStorage().write("language", langLocal);

  /// getFromLocalStorge
  Future<String> get getFromLocalStorge async =>
      await GetStorage().read("language");
}
