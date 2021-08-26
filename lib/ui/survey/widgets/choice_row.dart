import 'package:flutter/material.dart';
import '../../../common_widgets/custom_text.dart';
import 'package:get/get.dart';
import '../../../controllers/settings_controller.dart';

class ChoiceRow extends StatelessWidget {
  final bool isSelected;
  final String choiceChar;
  final String choice;
  final Function onSelected;

  const ChoiceRow({
    @required this.isSelected,
    @required this.choiceChar,
    @required this.choice,
    @required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    final SettingsController _settingsCon = Get.find<SettingsController>();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: GestureDetector(
        onTap: onSelected,
        child: Row(
          children: [
            Container(
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                  border: Border.all(
                      color: isSelected ? Colors.white : _settingsCon.color1),
                  color: isSelected ? _settingsCon.color1 : Colors.white,
                  shape: BoxShape.circle),
              child: isSelected
                  ? Center(
                    child: Container(
                        height: 20,
                        width: 20,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.white, width: 3),
                            shape: BoxShape.circle),

                        // Center(
                        //   child: CustomText(
                        //       text: choiceChar,
                        //       color: isSelected ? Colors.white :_settingsCon.color1),
                        // ),
                      ),
                  )
                  : SizedBox(),
              // Center(
              //   child: CustomText(
              //       text: choiceChar,
              //       color: isSelected ? Colors.white :_settingsCon.color1),
              // ),
            ),
            SizedBox(width: 30),
            CustomText(
              text: choice,
              color: isSelected ? _settingsCon.color1 : null,
            ),
          ],
        ),
      ),
    );
  }
}
