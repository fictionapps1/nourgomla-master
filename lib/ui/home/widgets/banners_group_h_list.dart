import 'package:flutter/material.dart';
import '../../../helpers/routers.dart';
import '../../../common_widgets/image_button.dart';

class BannersGroupList extends StatelessWidget {
  const BannersGroupList({this.images, this.routsIds, this.typesData});
  final List images;
  final List routsIds;
  final List typesData;
  @override
  Widget build(BuildContext context) {

    return ListView(
      scrollDirection: Axis.horizontal,
      children: [
        ImageButton(
          borderRadius: 5,
          imageUrl: images[0],
          onPressed: () {
            homeRouter(index:0,routsIds: routsIds,typesData: typesData);
          },
          boxFit: BoxFit.fill,
          height: 250,
          width: 250,
        ),
        Container(
          child: GridView.builder(
            itemCount: images.length - 1,
            scrollDirection: Axis.horizontal,
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) => ImageButton(
                borderRadius: 5,
                imageUrl: images[index + 1],
                onPressed: () {
                  homeRouter(index:index+1,routsIds: routsIds,typesData: typesData);
                },
                boxFit: BoxFit.fill),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisSpacing: 1,
                crossAxisSpacing: 1,
                crossAxisCount: 2,
                childAspectRatio: 1),
          ),
        )
      ],
    );
  }
}
