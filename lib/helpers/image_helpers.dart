import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import '../config/api_links.dart';

final ImagePicker _picker = ImagePicker();
Future<File> getImage(ImageSource source) async {
  final PickedFile pickedImage = await _picker.getImage(
      source: source, imageQuality: 85, maxWidth: 500, maxHeight: 500);
  final File imageFile = File(pickedImage.path);
  return imageFile;
}


Future<Uint8List> getMarkerImageFromNetwork(String imageUrl) async {
  Uint8List resizedMarkerImageBytes;
  try {
    resizedMarkerImageBytes = (await NetworkAssetBundle(
        Uri.parse(ApiLinks.imagesLink + '/' + imageUrl))
        .load(ApiLinks.imagesLink + '/' + imageUrl))
        .buffer
        .asUint8List();

    final markerImageCodec = await instantiateImageCodec(
      resizedMarkerImageBytes,
      targetWidth: 80,
      targetHeight: 80,
    );
    final FrameInfo frameInfo = await markerImageCodec.getNextFrame();
    final ByteData byteData = await frameInfo.image.toByteData(
      format: ImageByteFormat.png,
    );
    resizedMarkerImageBytes = byteData.buffer.asUint8List();
    return resizedMarkerImageBytes;
  } catch (e) {
    print('Error Getting Marker Image ==============================>$e');
    return resizedMarkerImageBytes;
  }
}