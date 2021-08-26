import 'package:flutter/material.dart';
import '../../../helpers/routers.dart';
import '../../../common_widgets/image_button.dart';

class HorizontalListOneLine extends StatelessWidget {
  final List images;
  final List routsIds;
  final List typesData;
  const HorizontalListOneLine({this.images, this.routsIds, this.typesData});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: images.length,
      itemBuilder: (context, index) => ImageButton(
        borderRadius: 5,
        imageUrl: images[index],
        onPressed: () {
          homeRouter(index: index, routsIds: routsIds, typesData: typesData);
        },
        boxFit: BoxFit.fill,

        width: 240,
      ),
    );
  }
}
