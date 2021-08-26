// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get/get_state_manager/src/simple/get_state.dart';
// import '../../component/common_button.dart';
// import '../../component/corners.dart';
// import '../../component/custom_text.dart';
// import '../../component/text_field_widget.dart';
// import '../../controllers/adresses_controller.dart';
// import '../../responsive_setup/responsive_builder.dart';
// import '../../ui/user_addresses/widgets/select_area_dialog.dart';
//
// import 'area_row.dart';
//
// class AddressBottomSheet extends StatelessWidget {
//   final controller = Get.find<AddressesController>();
//   @override
//   Widget build(BuildContext context) {
//     return ResponsiveBuilder(builder: (context, sizingInfo) {
//       return Container(
//         height: 500,
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.only(
//               topLeft: Radius.circular(20), topRight: Radius.circular(20)),
//         ),
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               const SizedBox(height: 30),
//               FlatButton(
//                 color: Colors.grey[300],
//                 onPressed: () {
//                   Get.dialog(SelectAreaDialog());
//                 },
//                 child: CustomText(
//                   text: 'Select Your Area',
//                   size: 15,
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(left: 20, right: 20),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.stretch,
//                   children: [
//                     const SizedBox(height: 20),
//                     GetBuilder<AddressesController>(
//                         builder: (con) => con.selectedArea != null
//                             ? Padding(
//                                 padding: const EdgeInsets.only(
//                                   bottom: 20.0,
//                                 ),
//                                 child: AreaRow(
//                                   cost: con.selectedArea.cost,
//                                   area: con.selectedArea.areaNameEn,
//                                 ),
//                               )
//                             : SizedBox()),
//                     Material(
//                       child: Container(
//                         height: 100,
//                         child: TextFieldWidget(
//                           initVal: controller.writtenAddress,
//                           maxLines: 5,
//                           inputType: TextInputType.multiline,
//                           hint: "Write Your Full Address",
//                           containerColor: "e6efd9",
//                           corners: Corners(10, 10, 10, 10),
//                           onChanged: (value) {
//                             controller.writtenAddress = value;
//                           },
//                         ),
//                       ),
//                     ),
//                     const SizedBox(height: 30),
//                   ],
//                 ),
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceAround,
//                 children: [
//                   if (controller.updateMode)
//                     CommonButton(
//                       width: 150,
//                       height: 40,
//                       corners: Corners(20, 20, 20, 20),
//                       text: 'Delete Address',
//                       onTap: () {
//                         controller.deleteAddress(
//                             addressId: controller.addressToUpdate.id);
//                         Get.back();
//                       },
//                       containerColor: 'FFEF9A9A',
//                     ),
//                   CommonButton(
//                     corners: Corners(20, 20, 20, 20),
//                     width: 150,
//                     height: 40,
//                     text: controller.updateMode
//                         ? 'Update Address'
//                         : 'Confirm Address',
//                     onTap: controller.updateMode
//                         ? () {
//                             if (controller.selectedArea != null &&
//                                 controller.writtenAddress != null) {
//                               controller.updateAddress(
//
//                                   writtenAddress: controller.writtenAddress,
//                                   addressId: controller.addressToUpdate.id);
//                               Get.back();
//                             } else {
//                               Get.defaultDialog(
//                                   title: 'Complete Address Data!',
//                                   content: CustomText(
//                                       text:
//                                           'Please Select Area And Enter Your Address'));
//                             }
//                           }
//                         : () {
//                             if (controller.selectedArea != null &&
//                                 controller.writtenAddress != null) {
//                               controller.addNewAddress(
//                                   address: controller.writtenAddress);
//                               Get.back();
//                             } else {
//                               Get.defaultDialog(
//                                   title: 'Complete Address Data!',
//                                   content: CustomText(
//                                       text:
//                                           'Please Select Area And Enter Your Address'));
//                             }
//                           },
//                     containerColor: 'FF81C784',
//                   ),
//                 ],
//               )
//             ],
//           ),
//         ),
//       );
//     });
//   }
// }
