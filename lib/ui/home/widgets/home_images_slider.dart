import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import '../../../helpers/routers.dart';
import '../../../common_widgets/cached_image.dart';


class HomeImagesSlider extends StatelessWidget {
  final int autoPlayAnimation;

  final bool showButtons;
  final bool autoPlay;
  final List images;
  final List routsIds;
  final List typesData;

  HomeImagesSlider({
    this.autoPlayAnimation,
    this.showButtons = false,
    this.autoPlay = true,
    this.images,
    this.routsIds,
    this.typesData,
  });

  @override
  Widget build(BuildContext context) {


    return Carousel(
      onImageTap: (index) {
        homeRouter(index:index,typesData: typesData,routsIds: routsIds);
      },
      dotSize: 5,
      dotColor: Color(0xffFFE8D6),
      dotBgColor: Colors.transparent,
      dotIncreasedColor: Theme.of(context).accentColor,
      autoplay: autoPlay,
      autoplayDuration: Duration(seconds: 6),
      images: images
          .map((e) => CachedImage(
                e,
                fit: BoxFit.fill,
              ))
          .toList(),
    );
  }
}
