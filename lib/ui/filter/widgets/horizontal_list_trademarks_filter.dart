import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../common_widgets/custom_text.dart';
import '../../../common_widgets/image_button.dart';
import '../../../controllers/filter_contoller.dart';
import '../../../controllers/settings_controller.dart';
import '../../../models/category.dart';
import '../../../responsive_setup/responsive_builder.dart';

class HorizontalListTrademarksFilter extends StatelessWidget {
  final List<Category> categories;
  final String categoryImage;
  final String filterText;
  final FilterController _filterController = Get.find<FilterController>();
  final SettingsController _settingsCon = Get.find<SettingsController>();

  final Function applyFilter;

  HorizontalListTrademarksFilter(
      {this.categories, this.categoryImage, this.applyFilter, this.filterText});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: ResponsiveBuilder(builder: (context, sizingInfo) {
        final height = sizingInfo.screenHeight;
        return Container(
          height: height / 6,
          color: _settingsCon.color2.withOpacity(.2),
          child: Column(
            children: [
              Container(
                color: _settingsCon.color2.withOpacity(.4),
                height: 20,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 20.0),
                      child: CustomText(text: filterText),
                    ),
                    FlatButton(
                      onPressed: () {
                        if (_filterController.selectedTrademark != '') {
                          _filterController.resetTradeMarksFilter();

                          applyFilter();
                        }
                      },
                      child: CustomText(text: 'reset'.tr, color: Colors.blue),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 5),
              Expanded(
                child: GridView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  shrinkWrap: true,
                  padding: EdgeInsets.only(bottom: 0),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 1,
                    crossAxisCount: 1,
                    mainAxisSpacing: 0,
                  ),
                  itemBuilder: (context, index) {
                    Category category = categories[index];
                    return Container(
                        // color: Colors.red,
                        child: GetBuilder(
                            init: _filterController,
                            builder: (FilterController con) {
                              return Stack(
                                children: [
                                  Container(
                                    child: ImageButton(
                                      height: height / 7,
                                      width: height / 7,
                                      padding: 5,
                                      borderRadius: 20,
                                      imageUrl: category.imagesPath,
                                      onPressed: () {
                                        _filterController.selectedTrademark =
                                            category.id.toString();
                                        applyFilter();
                                        _filterController.selectFilter(_filterController.filterEntries[2], category);

                                      },
                                      boxFit: BoxFit.fill,
                                    ),
                                  ),

                                  if (category.isSelected) ...{
                                    Align(
                                      alignment: Alignment.center,
                                      child: CircleAvatar(
                                        child: Icon(
                                          Icons.check,
                                          color: Colors.white,
                                          size: 40,
                                        ),
                                        backgroundColor: Colors.black38,
                                        radius: 25,
                                      ),
                                    ),
                                  }
                                ],
                              );
                            }));
                  },
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
