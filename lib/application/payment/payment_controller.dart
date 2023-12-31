import 'dart:async';

import 'package:ayat_project/data/get_bank_name_repository.dart';
import 'package:ayat_project/data/pay_repository.dart';
import 'package:ayat_project/model/pay_model.dart';
import 'package:ayat_project/model/response/grt_bank_name_model.dart';
import 'package:ayat_project/storage/storage.dart';
import 'package:ayat_project/utlis/app_constant.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PaymentController extends GetxController{
  final BuildContext context;
  PaymentController({required this.context});
  TextEditingController accountNumber=TextEditingController();
  TextEditingController cvv=TextEditingController();
  final  peyState = PeyState.none.obs;
  RxList<String> bankName=<String>[].obs;
  RxString errorMessage=''.obs;
  RxString bankNameInDrop=''.obs;
  Rx<GetBankNameModel> bankNameModel=GetBankNameModel(data: [],message: '',succsess: false).obs ;
  final  bankNameState = GetBankNameState.none.obs;
  Future<void>getBankNameToScreen()async{
    bankNameState.value = GetBankNameState.waiting;
    GetBankNameRepository getBankNameRepository=GetBankNameRepository();
    var res=await getBankNameRepository.getBankName();
    if(!res.hasError){
      bankNameState.value = GetBankNameState.success;
      bankNameModel.value=res.data!;
      bankName.value=bankNameModel.value.data;
      // Get.back();
    }
    else{
      bankNameState.value = GetBankNameState.failure;
      errorMessage.value=res.message;
      // Get.back();
    }



  }
  Future<void>addPey()async{
    String? x= await StorageServices().getPassportId??'';
    int y=int.parse(x);
    peyState.value = PeyState.waiting;
    PeyRepository peyRepository=PeyRepository();
    var res=await peyRepository.addPey(PymentModel(
        bankName: bankNameInDrop.value,
        accountNumber: accountNumber.text,
        cvv:int.parse( cvv.text),
        epiryDate: DateTime.now(),
        passPortRequestId:y,
    ),
    );
    if(!res.hasError){
      peyState.value = PeyState.success;
      accountNumber.clear();
      cvv.clear();

    }
    else{
      peyState.value = PeyState.failure;
      errorMessage.value=res.message;
      Get.back();

    }
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
  @override
  Future onInit() async{
    subscription = Connectivity()
        .onConnectivityChanged
        .listen(showConnectivity);
    final result =
    await Connectivity().checkConnectivity();
   isInternet.value =
       showConnectivity(result);
    if(isInternet.isTrue){
      await getBankNameToScreen();
      if(bankNameState.value==GetBankNameState.failure){

        AppConstants.showToast(context, errorMessage.value);

      }
    }

    super.onInit();
  }

}

enum PeyState {
  none,
  waiting,
  failure,
  success,
}

enum GetBankNameState {
  none,
  waiting,
  failure,
  success,
}
