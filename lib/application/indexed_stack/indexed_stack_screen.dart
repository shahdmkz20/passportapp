import 'package:ayat_project/application/filtter/fillter_controller.dart';
import 'package:ayat_project/application/filtter/filtter_screen.dart';
import 'package:ayat_project/application/information/steper/firstpage.dart';
import 'package:ayat_project/utlis/app_colors.dart';
import 'package:ayat_project/utlis/app_constant.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:get/get.dart';

import 'indexed_stack_controller.dart';

// ignore: must_be_immutable
class IndexedStackScreen extends StatelessWidget {
  final IndexedStackController controller = Get.put(IndexedStackController());
  GlobalKey<CurvedNavigationBarState> bottomNavigationKey = GlobalKey();
  final FilterController filterController = Get.put(FilterController());

  IndexedStackScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.defaultWhite,
      body: Obx(
        () {
          return WillPopScope(
            onWillPop: () async {
              if (controller.currentIndex.value != 0) {
                controller.currentIndex.value = 0;
                return false;
              } else {
                return true;
              }
            },
            child: IndexedStack(
              index: controller.currentIndex.value,
              children: [
                FirsStep(),
                FilterScreen(),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: Obx(
        () {
          return CurvedNavigationBar(
            height: 40,
            backgroundColor: AppColors.defaultBlue,
            animationCurve: Curves.slowMiddle,
            animationDuration: const Duration(milliseconds: 100),
            key: bottomNavigationKey,
            index: controller.currentIndex.value,
            letIndexChange: (index) => true,
            onTap: (index) async {
              controller.changeIndex(index);
              if (controller.currentIndex.value == 1) {
                // AppConstants.loadingDialog();
                await filterController.getInf();
              }
            },
            items: const <Widget>[
              Column(
                children: [
                  Icon(PhosphorIcons.house, size: 35.0, color: Colors.black),
                  //Icon(Icons.home),
                  Text('Home'),
                ],
              ),
              Column(
                children: [
                  Icon(PhosphorIcons.funnel, size: 35.0, color: Colors.black
                      // const Color(0xffe9e2e2),
                      ),
                  Text('Request'),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
