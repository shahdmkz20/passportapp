import 'package:ayat_project/application/information/steper/thirdpage.dart';
import 'package:ayat_project/application/information/steper_controller.dart';
import 'package:ayat_project/componants/btn.dart';
import 'package:ayat_project/componants/form_validator.dart';
import 'package:ayat_project/componants/input_text_form.dart';
import 'package:ayat_project/utlis/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SecondScreen extends StatelessWidget {
  SecondScreen({Key? key}) : super(key: key);
  SteperController steperController = Get.put(SteperController());
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        body: Container(
          height: double.infinity,
          decoration: const BoxDecoration(color: Colors.white),
          padding: const EdgeInsets.only(top: 80, left: 20, right: 20),
          child: ListView(
            children: [
              Form(
                key: formKey,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 20),
                        child: Image.asset('assets/images/2.png'),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 20),
                        child: Text('Passport Information',
                            style: TextStyle(
                                color: AppColors.defaultBlue, fontSize: 25)),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 20),
                        child: Row(
                          children: [
                            Expanded(
                              child: InputTextForm(
                                formValidator: FormValidator(
                                    hint: 'Passport number',
                                    regExp: RegExp(r'^.{3,}$'),
                                    errorMessage: '3 character or more'),
                                textInputType: TextInputType.number,
                                controller: steperController.passNoCont,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 20),
                        child: Row(
                          children: [
                            Flexible(
                              child: InputTextForm(
                                formValidator: FormValidator(
                                    hint: 'Place of Passport Issuance',
                                    regExp: RegExp(r'^.{3,}$'),
                                    errorMessage: '3 character or more'),
                                textInputType: TextInputType.text,
                                controller: steperController.passPlaceCont,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      const Text(
                                        'Issuing date:',
                                        style: TextStyle(
                                            fontSize: 20,
                                            color: Color.fromARGB(
                                                255, 73, 73, 73)),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10),
                                        child: Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                color: AppColors.defaultBlue),
                                            child: TextButton(
                                                onPressed: () async {
                                                  await steperController
                                                      .showDateTimeDialog(
                                                          context, 2);
                                                },
                                                child: Text(
                                                  steperController
                                                      .issuingDate.value,
                                                  style: const TextStyle(
                                                      color: AppColors
                                                          .defaultWhite,
                                                      fontSize: 22),
                                                ))),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Text(
                                  'Finish date:',
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Color.fromARGB(255, 73, 73, 73)),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          color: AppColors.defaultBlue),
                                      child: TextButton(
                                          onPressed: () async {
                                            await steperController
                                                .showDateTimeDialog(context, 3);
                                          },
                                          child: Text(
                                            steperController.finishDate.value,
                                            style: const TextStyle(
                                                color: AppColors.defaultWhite,
                                                fontSize: 22),
                                          ))),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: defaultButton(
                          text: 'Next',
                          function: () {
                            if (steperController
                                .passPlaceCont.text.isNotEmpty) {
                              FocusScope.of(context).requestFocus(FocusNode());
                            }

                            Get.to(ThirdStep());
                          },
                          bkColor: AppColors.defaultBlue,
                          txtColor: Colors.white,
                          width: 150,
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                    ]),
              ),
            ],
          ),
        ),
      );
    });
  }
}
