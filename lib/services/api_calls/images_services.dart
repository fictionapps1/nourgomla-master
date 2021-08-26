import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart' as dio;
import '../../common_widgets/dialogs_and_snacks.dart';
import '../../controllers/user_controller.dart';
import '../../services/api_base/api.dart';
import '../../services/api_base/api_service.dart';
import 'package:get/get.dart';
import '../../config/api_links.dart';
class MediaService {
  MediaService._internal();

  static final MediaService _mediaService = MediaService._internal();

  static MediaService get instance => _mediaService;
  final APIService _apiService = APIService();

  final userController = Get.find<UserController>();

  Future<bool> uploadFile(
    File file,
    String fileName,
    int userId,
  ) async {
    try {
      dio.FormData formData = dio.FormData.fromMap({
        'file': await dio.MultipartFile.fromFile(file.path, filename: fileName),
        'userid': userId,
      });
      dio.Response response = await dio.Dio().post(
        Uri.encodeFull(ApiLinks.imageUploadLink),
        data: formData,
      );
      if (response.statusCode == 200) {
        print('Media uploaded successfully!');
        return true;
      } else {
        print(response.statusMessage);
        return false;
      }
    } catch (e) {
      showErrorDialog('Error Uploading Image=============> $e');
      return false;
    }
  }

  Future<Map<String, dynamic>> getUserImages(
      {int startIndex, int itemsPerPage}) async {
    Map<String, dynamic> imagesData = {};
    List<String> paths = [];
    try {
      Map<String, dynamic> data = await _apiService.postData(
        endpoint: Endpoints.imagesSelect,
        body: {
          'itemsPerPage': itemsPerPage,
          'startIndex': startIndex,
          'user_id': userController.currentUser.id,
        },
      );
      if (data != null) {
        List<dynamic> imagesDetails = data['data'];
        paths.addAll(imagesDetails.map((e) => e['path']));
        imagesData['images'] = paths;
        imagesData['total_count'] = data['totalCount'];
        print("images===============================>  $data");
      }

      return imagesData;
    } catch (e) {
      return imagesData;
    }
  }
}
