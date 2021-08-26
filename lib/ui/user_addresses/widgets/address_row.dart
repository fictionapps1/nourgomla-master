import '../../../controllers/cart_controller.dart';
import '../../../controllers/settings_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../common_widgets/dialogs_and_snacks.dart';
import '../../../controllers/adresses_controller.dart';
import '../../../models/address_model.dart';
import '../../../ui/user_addresses/map_screen.dart';
import 'info_row.dart';

class AddressRow extends StatelessWidget {
  final String cost;
  final String area;
  final String addressName;
  final AddressModel addressModel;
  final int index;
  final bool checkOutMood;

  AddressRow(
      {this.cost,
      this.area,
      this.addressName,
      this.addressModel,
      this.index,
      this.checkOutMood = false});
  final controller = Get.find<AddressesController>();
  final settingsCon = Get.find<SettingsController>();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          border: addressModel.selected && !checkOutMood
              ? Border.all(color: Colors.green, width: 2)
              : Border.all(width: 0),
          borderRadius: BorderRadius.circular(20),
          color: addressModel.selected && !checkOutMood
              ? Colors.green[50]
              : Colors.grey[200],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                        child:
                            InfoRow(title: 'address'.tr, details: addressName)),
                    const SizedBox(height: 10),
                    Flexible(child: InfoRow(title: 'area'.tr, details: area)),
                    if (!settingsCon.isMultiVendor) ...{
                      const SizedBox(height: 10),
                      Flexible(
                          child: InfoRow(
                              title: 'shipping_cost'.tr, details: cost)),
                    } else if (settingsCon.isMultiVendor &&
                        Get.find<CartController>().vendorShipping != null) ...{
                      const SizedBox(height: 10),
                      Flexible(
                          child: InfoRow(
                              title: 'shipping_cost'.tr,
                              details:
                                  Get.find<CartController>().vendorShipping)),
                    }
                  ],
                ),
              ),
              Column(
                children: [
                  if (!checkOutMood)
                    IconButton(
                        icon: Icon(Icons.edit, size: 25),
                        onPressed: () {
                          print(addressModel.id);
                          controller.switchToUpdateMode(address: addressModel);

                          // Get.bottomSheet(AddressBottomSheet());
                          Get.to(() => MapScreen());
                        }),
                  SizedBox(height: 20),
                  IconButton(
                      onPressed: () {
                        showTwoButtonsDialog(
                            title: 'are_you_sure'.tr,
                            msg: 'you_will_remove_this_address'.tr,
                            onOkTapped: () {
                              Get.back();
                              controller.deleteAddress(
                                  addressId: addressModel.id);
                            });
                      },
                      icon: Icon(Icons.delete_forever,
                          color: Colors.red[300], size: 35)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
