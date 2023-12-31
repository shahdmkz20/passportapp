import 'package:ayat_project/application/filtter/fillter_controller.dart';
import 'package:ayat_project/application/information/steper/firstpage.dart';
import 'package:ayat_project/application/information/steper_controller.dart';
import 'package:ayat_project/componants/app_bar.dart';
import 'package:ayat_project/componants/btn.dart';
import 'package:ayat_project/utlis/app_colors.dart';
import 'package:ayat_project/utlis/app_constant.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';

import '../../../componants/no_internet.dart';
import '../../../utlis/error_hundle.dart';
import '../../indexed_stack/indexed_stack_controller.dart';
import '../../indexed_stack/indexed_stack_screen.dart';

class FinalStep extends StatelessWidget {
  final SteperController steperController = Get.put(SteperController());
  final IndexedStackController indexedStackController =
      Get.put(IndexedStackController());
  final FilterController filterController = Get.put(FilterController());
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  FinalStep({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Obx(() {
          return Form(
            key: formKey,
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 200),
                  child: steperController.isInternet.isTrue
                      ? ListView(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 30, horizontal: 50),
                              child: DropdownSearch<String>(
                                // ignore: invalid_use_of_protected_member
                                items: const [
                                  'Urgent  1,000,000 SP',
                                  'Normal   600,000 SP'
                                ],

                                onChanged: (value) {
                                  steperController.typePassport.value = value!;
                                  if (value == 'Urgent  1,000,000 SP') {
                                    steperController.numberRequest.value = 0;
                                  } else {
                                    steperController.numberRequest.value = 1;
                                  }
                                },
                                validator: (value) {
                                  if (steperController
                                      .typePassport.value.isEmpty) {
                                    return 'please chose type passport';
                                  }
                                  return null;
                                },

                                dropdownDecoratorProps: DropDownDecoratorProps(
                                  dropdownSearchDecoration: InputDecoration(
                                    fillColor: AppColors.defaultWhite,
                                    filled: true,
                                    label: Text(
                                      'passport',
                                      style: TextStyle(
                                        color: AppColors.defaultBlue,
                                      ),
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                ),

                                popupProps: PopupProps.dialog(
                                  dialogProps: const DialogProps(
                                      contentPadding:
                                          EdgeInsets.symmetric(vertical: 50)),
                                  searchFieldProps: TextFieldProps(
                                    decoration: InputDecoration(
                                      labelText: 'search',
                                      labelStyle: TextStyle(
                                        color: AppColors.defaultBlue,
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                    ),
                                  ),
                                  fit: FlexFit.loose,
                                  showSearchBox: true,
                                  isFilterOnline: true,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 30, horizontal: 50),
                              child: DropdownSearch<String>(
                                // ignore: invalid_use_of_protected_member
                                items: [
                                  'Damascus',
                                  'Aleppo',
                                  'Homs',
                                  'Hama',
                                  'Lattkia',
                                  'Tartus'
                                ],
                                validator: (value) {
                                  if (steperController.country.value.isEmpty) {
                                    return 'please chose country';
                                  }
                                  return null;
                                },
                                onChanged: (value) {
                                  steperController.country.value = value!;
                                },
                                dropdownDecoratorProps: DropDownDecoratorProps(
                                  dropdownSearchDecoration: InputDecoration(
                                    fillColor: AppColors.defaultWhite,
                                    filled: true,
                                    label: Text(
                                      'country',
                                      style: TextStyle(
                                        color: AppColors.defaultBlue,
                                      ),
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                ),

                                popupProps: PopupProps.dialog(
                                  dialogProps: const DialogProps(
                                      contentPadding:
                                          EdgeInsets.symmetric(vertical: 50)),
                                  searchFieldProps: TextFieldProps(
                                    decoration: InputDecoration(
                                      labelText: 'search',
                                      labelStyle: TextStyle(
                                        color: AppColors.defaultBlue,
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                    ),
                                  ),
                                  fit: FlexFit.loose,
                                  showSearchBox: true,
                                  isFilterOnline: true,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 20, horizontal: 70),
                              child: defaultButton(
                                text: 'Finish',
                                function: () async {
                                  if (!formKey.currentState!.validate()) {
                                    return;
                                  } else {
                                    steperController.subscription =
                                        Connectivity()
                                            .onConnectivityChanged
                                            .listen(steperController
                                                .showConnectivity);
                                    final result = await Connectivity()
                                        .checkConnectivity();
                                    steperController.isInternet.value =
                                        steperController
                                            .showConnectivity(result);
                                    if (steperController.isInternet.isTrue) {
                                      AppConstants.loadingDialog();
                                      FocusScope.of(context)
                                          .requestFocus(FocusNode());
                                      await steperController
                                          .addPassportInScreen();

                                      if (steperController
                                              .addPassportState.value ==
                                          AddPassportState.success) {
                                        indexedStackController
                                            .currentIndex.value = 1;
                                        await filterController.getInf();
                                        Get.offAll(IndexedStackScreen());
                                      } else {
                                        AppConstants.showToast(
                                            context,
                                            steperController
                                                .errorMessage.value);
                                      }
                                    } else {
                                      // ignore: use_build_context_synchronously
                                      AppConstants.showToast(context,
                                          HandleError.noConnectedInternet);
                                    }
                                  }
                                },
                                bkColor: AppColors.defaultBlue,
                                txtColor: Colors.white,
                                width: 150,
                              ),
                            )
                          ],
                        )
                      : NoInternetWidget(onRepeatLoad: () async {
                          steperController.subscription = Connectivity()
                              .onConnectivityChanged
                              .listen(steperController.showConnectivity);
                          final result =
                              await Connectivity().checkConnectivity();
                          steperController.isInternet.value =
                              steperController.showConnectivity(result);
                        }),
                ),
                const AppBarr(textAppBar: 'Passport Type')
              ],
            ),
          );
        }),
      ),
    );
  }
}
