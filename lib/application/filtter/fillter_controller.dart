import 'package:ayat_project/data/get_passport_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../model/get_passport_information_model.dart';

class FilterController extends GetxController{
  final BuildContext? context;
  FilterController({  this.context});
  RxInt typeFilter=0.obs;
  final  getPassportState = GetInformationState.none.obs;
  Rx<GetPassportInformationModel> getPassportModel=GetPassportInformationModel(data: []).obs;
  RxString errorMessage=''.obs;
  Future<void>getInf()async{
    getPassportState.value = GetInformationState.waiting;
    GetPassportRepository getPassportRepository=GetPassportRepository();
    var res=await getPassportRepository.getInformation();
    if(!res.hasError){
      getPassportState.value = GetInformationState.success;
      getPassportModel.value=res.data!;

    }
    else{
      getPassportState.value = GetInformationState.failure;
      errorMessage.value=res.message;
      // AppConstants.showToast(context!, HandleError.tryAgain);
    }
  }
@override
  Future onInit()async {
    await getInf();
    // TODO: implement onInit
    super.onInit();
  }
}
enum GetInformationState {
  none,
  waiting,
  failure,
  success,
}