
import '../../services/api_base/api.dart';
import '../../services/api_base/api_service.dart';

class LanguageServices {
  LanguageServices._internal();

  static final LanguageServices _languageServices =
      LanguageServices._internal();

  static LanguageServices get instance => _languageServices;

  final APIService _apiService = APIService();

  Future<Map<String, String>> getLabels(String langId) async {
    final Map<String, String> langData = {};
    try {
      Map<String, dynamic> data =
          await _apiService.postData(endpoint: Endpoints.LabelsSelect, body: {
        'id': '',
        'type': '3',
        'label_key': '',
        'language_id': langId,
      });

      List<dynamic> json = data['data'];

      json.forEach((lang) {
        langData[lang['label_key']] = lang['label_value'];
      });
      return langData;
    } catch (e) {
      // showErrorDialog('Error Getting App Labels');
      return langData;
    }
  }
}
