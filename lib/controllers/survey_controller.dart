import 'package:get/get.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import '../models/survey_model.dart';
import '../services/api_calls/survey_services.dart';

class SurveyController extends GetxController {
  final RoundedLoadingButtonController btnController =
      RoundedLoadingButtonController();
  SurveyServices _surveyServices = SurveyServices.instance;
  List<SurveyModel> surveyData = [];
  bool isLoading = false;
  final surveyType;

  SurveyController(this.surveyType);

  onInit() {
    getSurveyData();
    super.onInit();
  }

  onClose() {
    surveyData.clear();
  }

  getSurveyData() async {
    isLoading = true;
    surveyData = await _surveyServices.getSurveyData(surveyType);
    isLoading = false;
    update();
  }

  Future<bool> submitAnswer({String answer, int questionId}) async {
    bool succeed = await _surveyServices.submitAnswer(answer, questionId);
    if (succeed) {
      btnController.reset();
      return succeed;
    } else {
      return false;
    }
  }
}
