import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../config/api_links.dart';


class CachedImage extends StatelessWidget {
  final String imageUrl;
  final double radius;
  final double height;
  final double width;
  final BoxFit fit;
  final bool notFromOurApi;

  const CachedImage(
    this.imageUrl, {
    this.radius = 0,
    this.height,
    this.width,
    this.fit = BoxFit.cover,
    this.notFromOurApi = false,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: BorderRadius.circular(radius), child: buildImage());
  }


  Widget buildImage() {
    return CachedNetworkImage(
      height: height,
      width: width,
      imageUrl: notFromOurApi ? imageUrl : '${ApiLinks.imagesLink}/$imageUrl',
      fit: fit,
      placeholder: (context, url) => Center(child: SizedBox()),
      errorWidget: (context, url, error) => Icon(Icons.error),
    );
  }
}
