import '../../common_widgets/dialogs_and_snacks.dart';
import '../../models/settings_model.dart';
import '../../services/api_base/api.dart';
import '../../services/api_base/api_service.dart';

class SettingsServices {
  SettingsServices._internal();

  static final SettingsServices _languageServices =
      SettingsServices._internal();

  static SettingsServices get instance => _languageServices;

  final APIService _apiService = APIService();

  Future<Settings> getAppSettings() async {
    final Map<String, String> settingsData = {};

    try {
      Map<String, dynamic> data =
          await _apiService.postData(endpoint: Endpoints.settingsSelect, body: {
        'source': 1,
        'group_id': '',
      });

      List<dynamic> json = data['data'];
      json.forEach((setting) {
        settingsData[setting['key_word']] = setting['value'];
      });
      Settings _settings = Settings.fromJson(settingsData);
      return _settings;
    } catch (e) {
      print("=================================================>   $e");
      showErrorDialog('Error Getting App Settings');
      return null;
    }
  }
}
