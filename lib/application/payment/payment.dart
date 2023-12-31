import 'package:ayat_project/application/indexed_stack/indexed_stack_screen.dart';
import 'package:ayat_project/application/payment/payment_controller.dart';
import 'package:ayat_project/componants/app_bar.dart';
import 'package:ayat_project/componants/btn.dart';
import 'package:ayat_project/componants/no_internet.dart';
import 'package:ayat_project/utlis/app_colors.dart';
import 'package:ayat_project/utlis/app_constant.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../componants/form_validator.dart';
import '../../componants/input_text_form.dart';
import '../indexed_stack/indexed_stack_controller.dart';

class InformationPayment extends StatelessWidget {
  final IndexedStackController indexedStackController =
      Get.put(IndexedStackController());
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  InformationPayment({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final PaymentController payController =
        Get.put(PaymentController(context: context));
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.defaultWhite,
        body: Obx(() {
          return payController.isInternet.isTrue
              ? Form(
                  key: formKey,
                  child: Stack(
                    children: [
                      ListView(
                        children: [
                          const SizedBox(
                            height: 87,
                          ),
                          Image.asset(
                            'assets/images/logo.png',
                            width: 20,
                            height: 152,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 20, horizontal: 20),
                            child: DropdownSearch<String>(
                              // ignore: invalid_use_of_protected_member
                              items: payController.bankName.value,
                              enabled: payController.bankNameState.value ==
                                  GetBankNameState.success,
                              onChanged: (value) {
                                payController.bankNameInDrop.value = value!;
                              },
                              validator: (value) {
                                if (payController
                                    .bankNameInDrop.value.isEmpty) {
                                  return 'Please chose Bank Name';
                                }
                                return null;
                              },
                              dropdownDecoratorProps: DropDownDecoratorProps(
                                dropdownSearchDecoration: InputDecoration(
                                  fillColor: AppColors.defaultWhite,
                                  filled: true,
                                  label: Text(
                                    'Bank Name',
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
                                vertical: 20, horizontal: 20),
                            child: InputTextForm(
                              formValidator: FormValidator(
                                  hint: 'Account Number',
                                  regExp: RegExp(r'^[0-9]{8}'),
                                  errorMessage:
                                      'Account Number should be 11 number'),
                              // prefixIcon: Icons.email,
                              textInputType: TextInputType.number,
                              controller: payController.accountNumber,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 20, horizontal: 20),
                            child: InputTextForm(
                              formValidator: FormValidator(
                                  hint: 'Cvv',
                                  regExp: RegExp(r'^[0-9]{3}'),
                                  errorMessage: 'Cvv should be 3 number'),
                              // prefixIcon: Icons.email,
                              textInputType: TextInputType.number,
                              controller: payController.cvv,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 20, horizontal: 70),
                            child: defaultButton(
                              text: 'pay',
                              function: () async {
                                if (!formKey.currentState!.validate()) {
                                  return;
                                }
                                AppConstants.loadingDialog();
                                await payController.addPey();
                                if (payController.peyState.value ==
                                    PeyState.success) {
                                  indexedStackController.currentIndex.value = 0;
                                  Get.offAll(IndexedStackScreen());
                                } else {
                                  FocusScope.of(context)
                                      .requestFocus(FocusNode());
                                  AppConstants.showToast(context,
                                      payController.errorMessage.value);
                                }
                              },
                              bkColor: AppColors.defaultBlue,
                              txtColor: AppColors.defaultWhite,
                            ),
                          ),
                        ],
                      ),
                      const AppBarr(textAppBar: 'Pay Details')
                    ],
                  ),
                )
              : NoInternetWidget(onRepeatLoad: () async {
                  payController.subscription = Connectivity()
                      .onConnectivityChanged
                      .listen(payController.showConnectivity);
                  final result = await Connectivity().checkConnectivity();
                  payController.isInternet.value =
                      payController.showConnectivity(result);
                  if (payController.isInternet.isTrue) {
                    await payController.getBankNameToScreen();
                    if (payController.bankNameState.value ==
                        GetBankNameState.failure) {
                      AppConstants.showToast(
                          context, payController.errorMessage.value);
                    }
                  }
                });
        }),
      ),
    );
  }
}
