import 'package:ayat_project/model/send_code_model.dart';
import 'package:ayat_project/storage/storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../data/send_code_repository.dart';

class SendCodeController extends GetxController{
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController codeNumber = TextEditingController();
  final  sendCodeState = SendCodeState.none.obs;
  RxString errorMessage=''.obs;
  Future<void>sendCodeFromScreen(String email)async{
    if(!formKey.currentState!.validate()){
      return;
    }
    sendCodeState.value = SendCodeState.waiting;
    SendCodeRepository sendCodeRepository=SendCodeRepository();
    var res=await sendCodeRepository.sendCode(SendCodeModel(email: email, code: codeNumber.text));
    if(!res.hasError){
      sendCodeState.value = SendCodeState.success;
      codeNumber.clear();
      Get.find<StorageServices>().setIsUserLogin();

    }
    else{
      sendCodeState.value = SendCodeState.failure;
      errorMessage.value=res.message;
      Get.back();
    }
  }
}
enum SendCodeState {
  none,
  waiting,
  failure,
  success,
}

