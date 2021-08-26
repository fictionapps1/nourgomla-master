import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/categories_controller.dart';

class SectionHeader extends GetView<CategoriesController> {
  final List<String> titles = ['Companies', 'Products'];

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: List.generate(2, (index) {
          return Obx(() {
            bool isSelected = controller.categoryType.value == index + 1;
            return Expanded(
              child: Container(
                color: isSelected ? Colors.blueGrey : Colors.grey[300],
                child: TextButton(
                  onPressed: () => controller.categoryType.value = index + 1,
                  child: Text(titles[index]),
                  style: TextButton.styleFrom(
                    primary: isSelected ? Colors.white : Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
              ),
            );
          });
        }),
      ),
    );
  }
}
