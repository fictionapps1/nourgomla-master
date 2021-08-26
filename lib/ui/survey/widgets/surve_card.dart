import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../common_widgets/custom_text.dart';
import '../../../common_widgets/image_button.dart';
import '../../../controllers/survey_controller.dart';
import '../../../models/survey_model.dart';
import '../../../responsive_setup/responsive_builder.dart';
import 'choice_row.dart';

class SurveyCard extends StatelessWidget {
  final double width;
  final SurveyModel survey;
  final double height;
  const SurveyCard({this.width, this.height, this.survey});

  @override
  Widget build(BuildContext context) {

    return ResponsiveBuilder(builder: (context, sizingInfo) {
      return Padding(
        padding:
            const EdgeInsets.only(left: 10, right: 10, bottom: 20, top: 20),
        child: Container(
            // height: widget.height,
            // width: widget.width,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(25),
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: CustomText(
                              text: survey.question,
                              weight: FontWeight.bold,
                              size: 17,
                            ),
                          ),
                          if (survey.imagesPath != null)
                            ImageButton(
                                height: 100,
                                width: 100,
                                borderRadius: 20,
                                imageUrl: survey.imagesPath,
                                onPressed: null,
                                boxFit: BoxFit.fill)
                        ],
                      ),
                      GetBuilder(
                          init: Get.find<SurveyController>(),
                          builder: (SurveyController surveyCon) {
                            return Column(
                              children: [
                                ChoiceRow(
                                  choice: survey.answer1,
                                  choiceChar: 'A',
                                  isSelected:
                                      survey.selectedChoice == '1',
                                  onSelected: () {
                                    survey.selectedChoice = '1';
                                    surveyCon.update();
                                  },
                                ),
                                ChoiceRow(
                                  choice: survey.answer2,
                                  choiceChar: 'B',
                                  isSelected:
                                      survey.selectedChoice == '2',
                                  onSelected: () {
                                    survey.selectedChoice = '2';
                                    surveyCon.update();
                                  },
                                ),
                                if (survey.answer3 != null &&
                                    survey.answer3 != '') ...{
                                  ChoiceRow(
                                    choice: survey.answer3,
                                    choiceChar: 'C',
                                    isSelected:
                                        survey.selectedChoice == '3',
                                    onSelected: () {
                                      survey.selectedChoice = '3';
                                      surveyCon.update();
                                    },
                                  ),
                                },
                                if (survey.answer4 != null &&
                                    survey.answer4 != '') ...{
                                  ChoiceRow(
                                    choice: survey.answer4,
                                    choiceChar: 'D',
                                    isSelected:
                                        survey.selectedChoice == '4',
                                    onSelected: () {
                                      survey.selectedChoice = '4';
                                      surveyCon.update();
                                    },
                                  ),
                                },
                                if (survey.answer5 != null &&
                                    survey.answer5 != '') ...{
                                  ChoiceRow(
                                    choice: survey.answer5,
                                    choiceChar: 'E',
                                    isSelected:
                                        survey.selectedChoice == '5',
                                    onSelected: () {
                                      survey.selectedChoice = '5';
                                      surveyCon.update();
                                    },
                                  ),
                                }
                              ],
                            );
                          }),

                      // Align(
                      //     alignment: Alignment.topCenter,
                      //     child: QuestionDetailsWithButton(widget.paragraph)),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomText(
                      text: 'answer_this_question_to_get'.tr +
                          '  ${survey.points}  ' +
                          'points'.tr,
                      color: Colors.grey,
                    ),
                  )
                ],
              ),
            )),
      );
    });
  }
}

class QuestionDetailsWithButton extends StatefulWidget {
  final String paragraph;

  QuestionDetailsWithButton(this.paragraph);

  @override
  _QuestionDetailsWithButtonState createState() =>
      _QuestionDetailsWithButtonState();
}

class _QuestionDetailsWithButtonState extends State<QuestionDetailsWithButton> {
  bool _tapped = false;
  bool _canShowText = false;
  bool _canAnimateText = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _tapped = !_tapped;
          if (_canShowText) {
            _canShowText = false;
            _canAnimateText = false;
          } else {
            Future.delayed(Duration(milliseconds: 400), () {
              setState(() {
                _canShowText = true;
              });
            });
            Future.delayed(Duration(milliseconds: 600), () {
              setState(() {
                _canAnimateText = true;
              });
            });
          }
        });
      },
      child: ResponsiveBuilder(builder: (context, sizingInfo) {
        return AnimatedContainer(
          duration: Duration(milliseconds: 300),
          height: _tapped ? sizingInfo.screenHeight / 1.5 : 45,
          width: sizingInfo.screenWidth - 30,
          decoration: BoxDecoration(
            color: _tapped ? Colors.white : Colors.indigo[400],
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25), topRight: Radius.circular(25)),
          ),
          child: Align(
              alignment: Alignment.topCenter,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: CustomText(
                      text: _tapped ? 'Hide paragraph' : 'Show paragraph',
                      size: 17,
                      color: _tapped ? Colors.indigo : Colors.white,
                    ),
                  ),
                  _tapped && _canShowText
                      ? AnimatedOpacity(
                          opacity: _canAnimateText ? 1 : .6,
                          duration: Duration(milliseconds: 700),
                          child: Padding(
                              padding: EdgeInsets.only(
                                  top: 25.0, left: 10, right: 10),
                              child: CustomText(
                                text: widget.paragraph,
                                size: 17,
                                color: _tapped ? Colors.black : Colors.white,
                                lineSpacing: 1.5,
                              )),
                        )
                      : SizedBox(),
                ],
              )),
        );
      }),
    );
  }
}
