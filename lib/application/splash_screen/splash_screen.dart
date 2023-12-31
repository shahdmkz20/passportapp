import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:ayat_project/application/indexed_stack/indexed_stack_screen.dart';
import 'package:ayat_project/application/login/loginpage.dart';
import 'package:ayat_project/application/splash_screen/splash_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatelessWidget {
 const SplashScreen({super.key});
  @override
  Widget build(BuildContext context) {
     final SplashController splashController = Get.put(SplashController());
    return Obx((){
        return AnimatedSplashScreen(
          splashIconSize: double.infinity,
          splash: Lottie.asset(
            'assets/json/splash.json',
            animate: true,
            fit: BoxFit.scaleDown,
          ),
          duration: 3500,
          splashTransition: SplashTransition.fadeTransition,
          // pageTransitionType: PageTransitionType,
          nextScreen: splashController.roleUser.value == StateRole.userLogin
              ?  IndexedStackScreen()
              : LogInScreen(),
        );
      },
    );
  }
}
