import 'dart:io';

import 'package:ayat_project/application/information/steper/final_step.dart';
import 'package:ayat_project/application/information/steper_controller.dart';
import 'package:ayat_project/application/payment/payment.dart';
import 'package:ayat_project/componants/btn.dart';
import 'package:ayat_project/utlis/app_colors.dart';
import 'package:ayat_project/utlis/app_constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ForthStep extends StatelessWidget {
  final SteperController steperController = Get.put(SteperController());

  ForthStep({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        body: SafeArea(
          child: ListView(children: [
            const SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: Container(
                margin: const EdgeInsets.only(bottom: 10),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                        color: Color.fromARGB(255, 212, 210, 210),
                        blurRadius: 5,
                      )
                    ],
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: AppColors.defaultBlue, width: 3)),
                child: steperController.path1.value.isEmpty
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 20),
                            child: Text(
                              'Enter Personal Image ',
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              clipBehavior: Clip.hardEdge,
                              decoration: BoxDecoration(
                                  color: AppColors.defaultBlue,
                                  shape: BoxShape.circle),
                              child: MaterialButton(
                                child: const Icon(
                                  Icons.add,
                                  color: Colors.white,
                                ),
                                onPressed: () {
                                  steperController.showMyDialog(context, 1);
                                },
                              ),
                            ),
                          )
                        ],
                      )
                    : Padding(
                        padding: const EdgeInsets.symmetric(vertical: 60),
                        child: Column(
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Image.file(steperController.personalImage.value),
                            TextButton(
                              onPressed: () {
                                steperController.showMyDialog(context, 1);
                              },
                              child: Text(
                                'repeat',
                                style: TextStyle(
                                    fontSize: 20, color: AppColors.defaultBlue),
                              ),
                            ),
                          ],
                        ),
                      ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(
                            color: Color.fromARGB(255, 212, 210, 210),
                            blurRadius: 5)
                      ],
                      borderRadius: BorderRadius.circular(15),
                      border:
                          Border.all(color: AppColors.defaultBlue, width: 3)),
                  child: steperController.path2.value.isEmpty
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 20),
                              child: Text(
                                'Enter NationalID Front side Image ',
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                clipBehavior: Clip.hardEdge,
                                decoration: BoxDecoration(
                                    color: AppColors.defaultBlue,
                                    shape: BoxShape.circle),
                                child: MaterialButton(
                                  child: const Icon(
                                    Icons.add,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {
                                    // _getImageFromGallery2();
                                    steperController.showMyDialog(context, 2);
                                  },
                                ),
                              ),
                            )
                          ],
                        )
                      : Padding(
                          padding: const EdgeInsets.symmetric(vertical: 60),
                          child: Column(
                            children: [
                              Image.file(
                                  steperController.nationalIdFront.value),
                              TextButton(
                                onPressed: () {
                                  steperController.showMyDialog(context, 2);
                                },
                                child: Text(
                                  'repeat',
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: AppColors.defaultBlue),
                                ),
                              ),
                            ],
                          ),
                        )),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: Container(
                margin: const EdgeInsets.only(bottom: 10),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                          color: Color.fromARGB(255, 212, 210, 210),
                          blurRadius: 5)
                    ],
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: AppColors.defaultBlue, width: 3)),
                child: steperController.path3.value.isEmpty
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            child: Text(
                              'Enter NationalID back side Image ',
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                          // const  SizedBox(
                          //   height: 20,
                          // ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              clipBehavior: Clip.hardEdge,
                              decoration: BoxDecoration(
                                  color: AppColors.defaultBlue,
                                  shape: BoxShape.circle),
                              child: MaterialButton(
                                child: const Icon(
                                  Icons.add,
                                  color: Colors.white,
                                ),
                                onPressed: () {
                                  // _getImageFromGallery3();
                                  steperController.showMyDialog(context, 3);
                                },
                              ),
                            ),
                          )
                        ],
                      )
                    : Padding(
                        padding: const EdgeInsets.symmetric(vertical: 60),
                        child: Column(
                          children: [
                            Image.file(
                              steperController.nationalIdBack.value,
                            ),
                            TextButton(
                              onPressed: () {
                                steperController.showMyDialog(context, 3);
                              },
                              child: Text(
                                'repeat',
                                style: TextStyle(
                                    fontSize: 20, color: AppColors.defaultBlue),
                              ),
                            ),
                            // IconButton(onPressed: (){}, icon: Icon(Icons.repartition))
                          ],
                        ),
                      ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 70),
              child: defaultButton(
                  text: 'next',
                  function: () {
                    if (steperController.path1.value.isEmpty ||
                        steperController.path2.value.isEmpty ||
                        steperController.path3.value.isEmpty) {
                      AppConstants.showToast(
                          context, 'please chose all picture');
                    } else {
                      Get.to(FinalStep());
                    }
                  },
                  bkColor: AppColors.defaultBlue,
                  txtColor: Colors.white),
            ),
            const SizedBox(
              height: 30,
            ),
          ]),
        ),
      );
    });
  }
}

class DialogTimeAndDate extends StatelessWidget {
  final Function cameraFunction;
  final Function galleryFunction;
  const DialogTimeAndDate(
      {super.key, required this.cameraFunction, required this.galleryFunction});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 2.5,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 40),
            child: Text(
              'Type Image',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
                color: AppColors.defaultBlue,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.defaultWhite,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: TextButton(
                  onPressed: () async {
                    await cameraFunction();
                  },
                  child: Text(
                    'gallery',
                    style:
                        TextStyle(fontSize: 18, color: AppColors.defaultBlue),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
            child: Container(
              decoration: BoxDecoration(
                  color: AppColors.defaultWhite,
                  borderRadius: BorderRadius.circular(20)),
              child: TextButton(
                onPressed: () async {
                  await galleryFunction();
                },
                child: Text(
                  'camera',
                  style: TextStyle(color: AppColors.defaultBlue, fontSize: 18),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
