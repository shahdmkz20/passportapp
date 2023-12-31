import 'package:ayat_project/application/indexed_stack/indexed_stack_screen.dart';
import 'package:ayat_project/application/information/steper/firstpage.dart';
import 'package:ayat_project/application/login/loginpage.dart';
import 'package:ayat_project/application/send_code/send_code_controller.dart';
import 'package:ayat_project/application/send_code/send_code_screen.dart';
import 'package:ayat_project/application/signup/sign_up_controller.dart';
import 'package:ayat_project/componants/app_bar.dart';
import 'package:ayat_project/componants/btn.dart';
import 'package:ayat_project/componants/form_validator.dart';
import 'package:ayat_project/componants/input_text_form.dart';
import 'package:ayat_project/componants/no_internet.dart';
import 'package:ayat_project/utlis/app_colors.dart';
import 'package:ayat_project/utlis/app_constant.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';

import '../../utlis/error_hundle.dart';

class SignUpScreen extends StatelessWidget {
  final SignUpController signUpController = Get.put(SignUpController());
  SignUpScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.defaultWhite,
        body: Obx(() {
          return Stack(
            children: [
              signUpController.isInternet.isTrue
                  ? ListView(children: [
                      const SizedBox(
                        height: 80,
                      ),
                      Container(
                        padding: const EdgeInsets.all(15),
                        margin: const EdgeInsets.symmetric(vertical: 15),
                        height: 200,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                                color: AppColors.defaultBlue, width: 10)),
                        child: Image.asset(
                          'assets/images/logo.png',
                        ),
                      ),
                      Form(
                        key: signUpController.formKey,
                        child: Column(children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 20, horizontal: 20),
                            child: InputTextForm(
                              formValidator: FormValidator(
                                  hint: 'Email',
                                  regExp: RegExp(
                                      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$'),
                                  errorMessage: 'Please Cheek your email'),
                              prefixIcon: Icons.email,
                              textInputType: TextInputType.emailAddress,
                              controller: signUpController.emailCont,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 20, horizontal: 20),
                            child: InputTextForm(
                              formValidator: FormValidator(
                                  hint: 'National ID',
                                  regExp: RegExp(r'^[0-9]{11}'),
                                  errorMessage:
                                      'National ID should be 11 number!!'),
                              prefixIcon: Icons.person,
                              textInputType: TextInputType.number,
                              controller: signUpController.idCont,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 20, horizontal: 20),
                            child: InputTextForm(
                              showText: signUpController.isShowText.value,
                              suffixIcon: signUpController.isShowText.isTrue
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              suffixPressed: () {
                                signUpController.showText();
                              },
                              formValidator: FormValidator(
                                  hint: 'password',
                                  regExp: RegExp(r'^.{3,}$'),
                                  errorMessage:
                                      'password should be 3 character or more'),
                              prefixIcon: Icons.lock,
                              textInputType: TextInputType.text,
                              controller: signUpController.passCont,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 20, horizontal: 20),
                            child: InputTextForm(
                              showText: signUpController.isShowText.value,
                              suffixIcon: signUpController.isShowText.isTrue
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              suffixPressed: () {
                                signUpController.showText();
                              },
                              formValidator: FormValidator(
                                  hint: 'Confirm password',
                                  regExp: RegExp(r'^.{3,}$'),
                                  errorMessage:
                                      'password should be 3 character or more'),
                              prefixIcon: Icons.lock,
                              textInputType: TextInputType.text,
                              controller: signUpController.confirmPassCont,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 20, horizontal: 20),
                            child: defaultButton(
                              text: 'SIGN UP',
                              function: () async {
                                signUpController.subscription = Connectivity()
                                    .onConnectivityChanged
                                    .listen(signUpController.showConnectivity);
                                final result =
                                    await Connectivity().checkConnectivity();
                                signUpController.isInternet.value =
                                    signUpController.showConnectivity(result);
                                if (signUpController.isInternet.isTrue) {
                                  if (signUpController.formKey.currentState!
                                          .validate() ==
                                      false) {
                                    return;
                                  }
                                  if (signUpController
                                          .passCont.text.isNotEmpty &&
                                      signUpController
                                          .confirmPassCont.text.isNotEmpty &&
                                      signUpController.passCont.text !=
                                          signUpController
                                              .confirmPassCont.text) {
                                    FocusScope.of(context)
                                        .requestFocus(FocusNode());
                                    AppConstants.showToast(context,
                                        'pass and confirmation pass is not the same');
                                    return;
                                  } else {
                                    AppConstants.loadingDialog();
                                    await signUpController
                                        .onSignUpPress(context);
                                    if (signUpController.registerState.value ==
                                        RegisterState.success) {
                                      Get.offAll(
                                        SendCodeScreen(
                                            email: signUpController
                                                .emailCont.text),
                                      );
                                      signUpController.emailCont.clear();
                                    } else {
                                      FocusScope.of(context)
                                          .requestFocus(FocusNode());
                                      AppConstants.showToast(context,
                                          signUpController.errorMessage.value);
                                    }
                                  }
                                } else {
                                  // ignore: use_build_context_synchronously
                                  AppConstants.showToast(
                                      context, HandleError.noConnectedInternet);
                                }

                                // signUpController.onSignUpPress(context);
                              },
                              bkColor: AppColors.defaultBlue,
                              txtColor: Colors.white,
                              blurClr: Colors.blueGrey,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  'Have Account ? ',
                                  style: TextStyle(fontSize: 18),
                                ),
                                TextButton(
                                    onPressed: () {
                                      Get.offAll(LogInScreen());
                                    },
                                    child: const Text(
                                      'Log In',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 22),
                                    ))
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          )
                        ]),
                      ),
                    ])
                  : NoInternetWidget(onRepeatLoad: () async {
                      signUpController.subscription = Connectivity()
                          .onConnectivityChanged
                          .listen(signUpController.showConnectivity);
                      final result = await Connectivity().checkConnectivity();
                      signUpController.isInternet.value =
                          signUpController.showConnectivity(result);
                    }),
              const AppBarr(
                textAppBar: 'Sing Up',
              ),
            ],
          );
        }),
      ),
    );
  }
}
