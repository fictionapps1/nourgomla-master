import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view_gallery.dart';
import '../config/api_links.dart';

class ImagesGallery extends StatelessWidget {
  final List<String> photosUrl;
  final int initialPage;

  const ImagesGallery({
    @required this.photosUrl,
    @required this.initialPage,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        child: PhotoViewGallery.builder(
          scrollPhysics: const AlwaysScrollableScrollPhysics(),
          pageController: PageController(initialPage: initialPage),
          //enableRotation: true,
          builder: (BuildContext context, int index) {
            return PhotoViewGalleryPageOptions(
              imageProvider: CachedNetworkImageProvider(
                '${ApiLinks.imagesLink}/${photosUrl[index]}',
              ),
              //initialScale: PhotoViewComputedScale.covered * 0.8,
              //heroAttributes: PhotoViewHeroAttributes(tag: _productId),
            );
          },
          itemCount: photosUrl.length,
        ),
      ),
    );
  }
}
