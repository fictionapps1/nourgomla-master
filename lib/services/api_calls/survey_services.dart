import '../../common_widgets/dialogs_and_snacks.dart';
import '../../controllers/user_controller.dart';
import '../../models/survey_model.dart';
import '../../services/api_base/api.dart';
import '../../services/api_base/api_service.dart';
import 'package:get/get.dart';

class SurveyServices {
  final UserController _userController = Get.find<UserController>();

  SurveyServices._internal();

  static final SurveyServices _languageServices = SurveyServices._internal();

  static SurveyServices get instance => _languageServices;

  final APIService _apiService = APIService();

  Future<List<SurveyModel>> getSurveyData(String type) async {

    try {
      Map<String, dynamic> json =
          await _apiService.postData(endpoint: Endpoints.surveySelect, body: {
        'user_id': _userController.userId,
        'type': type,
      });
      List data = json['data'];

      return data.map((e) => SurveyModel.fromJson(e)).toList();
    } catch (e) {
      showErrorDialog('Error Getting Survey Data');
      return null;
    }
  }

  Future<bool>submitAnswer(String answer, int questionId) async {
    print(_userController.userId);
    print(answer);
    print(questionId);
    try {
      Map<String, dynamic> json = await _apiService
          .postData(endpoint: Endpoints.surveyAnswerInsert, body: {
        'user_id': _userController.userId,
        'answer': answer,
        'question_id': questionId,
      });
      print(json['success']);
      return json['success'];
      // List data = json['data'];
      //
      // return data.map((e) => SurveyModel.fromJson(e)).toList();
    } catch (e) {
      showErrorDialog('Error Getting Survey Data');
      return false;
    }
  }

}
