import 'package:ayat_project/storage/storage.dart';
import 'package:ayat_project/utlis/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' as screen;
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'application/splash_screen/splash_screen.dart';

void main() {
  Get.put(StorageServices());
  WidgetsFlutterBinding.ensureInitialized();
  screen.SystemChrome.setPreferredOrientations([
    screen.DeviceOrientation.portraitUp,
  ]).then(
        (value) {

      runApp(const MyApp());
    },
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home:SplashScreen(),
    );
  }
}
