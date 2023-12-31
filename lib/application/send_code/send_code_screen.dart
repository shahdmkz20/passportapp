import 'package:ayat_project/application/indexed_stack/indexed_stack_screen.dart';
import 'package:ayat_project/application/login/login_controller.dart';
import 'package:ayat_project/application/send_code/send_code_controller.dart';
import 'package:ayat_project/componants/app_bar.dart';
import 'package:ayat_project/componants/details_widget.dart';
import 'package:ayat_project/utlis/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:lottie/lottie.dart';
import 'package:sms_autofill/sms_autofill.dart';
import '../../utlis/app_constant.dart';

class SendCodeScreen extends StatelessWidget {
  final String email;

  final SendCodeController sendCodeController = Get.put(SendCodeController());
  SendCodeScreen({Key? key, required this.email}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final LoginController loginController =
        Get.put(LoginController(context: context));
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.defaultWhite,
        body: Stack(
          children: [
            ListView(children: [
              const SizedBox(
                height: 100,
              ),
              Center(
                child: Lottie.asset(
                  'assets/json/enter_code.json',
                  animate: true,
                  height: 200,
                  fit: BoxFit.scaleDown,
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                child: Text(
                  'Pleas Wait To Send Code',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                child: Form(
                  key: loginController.formKey,
                  child: ContainerShadowAll(
                    widget: Column(children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 50, horizontal: 20),
                          child: Directionality(
                            textDirection: TextDirection.ltr,
                            child: Text(
                              email,
                              style: const TextStyle(fontSize: 20),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 25, horizontal: 20),
                        child: Form(
                          key: sendCodeController.formKey,
                          child: PinFieldAutoFill(
                            controller: sendCodeController.codeNumber,
                            codeLength: 4,
                            decoration: UnderlineDecoration(
                              textStyle: const TextStyle(
                                  fontSize: 20, color: Colors.black),
                              colorBuilder: FixedColorBuilder(
                                  Colors.black.withOpacity(0.3)),
                              lineStrokeCap: StrokeCap.round,
                              lineHeight: 2,
                            ),
                            onCodeChanged: (p0) async {
                              if (p0.toString().length == 4) {
                                AppConstants.loadingDialog();
                                await sendCodeController
                                    .sendCodeFromScreen(email);

                                if (sendCodeController.sendCodeState.value ==
                                    SendCodeState.failure) {
                                  FocusScope.of(context)
                                      .requestFocus(FocusNode());
                                  // ignore: use_build_context_synchronously
                                  AppConstants.showToast(context,
                                      sendCodeController.errorMessage.value);
                                }
                                if (sendCodeController.sendCodeState.value ==
                                    SendCodeState.success) {
                                  Get.offAll(IndexedStackScreen());
                                }
                              }
                            },
                          ),
                        ),
                      ),
                    ]),
                  ),
                ),
              ),
            ]),
            const AppBarr(
              textAppBar: 'Send Code',
            ),
          ],
        ),
      ),
    );
  }
}
