import 'dart:async';
import 'package:ayat_project/model/regester_model.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../data/register_repository.dart';

class SignUpController extends GetxController{
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final  TextEditingController emailCont = TextEditingController();
  final  TextEditingController passCont = TextEditingController();
  final TextEditingController idCont = TextEditingController();
  final TextEditingController confirmPassCont = TextEditingController();
  final  registerState = RegisterState.none.obs;


  RxString errorMessage=''.obs;

  RxBool isShowText=false.obs;
  void showText(){
    isShowText.value=!isShowText.value;
  }

  RxBool isInternet = false.obs;
  late StreamSubscription subscription;

  bool showConnectivity(ConnectivityResult result) {
    final hasInternet = result != ConnectivityResult.none;

    if (hasInternet) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> onSignUpPress(BuildContext context)async{

    registerState.value = RegisterState.waiting;
    RegisterRepository userRepository = RegisterRepository();
    var res=await userRepository.register(
        RegisterModel(
            nationalId: idCont.text,
            email:emailCont.text,
            password: passCont.text,
        )
    );
    if(!res.hasError){
      registerState.value = RegisterState.success;
      idCont.clear();
      passCont.clear();
      confirmPassCont.clear();
      // Get.find<StorageServices>().setIsUserLogin();
     // Get.back();
    }
    else{
      errorMessage.value=res.message;
      registerState.value = RegisterState.failure;
      Get.back();
    }
  }
  @override
  void onInit() async{
    subscription =
        Connectivity().onConnectivityChanged.listen(showConnectivity);
    final result = await Connectivity().checkConnectivity();
    isInternet.value = showConnectivity(result);
    // TODO: implement onInit
    super.onInit();
  }


}
enum RegisterState {
  none,
  waiting,
  failure,
  success,
}


