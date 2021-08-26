import 'package:flutter/material.dart';
import '../../../common_widgets/cached_image.dart';
import '../../../common_widgets/custom_text.dart';
import '../../../controllers/filter_contoller.dart';
import '../../../controllers/language_controller.dart';
import '../../../controllers/settings_controller.dart';
import 'package:get/get.dart';
import '../../../models/category.dart';

class EntryItem extends StatelessWidget {
  final SettingsController _settingsCon = Get.find<SettingsController>();
  final LanguageController _langCon = Get.find<LanguageController>();
  final FilterController _filterCon = Get.find<FilterController>();
  EntryItem(this.root);

  final Category root;

  Widget _buildTiles(Category entry) {
    if (entry.children.isEmpty){
      print("ROOT ${entry.nameEn} STATUS======> ${entry.isSelected}");
      return ListTile(
        selectedTileColor: _settingsCon.color2.withOpacity(.3),
        selected: entry.isSelected,
        onTap: () {
          _filterCon.selectFilter(root, entry);
        },
        title: Row(
          children: [
            if (entry.imagesPath != null) ...{
              CachedImage(
                entry.imagesPath,
                height: 30,
                width: 30,
              ),
              const SizedBox(width: 10),
            },
            CustomText(
              text: _langCon.lang == 'en' ? entry.nameEn : entry.nameAr,
              textAlign: TextAlign.start,
            ),
          ],
        ),
        trailing: Icon(
          Icons.check_circle_outline,
          color: entry.isSelected ? Colors.blue : Colors.grey,
        ),
      );
    }

    return ExpansionTile(
      backgroundColor: _settingsCon.color2.withOpacity(.1),
      // key: PageStorageKey<String>(entry.nameEn+entry.nameAr),
      title: CustomText(
        text: _langCon.lang == 'en' ? entry.nameEn : entry.nameAr,
        size: 20,
        textAlign: TextAlign.start,
      ),
      children: entry.children.map(_buildTiles).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildTiles(root);
  }
}
