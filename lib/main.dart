import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'controllers/connection_controller.dart';
import 'my_app.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  await GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  ConnectionController con = Get.put(ConnectionController(), permanent: true);
  await con.checkConnection();
  // runApp(DevicePreview(builder: (context) => MyApp()));
  runApp(MyApp());
}
