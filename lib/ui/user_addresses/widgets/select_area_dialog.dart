// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../../component/corners.dart';
// import '../../component/text_field_widget.dart';
// import '../../controllers/adresses_controller.dart';
// import 'area_row.dart';
//
// class SelectAreaDialog extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Container(
//         height: 300,
//         width: 300,
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(10),
//           color: Colors.white,
//         ),
//         child: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: GetBuilder<AddressesController>(
//               init: Get.find(),
//               builder: (con) {
//                 return Column(
//                   crossAxisAlignment: CrossAxisAlignment.stretch,
//                   children: [
//                     Material(
//                       child: TextFieldWidget(
//                         icon: Icons.search,
//                         hint: "Search For Area",
//                         containerColor: "e6efd9",
//                         corners: Corners(10, 10, 10, 10),
//                         onChanged: (value) {
//                           // con.queryName.value = value;
//                         },
//                       ),
//                     ),
//                     const SizedBox(height: 10),
//                     Expanded(
//                       child: ListView.builder(
//                           shrinkWrap: true,
//                           itemCount: con.filteredShippingData.isNotEmpty
//                               ? con.filteredShippingData.length
//                               : con.shippingData.length,
//                           itemBuilder: (context, index) {
//                             return Padding(
//                                 padding:
//                                     const EdgeInsets.symmetric(vertical: 4.0),
//                                 child: AreaRow(
//                                   onTap: () {
//                                     con.selectArea(
//                                       con.filteredShippingData.isNotEmpty
//                                           ? con.filteredShippingData[index]
//                                           : con.shippingData[index],
//                                     );
//                                     Get.back();
//                                   },
//                                   area: con.filteredShippingData.isNotEmpty
//                                       ? con.filteredShippingData[index]
//                                           .areaNameEn
//                                       : con.shippingData[index].areaNameEn,
//                                   cost: con.filteredShippingData.isNotEmpty
//                                       ? con.filteredShippingData[index].cost
//                                       : con.shippingData[index].cost,
//                                 ));
//                           }),
//                     ),
//                   ],
//                 );
//               }),
//         ),
//       ),
//     );
//   }
// }
