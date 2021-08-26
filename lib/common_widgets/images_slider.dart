import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'cached_image.dart';

import 'images_gallery.dart';

class ImagesSlider extends StatelessWidget {
  final int autoPlayAnimation;
  final List<String> images;

  final bool showButtons;
  final bool autoPlay;

  ImagesSlider({
    this.autoPlayAnimation,
    this.images,
    this.showButtons = false,
    this.autoPlay = true,
  });

  @override
  Widget build(BuildContext context) {
    return Carousel(
      onImageTap: (index) {
        Get.to(
          () => ImagesGallery(
            initialPage: index,
            photosUrl: images,
          ),
        );
      },
      dotSize: 5,
      dotColor: Color(0xffFFE8D6),
      dotBgColor: Colors.transparent,
      dotIncreasedColor: Theme.of(context).accentColor,
      autoplay: autoPlay,
      autoplayDuration: Duration(seconds: 6),
      images: images.map((e) => CachedImage(e)).toList(),
    );
  }
}
