import 'package:ayat_project/application/indexed_stack/indexed_stack_screen.dart';
import 'package:ayat_project/application/information/steper/firstpage.dart';
import 'package:ayat_project/application/login/login_controller.dart';
import 'package:ayat_project/application/signup/signup.dart';
import 'package:ayat_project/componants/app_bar.dart';
import 'package:ayat_project/componants/btn.dart';
import 'package:ayat_project/componants/form_validator.dart';
import 'package:ayat_project/componants/input_text_form.dart';
import 'package:ayat_project/componants/no_internet.dart';
import 'package:ayat_project/storage/storage.dart';
import 'package:ayat_project/utlis/app_colors.dart';
import 'package:ayat_project/utlis/error_hundle.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';

import '../../utlis/app_constant.dart';

class LogInScreen extends StatelessWidget {
  LogInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final LoginController loginController =
        Get.put(LoginController(context: context));
    return SafeArea(
      child: Scaffold(
        body: Obx(() {
          return Stack(
            children: [
              loginController.isInternet.isTrue
                  ? ListView(children: [
                      const SizedBox(
                        height: 87,
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
                      Container(
                        padding: const EdgeInsets.all(20),
                        child: Form(
                          key: loginController.formKey,
                          child: Column(children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              child: InputTextForm(
                                formValidator: FormValidator(
                                    hint: 'Email',
                                    regExp: RegExp(
                                        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$'),
                                    errorMessage: 'Please Cheek your email'),
                                prefixIcon: Icons.email,
                                textInputType: TextInputType.emailAddress,
                                controller: loginController.emailCont,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              child: InputTextForm(
                                showText: loginController.isShowPass.value,
                                suffixIcon: loginController.isShowPass.isTrue
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                suffixPressed: () {
                                  loginController.showPassword();
                                },
                                formValidator: FormValidator(
                                    hint: 'password',
                                    regExp: RegExp(r'^.{3,}$'),
                                    errorMessage:
                                        'password should be 3 character or more'),
                                prefixIcon: Icons.lock,
                                textInputType: TextInputType.text,
                                controller: loginController.passwordCont,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              child: defaultButton(
                                text: 'Log In',
                                function: () async {
                                  loginController.subscription = Connectivity()
                                      .onConnectivityChanged
                                      .listen(loginController.showConnectivity);
                                  final result =
                                      await Connectivity().checkConnectivity();
                                  loginController.isInternet.value =
                                      loginController.showConnectivity(result);
                                  if (loginController.isInternet.isTrue) {
                                    AppConstants.loadingDialog();
                                    await loginController.onLogInPressed();
                                    if (loginController.registerState.value ==
                                        LogInState.success) {
                                      Get.offAll(IndexedStackScreen());
                                    } else {
                                      FocusScope.of(context)
                                          .requestFocus(FocusNode());
                                      AppConstants.showToast(context,
                                          loginController.errorMessage.value);
                                    }
                                  } else {
                                    // ignore: use_build_context_synchronously
                                    AppConstants.showToast(context,
                                        HandleError.noConnectedInternet);
                                  }

                                  loginController.onLogInPressed();
                                },
                                bkColor: AppColors.defaultBlue,
                                txtColor: Colors.white,
                                blurClr: Colors.blueGrey,
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  const Text(
                                    'Do not have Account ? ',
                                    style: TextStyle(fontSize: 14),
                                  ),
                                  TextButton(
                                      onPressed: () {
                                        Get.offAll(SignUpScreen());
                                      },
                                      child: const Text(
                                        'Create Account',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18),
                                      ))
                                ],
                              ),
                            ),
                          ]),
                        ),
                      ),
                    ])
                  : NoInternetWidget(onRepeatLoad: () async {
                      loginController.subscription = Connectivity()
                          .onConnectivityChanged
                          .listen(loginController.showConnectivity);
                      final result = await Connectivity().checkConnectivity();
                      loginController.isInternet.value =
                          loginController.showConnectivity(result);
                    }),
              const AppBarr(
                textAppBar: 'Log In',
              ),
            ],
          );
        }),
      ),
    );
  }
}


// import 'package:ayat_project/utlis/app_colors.dart';
// import 'package:flutter/material.dart';
// import '../../shared/componants/btn.dart';
// import '../newrequest/newrquest.dart';
//
// class LoginPage extends StatefulWidget {
//   const LoginPage({super.key});
//
//   @override
//   State<LoginPage> createState() => _LoginPageState();
// }
//
// class _LoginPageState extends State<LoginPage> {
//   TextEditingController emailCont = TextEditingController();
//   TextEditingController PaaswordCont = TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//
//       child: Scaffold(
//         body: Container(
//           padding:const EdgeInsets.all(20),
//           decoration:const BoxDecoration(
//             image: DecorationImage(
//                 image: AssetImage(
//                   'assets/images/loginBack.png',
//                 ),
//                 fit: BoxFit.cover),
//           ),
//           child: ListView(
//             children: [
//               Image.asset(
//                 'assets/images/logo.png',
//                 height: 150,
//               ),
//               SizedBox(
//                 height: 50,
//               ),
//               textContainer(
//                   child: textField(
//                       controller: emailCont,
//                       hint: 'Email',
//                       pre: Icon(Icons.email))),
//               SizedBox(
//                 height: 10,
//               ),
//               textContainer(
//                   child: textField(
//                       controller: PaaswordCont,
//                       hint: 'password',
//                       pre: Icon(Icons.lock))),
//               SizedBox(
//                 height: 10,
//               ),
//               defaultButton(
//                   text: 'login',
//                   function: () {
//                     Navigator.push(context,
//                         MaterialPageRoute(builder: (context) => newRequest()));
//                   },
//                   bkColor: Colors.white,
//                   txtColor:AppColors. defaultBlue,
//                   blurClr: Color.fromARGB(255, 82, 100, 110)),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceAround,
//                 children: [
//                   Text(
//                     'Forgot Password? ',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 20,
//                     ),
//                   ),
//                   TextButton(
//                       onPressed: () {},
//                       child: Text(
//                         'Press here!',
//                         style: TextStyle(
//                           color: Colors.red,
//                           decoration: TextDecoration.underline,
//                           fontSize: 15,
//                         ),
//                       ),
//                       )
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
