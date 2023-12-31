import 'package:ayat_project/utlis/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';


class AppConstants {
  static FToast fToast = FToast();

  static void showToast(BuildContext context, String text) {
    fToast.init(context);
    Widget toast = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.defaultBlue,
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color(0x00000000).withOpacity(0.5),
              const Color.fromARGB(0, 8, 8, 8).withOpacity(0.8),
            ],
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 7,horizontal: 10),
            child: Text(
              text,
              style: const  TextStyle(color: Colors.white, fontSize: 21),
            ),
          ),
        ),
      ),
    );

    fToast.showToast(
        child: toast,
        positionedToastBuilder: (context, child) {
          return Positioned(
            bottom: 100.0,
            left: 0,
            right: 0,
            child: child,
          );
        });
  }

  static void loadingDialog() {
    Get.defaultDialog(
      onWillPop: () async {
        return false;
      },
      barrierDismissible: false,
      title: 'Waiting',
      content: const CircularProgressIndicator(),
    );
  }
}
