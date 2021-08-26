import 'package:flutter/material.dart';
import '../../common_widgets/loading_view.dart';
import '../../common_widgets/custom_text.dart';
import '../../controllers/settings_controller.dart';
import '../../controllers/survey_controller.dart';
import '../../ui/survey/widgets/surve_card.dart';
import 'package:get/get.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import '../../ui/survey/widgets/survey_complete_widget.dart';

class SurveyScreen extends StatefulWidget {
  final String surveyType;

  SurveyScreen(this.surveyType);

  @override
  _SurveyScreenState createState() => _SurveyScreenState();
}

class _SurveyScreenState extends State<SurveyScreen> {
  final SettingsController _settingsCon = Get.find<SettingsController>();

  PageController _scrollController;
  int _currentIndex = 0;
  @override
  void initState() {
    _scrollController = PageController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Get.put(SurveyController(widget.surveyType));
    return Scaffold(
        appBar: AppBar(
          title: Text('survey'.tr),
          centerTitle: true,
          backgroundColor: _settingsCon.color1,
        ),
        body: Container(
          child: GetBuilder<SurveyController>(
              init: Get.find(),
              builder: (con) {
                return con.isLoading
                    ? LoadingView()
                    : con.surveyData.length == 0 ||
                            _currentIndex >= con.surveyData.length
                        ? SurveyCompleteWidget()
                        : Column(
                            children: [
                              Expanded(
                                flex: 20,
                                child: PageView.builder(
                                    controller: _scrollController,
                                    onPageChanged: (page) {
                                      setState(() {
                                        _currentIndex = page;
                                      });
                                    },
                                    physics: NeverScrollableScrollPhysics(),
                                    scrollDirection: Axis.horizontal,
                                    itemCount: con.surveyData.length,
                                    itemBuilder: (context, index) {
                                      return SurveyCard(
                                        survey: con.surveyData[index],
                                      );
                                    }),
                              ),
                              Container(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Expanded(
                                      child: RoundedLoadingButton(
                                        child: Text('confirm_answer'.tr,
                                            style:
                                                TextStyle(color: Colors.white)),
                                        controller: con.btnController,
                                        height: 40,
                                        width: 120,
                                        onPressed: con.surveyData[_currentIndex]
                                                    .selectedChoice ==
                                                null
                                            ? null
                                            : () async {
                                                bool succeed =
                                                    await con.submitAnswer(
                                                        answer: con
                                                            .surveyData[
                                                                _currentIndex]
                                                            .selectedChoice,
                                                        questionId: con
                                                            .surveyData[
                                                                _currentIndex]
                                                            .id);
                                                if (succeed) {
                                                  if (_currentIndex ==
                                                      con.surveyData.length -
                                                          1) {
                                                    setState(() {
                                                      _currentIndex++;
                                                    });
                                                  }

                                                  goToNextPage(_currentIndex);
                                                }
                                              },
                                        color: _settingsCon.color2,
                                      ),
                                    ),
                                    Expanded(
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            CustomText(
                                                text: (_currentIndex + 1)
                                                    .toString(),
                                                color: _settingsCon.color2,
                                                size: 18,
                                                weight: FontWeight.bold),
                                            const SizedBox(width: 15),
                                            CustomText(
                                              text: 'of'.tr,
                                              color: Colors.black,
                                              size: 18,
                                            ),
                                            const SizedBox(width: 15),
                                            CustomText(
                                                text: con.surveyData.length
                                                    .toString(),
                                                color: _settingsCon.color2,
                                                size: 18,
                                                weight: FontWeight.bold),
                                          ]),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 10),
                            ],
                          );
              }),
        ));
  }

  goToNextPage(int i) {
    _scrollController.animateToPage(i + 1,
        duration: Duration(milliseconds: 200), curve: Curves.ease);
  }

  goToPrevPage(int i) {
    _scrollController.animateToPage(i - 1,
        duration: Duration(milliseconds: 200), curve: Curves.ease);
  }
}
