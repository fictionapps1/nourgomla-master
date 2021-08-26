import 'package:get/get.dart';
import '../../controllers/location_controller.dart';
import '../../common_widgets/dialogs_and_snacks.dart';
import '../../controllers/user_controller.dart';
import '../../services/api_base/api.dart';
import '../../services/api_base/api_service.dart';

class HomeServices {
  HomeServices.internal();
  static final HomeServices _homeServices = HomeServices.internal();
  static HomeServices get instance => _homeServices;
  final APIService _apiService = APIService();
  final UserController _userController = Get.find<UserController>();
  final LocationController _locationCon = Get.find<LocationController>();

  Future<Map<String, dynamic>> getHomeData() async {
    try {
      final Map<String, dynamic> response = await _apiService.postData(
        endpoint: Endpoints.home,
        body: {
          'user_id': _userController.loggedIn ? _userController.userId : '',
          'user_role_id':
              _userController.loggedIn ? _userController.userRole : 1,
          'location': _locationCon.chosenArea != null
              ? _locationCon.chosenArea.keyArea
              : _locationCon.userLocation != null
                  ? _locationCon.userLocation.subAdminArea
                  : '',
        },
      );

      if (response != null) {
        return response;
      }
      return {};
    } catch (e) {
      print('Error Loading Home Data===============>  $e');
      showErrorDialog('Error Loading Home Data');
      return {};
    }
  }
}
