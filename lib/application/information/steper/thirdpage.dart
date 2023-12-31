import 'package:ayat_project/application/information/steper/fourthpage.dart';
import 'package:ayat_project/application/information/steper_controller.dart';
import 'package:ayat_project/componants/btn.dart';
import 'package:ayat_project/componants/form_validator.dart';
import 'package:ayat_project/componants/input_text_form.dart';

import 'package:ayat_project/utlis/app_colors.dart';
import 'package:ayat_project/utlis/app_constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';

class ThirdStep extends StatelessWidget {
  ThirdStep({Key? key}) : super(key: key);
  final SteperController steperController = Get.put(SteperController());
  GlobalKey<FormState> formKey1 = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: formKey1,
        child: Container(
          height: double.infinity,
          decoration: const BoxDecoration(color: Colors.white),
          padding: const EdgeInsets.only(top: 80, left: 20, right: 20),
          child: ListView(
            children: [
              const SizedBox(
                height: 50,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                child: Image.asset('assets/images/3.png'),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 60),
                child: Text('Address Information',
                    style:
                        TextStyle(color: AppColors.defaultBlue, fontSize: 25)),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 20,
                ),
                child: InputTextForm(
                  formValidator: FormValidator(
                      hint: 'Town',
                      regExp: RegExp(r'^.{3,}$'),
                      errorMessage: '3 character or more'),
                  textInputType: TextInputType.text,
                  controller: steperController.townCont,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: InputTextForm(
                  formValidator: FormValidator(
                      hint: 'Neighborhood',
                      regExp: RegExp(r'^.{3,}$'),
                      errorMessage: '3 character or more'),
                  textInputType: TextInputType.text,
                  controller: steperController.neighborhoodCont,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Directionality(
                  textDirection: TextDirection.ltr,
                  child: TextFormField(
                    validator: (value) {
                      if (steperController.phoneCont.text.isEmpty) {
                        return 'pleaseEnterValue'.tr;
                      } else if (steperController.phoneCont.text
                          .startsWith('0')) {
                        return 'pleaseDoNotStartWithZero'.tr;
                      } else {
                        return null;
                      }
                    },
                    keyboardType: TextInputType.phone,
                    controller: steperController.phoneCont,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      hintText: 'phone number',
                      hintStyle: const TextStyle(color: Colors.grey),
                      filled: true,
                      fillColor: AppColors.defaultWhite,
                      prefix: const Text(
                        '+963 ',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                      prefixIcon: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Image.asset(
                          'assets/images/syria_logo.jpg',
                          width: 10,
                          height: 10,
                        ),
                      ),
                      isCollapsed: false,
                    ),
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 70),
                child: defaultButton(
                  text: 'Next',
                  function: () {
                    if (!formKey1.currentState!.validate()) {
                      return;
                    } else {
                      Get.to(ForthStep());
                    }
                  },
                  bkColor: AppColors.defaultBlue,
                  txtColor: Colors.white,
                  width: 150,
                ),
              ),
              const SizedBox(
                height: 30,
              )
            ],
          ),
        ),
      ),
    );
  }
}
