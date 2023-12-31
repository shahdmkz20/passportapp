import 'dart:async';

import 'package:ayat_project/application/information/steper/firstpage.dart';
import 'package:ayat_project/data/login_repository.dart';
import 'package:ayat_project/model/login_model.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../storage/storage.dart';
class LoginController extends GetxController{
 final TextEditingController emailCont = TextEditingController();
 final TextEditingController passwordCont = TextEditingController();
 final GlobalKey<FormState> formKey = GlobalKey<FormState>();
final BuildContext context;
 LoginController({required this.context});
 RxBool isShowPass=false.obs;
 RxBool isInternet = false.obs;
 late StreamSubscription subscription;

 final  registerState = LogInState.none.obs;
 RxString errorMessage=''.obs;

 void showPassword(){
   isShowPass.value=!isShowPass.value;
 }
 bool showConnectivity(ConnectivityResult result) {
  final hasInternet = result != ConnectivityResult.none;

  if (hasInternet) {
   return true;
  } else {
   return false;
  }
 }
 Future<void> onLogInPressed ()async{
  if(!formKey.currentState!.validate()){
   FocusScope.of(context)
       .requestFocus(FocusNode());
   return;
  }
  registerState.value = LogInState.none;
  LogInRepository logInRepository=LogInRepository();
  var res=await logInRepository.logInPress(
      LogInModel(
          email:emailCont.text ,
          password: passwordCont.text,
      ),
  );
  if(!res.hasError){
   registerState.value = LogInState.success;
   emailCont.clear();
   passwordCont.clear();
   Get.find<StorageServices>().setIsUserLogin();
   Get.back();
  }
  else{
   registerState.value = LogInState.failure;
   errorMessage.value=res.message;
   Get.back();

  }

 }
 @override
  void onInit()async {
  subscription =
      Connectivity().onConnectivityChanged.listen(showConnectivity);
  final result = await Connectivity().checkConnectivity();
  isInternet.value = showConnectivity(result);
    // TODO: implement onInit
    super.onInit();
  }
}

enum LogInState {
 none,
 waiting,
 failure,
 success,
}

