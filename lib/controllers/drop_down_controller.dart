import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/drop_down_list_data.dart';

class DropDownController extends GetxController {

  List<DropdownMenuItem<ListItem>> dropdownMenuItems;
  ListItem selectedItem;


  List<ListItem> dropDownItems = [
    ListItem('new', Text("new".tr)),
    ListItem('old', Text("old".tr)),
    ListItem('a-z', Text("a-z".tr)),
    ListItem('z-a', Text("z-a".tr)),
    ListItem('lowestprice', Text("lowest_price".tr)),
    ListItem('highestprice', Text("highest_price".tr)),
  ];



  @override
  void onInit() {

    dropdownMenuItems = buildDropDownMenuItems(dropDownItems);
    selectedItem = dropDownItems[0];
    super.onInit();
  }

  List<DropdownMenuItem<ListItem>> buildDropDownMenuItems(List listItems) {
    List<DropdownMenuItem<ListItem>> items = List();
    for (ListItem listItem in listItems) {
      items.add(
        DropdownMenuItem(
          child: listItem.child,
          value: listItem,
        ),
      );
    }
    return items;
  }
}
