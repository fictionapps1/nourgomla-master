import 'dart:async';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../services/api_calls/images_services.dart';
import '../controllers/user_controller.dart';

class ImagesController extends GetxController {
  MediaService _mediaService = MediaService.instance;
  final userController = Get.find<UserController>();
  ScrollController scrollController = ScrollController();

  RxBool loading = false.obs;
  RxBool loadingMore = false.obs;

  File file;

  RxList<String> userImages = [].cast<String>().obs;
  int itemsPerPage = 10;
  int startIndex = 0;
  int totalCount = 0;
  @override
  void onInit() {
    getUserImages();
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        getMoreImages();
      }
    });
    super.onInit();
  }

  onClose() {
    scrollController.dispose();
    super.onClose();
  }

  getUserImages() async {
    startIndex=0;
    loading.value = true;
    final Map<String, dynamic> imagesData = await _mediaService.getUserImages(
        startIndex: startIndex, itemsPerPage: itemsPerPage);
    userImages.assignAll(imagesData['images']);
    totalCount = imagesData['total_count'];
    startIndex = startIndex + itemsPerPage;
    loading.value = false;
  }

  getMoreImages() async {
    if (startIndex < totalCount) {
      loadingMore.value = true;
      final Map<String, dynamic> imagesData = await _mediaService.getUserImages(
          startIndex: startIndex, itemsPerPage: itemsPerPage);
      userImages.addAll(imagesData['images']);
      loadingMore.value = false;
      startIndex = startIndex + itemsPerPage;
    }
  }

  Future pickImage(ImageSource imageSource) async {
    final pickedFile = await ImagePicker().getImage(source: imageSource);

    if (pickedFile != null) {
      file = File(pickedFile.path);
      String fileName = file.path.split('/').last;
      loading.value = true;
      print(
          'UPLOADING=============================================================================> ${loading.value}');
      bool uploaded = await _mediaService.uploadFile(
          file, fileName, userController.currentUser.id);
      if (uploaded) {
        getUserImages();
        loading.value = false;
        print(
            'UPLOADING=============================================================================> ${loading.value}');
      } else {
        loading.value = false;
      }

    } else {
      print('No image selected.');
    }
  }
}
