import 'package:ayat_project/application/information/steper/secondpage.dart';
import 'package:ayat_project/application/information/steper_controller.dart';
import 'package:ayat_project/application/login/loginpage.dart';
import 'package:ayat_project/componants/app_bar.dart';
import 'package:ayat_project/componants/btn.dart';
import 'package:ayat_project/componants/form_validator.dart';
import 'package:ayat_project/componants/input_text_form.dart';
import 'package:ayat_project/utlis/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../storage/storage.dart';

class FirsStep extends StatelessWidget {
  SteperController steperController = Get.put(SteperController());
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  FirsStep({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: AppColors.defaultWhite,
      body: Obx(() {
        return Stack(
          children: [
            ListView(
              children: [
                const SizedBox(
                  height: 87,
                ),
                Form(
                  key: formKey,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 20),
                        child: Image.asset('assets/images/1.png'),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: Text('Personal Information ',
                            style: TextStyle(
                                color: AppColors.defaultBlue, fontSize: 25)),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 20),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 10,
                              child: InputTextForm(
                                formValidator: FormValidator(
                                    hint: 'first  name',
                                    regExp: RegExp(r'^.{3,}$'),
                                    errorMessage: '3 character or more'),
                                textInputType: TextInputType.text,
                                controller: steperController.firstNameCont,
                              ),
                            ),
                            const Expanded(
                                flex: 1,
                                child: SizedBox(
                                  width: 5,
                                )),
                            Expanded(
                              flex: 10,
                              child: InputTextForm(
                                formValidator: FormValidator(
                                    hint: 'الاسم الأول',
                                    regExp: RegExp(r'^.{3,}$'),
                                    errorMessage: '3 character or more'),
                                textInputType: TextInputType.text,
                                controller: steperController.firstNameACont,
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
                            Expanded(
                              flex: 10,
                              child: InputTextForm(
                                formValidator: FormValidator(
                                    hint: 'last  name',
                                    regExp: RegExp(r'^.{3,}$'),
                                    errorMessage: '3 character or more'),
                                textInputType: TextInputType.text,
                                controller: steperController.lastNameCont,
                              ),
                            ),
                            const Expanded(
                                flex: 1,
                                child: SizedBox(
                                  width: 5,
                                )),
                            Expanded(
                              flex: 10,
                              child: InputTextForm(
                                formValidator: FormValidator(
                                    hint: 'الكنية',
                                    regExp: RegExp(r'^.{3,}$'),
                                    errorMessage: '3 character or more'),
                                textInputType: TextInputType.text,
                                controller: steperController.lastNameACont,
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
                            Expanded(
                              flex: 10,
                              child: InputTextForm(
                                formValidator: FormValidator(
                                    hint: 'mother name',
                                    regExp: RegExp(r'^.{3,}$'),
                                    errorMessage: '3 character or more'),
                                textInputType: TextInputType.text,
                                controller: steperController.motherNameCont,
                              ),
                            ),
                            const Expanded(
                                flex: 1,
                                child: SizedBox(
                                  width: 5,
                                )),
                            Expanded(
                              flex: 10,
                              child: InputTextForm(
                                formValidator: FormValidator(
                                    hint: 'اسم الام ',
                                    regExp: RegExp(r'^.{3,}$'),
                                    errorMessage: '3 character or more'),
                                textInputType: TextInputType.text,
                                controller: steperController.motherNameACont,
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
                            Expanded(
                              flex: 10,
                              child: InputTextForm(
                                formValidator: FormValidator(
                                    hint: 'BirthCity',
                                    regExp: RegExp(r'^.{3,}$'),
                                    errorMessage: '3 character or more'),
                                textInputType: TextInputType.text,
                                controller: steperController.birthCityCont,
                              ),
                            ),
                            const Expanded(
                                flex: 1,
                                child: SizedBox(
                                  width: 5,
                                )),
                            Expanded(
                              flex: 10,
                              child: InputTextForm(
                                formValidator: FormValidator(
                                    hint: 'مكان الولادة ',
                                    regExp: RegExp(r'^.{3,}$'),
                                    errorMessage: '3 character or more'),
                                textInputType: TextInputType.text,
                                controller: steperController.birthCityACont,
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
                                  const Text(
                                    'Birthdate:',
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Color.fromARGB(255, 73, 73, 73)),
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
                                                      context, 1);
                                            },
                                            child: Text(
                                              steperController.date.value,
                                              style: const TextStyle(
                                                  color: AppColors.defaultWhite,
                                                  fontSize: 22),
                                            ))),
                                  )
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Container(
                                  padding: EdgeInsets.all(8),
                                  child: DropdownButton<String>(
                                    value: steperController.maleOrFemale.value,
                                    icon: const Icon(Icons.arrow_downward),
                                    // style:   TextStyle(color: Colors.darkBlue),
                                    onChanged: (newValue) {
                                      steperController.maleOrFemale.value =
                                          newValue!;
                                    },
                                    items: <String>['male', 'female']
                                        .map((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                  )),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: defaultButton(
                          text: 'Next',
                          function: () {
                            FocusScope.of(context).requestFocus(FocusNode());
                            if (!formKey.currentState!.validate()) {
                              return;
                            } else {
                              Get.to(SecondScreen());
                            }
                          },
                          bkColor: AppColors.defaultBlue,
                          txtColor: Colors.white,
                          width: 150,
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 30,
                )
              ],
            ),
            AppBarr(
                textAppBar: 'New passport',
                leading: true,
                iconData: Icons.logout,
                onPressButton: () {
                  Get.find<StorageServices>().setIsUserNotLogin();
                  Get.find<StorageServices>().logOut();
                  Get.offAll(LogInScreen());
                }),
          ],
        );
      }),
    ));
  }
}
