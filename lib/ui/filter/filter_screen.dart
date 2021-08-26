import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../common_widgets/custom_text.dart';
import '../../controllers/filter_contoller.dart';
import '../../controllers/settings_controller.dart';
import '../../ui/filter/widgets/filter_entry_widget.dart';

class FilterScreen extends StatelessWidget {
  final SettingsController _settingsCon = Get.find<SettingsController>();
  final FilterController _filterController = Get.find<FilterController>();

  Future<bool> back() async {
    Get.back(result: false);
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: back,
      child: Scaffold(
        appBar: AppBar(
          title: CustomText(
            text: 'filter_by'.tr,
            size: 23,
            weight: FontWeight.bold,
          ),
          leading: IconButton(
            icon: Icon(Icons.close, size: 30),
            onPressed: () => Get.back(result: false),
          ),
          backgroundColor: _settingsCon.color1,
          centerTitle: true,
          elevation: 0,
          toolbarHeight: 70,
        ),
        body: GetBuilder(
            init: _filterController,
            builder: (FilterController con) {
              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemBuilder: (BuildContext context, int index) {
                        if (con.filterEntries[index].children.isNotEmpty) {
                          if ((con.filterEntries[index].nameEn == 'company' &&
                                  _settingsCon.filter1pageEnabled) ||
                              (con.filterEntries[index].nameEn == 'trademark' &&
                                  _settingsCon.filter2pageEnabled) ||
                              (con.filterEntries[index].nameEn == 'type' &&
                                  _settingsCon.filter3pageEnabled) ||
                              (con.filterEntries[index].nameEn == 'order')) {
                            return EntryItem(con.filterEntries[index]);
                          }
                          return SizedBox();
                        } else {
                          return SizedBox();
                        }
                      },
                      itemCount: con.filterEntries.length,
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: InkWell(
                          onTap: () {
                            Get.back(result: true);
                          },
                          child: Container(
                            height: 50,
                            color: _settingsCon.color1,
                            child: Center(
                              child: CustomText(
                                text: 'apply_filter'.tr,
                                size: 20,
                                weight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: InkWell(
                          onTap: () {
                            _filterController.resetFilter();
                            Get.back(result: true);
                          },
                          child: Container(
                            height: 50,
                            color: _settingsCon.color4,
                            child: Center(
                              child: CustomText(
                                text: 'reset_filter'.tr,
                                size: 20,
                                weight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              );
            }),
      ),
    );
  }
}
