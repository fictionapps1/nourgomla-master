import 'package:get/get.dart';
import '../services/api_calls/home_services.dart';

class HomeController extends GetxController {
  HomeServices _homeServices = HomeServices.instance;
  Map<String,dynamic>homeData={};

  @override
  onInit() {
    getHomeData();
    super.onInit();
  }


  getHomeData()async{
    homeData.clear();
    homeData.assignAll(await _homeServices.getHomeData());
    update();
  }
}


