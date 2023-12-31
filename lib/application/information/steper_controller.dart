import 'dart:async';
import 'dart:io';
import 'package:ayat_project/application/information/steper/fourthpage.dart';
import 'package:ayat_project/model/add_passport_model.dart';
import 'package:ayat_project/model/upload_image_model.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../data/add_passport_repository.dart';

class SteperController extends GetxController {

  final TextEditingController dateController = TextEditingController();
  final TextEditingController idCont = TextEditingController();
  final TextEditingController firstNameCont = TextEditingController();
  final TextEditingController firstNameACont = TextEditingController();
  final TextEditingController lastNameCont = TextEditingController();
  final TextEditingController lastNameACont = TextEditingController();
  final TextEditingController motherNameCont = TextEditingController();
  final TextEditingController motherNameACont = TextEditingController();
  final TextEditingController birthCityCont = TextEditingController();
  final TextEditingController birthCityACont = TextEditingController();
  RxString maleOrFemale = 'male'.obs;
  RxString date = DateFormat('yyyy-MM-dd')
      .format(DateTime.now())
      .obs;

  TextEditingController passNoCont = TextEditingController();
  TextEditingController passPlaceCont = TextEditingController();
  RxString issuingDate = DateFormat('yyyy-MM-dd')
      .format(DateTime.now())
      .obs;
  RxString finishDate = DateFormat('yyyy-MM-dd')
      .format(DateTime.now())
      .obs;

  final TextEditingController townCont = TextEditingController();
  final TextEditingController neighborhoodCont = TextEditingController();
  final TextEditingController phoneCont = TextEditingController();

RxString typePassport=''.obs;
RxString country=''.obs;

  RxBool isInternet = false.obs;
  late StreamSubscription subscription;

  final  addPassportState = AddPassportState.none.obs;
  RxString errorMessage=''.obs;
 Rx<DateTime>dateTime=DateTime.now().obs;
  Future<void> showDateTimeDialog(BuildContext context, int stepNumber) async {
    DateTime? userDateTime = await showDatePicker(

      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      helpText: 'Chose Date',
      // Can be used as title

      confirmText: 'next',

      fieldHintText: 'Month /Date /Year',
    );

    if (userDateTime != null) {
      DateTime selectedDateTime = DateTime(
        userDateTime.year,
        userDateTime.month,
        userDateTime.day,

      );

      switch (stepNumber) {
        case 1:
          date.value = DateFormat('yyyy-MM-dd').format(selectedDateTime);
          dateTime.value = selectedDateTime;
          break;
        case 2:
          issuingDate.value = DateFormat('yyyy-MM-dd').format(selectedDateTime);
          dateTime.value = selectedDateTime;
          break;
        case 3:
          finishDate.value = DateFormat('yyyy-MM-dd').format(selectedDateTime);
          dateTime.value = selectedDateTime;
      }
    }
  }
  //-----------------------pic
RxString path1=''.obs;
  RxString path2=''.obs;
  RxString path3=''.obs;
  Rx<File> personalImage=File('').obs;
  Rx<File> nationalIdFront=File('').obs;
  Rx<File> nationalIdBack=File('').obs;

  void getImage(int typeImage,int x) async {
    XFile? picked = await ImagePicker().pickImage(
      source:typeImage!=0? ImageSource.gallery:ImageSource.camera,
      preferredCameraDevice: CameraDevice.front,
    );
     // image = File(picked!.path);
switch (x){
  case 1:personalImage.value = File(picked!.path);path1.value=personalImage.value.toString(); break;
  case 2:nationalIdFront.value = File(picked!.path);path2.value=personalImage.value.toString();break;
  case 3:nationalIdBack.value = File(picked!.path);path3.value=personalImage.value.toString();break;
}
//pic finish
  }
  Future<void> showMyDialog(BuildContext context,int y) async {
    return showDialog<void>(
      context: context,
      // barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child:  DialogTimeAndDate(
            cameraFunction:(){
               getImage(1,y);
               Get.back();
            } ,
            galleryFunction:(){
               getImage(0,y);
               Get.back();
        },
          ),
        );
      },
    );
  }


  bool showConnectivity(ConnectivityResult result) {
    final hasInternet = result != ConnectivityResult.none;

    if (hasInternet) {
      return true;
    } else {
      return false;
    }
  }
RxInt numberRequest=0.obs;
  Future<void>addPassportInScreen()async{
    addPassportState.value = AddPassportState.waiting;
    AddPassportRepository addPassportRepository=AddPassportRepository();
    var res=await addPassportRepository.addPassport(

      AddPassportModel(
        requestType: numberRequest.value,
        requestDate: DateTime.now(),
        requestState: 0,
        notes: '',
        firstName: firstNameACont.text,
        lastName: lastNameACont.text,
        motherName: motherNameACont.text,
        englishFirstName: firstNameCont.text,
        englishLastName: lastNameCont.text,
        englishMotherName: motherNameCont.text,
        birthDate:dateTime.value ,
        birthPlace: birthCityACont.text,
        englishBirthPlace: birthCityCont.text,
        oldPassPortNumber: passNoCont.text.isNotEmpty? passNoCont.text:'',
        oldPassportPlaceissuance: passPlaceCont.text.isNotEmpty?passPlaceCont.text:'',
        oldPassportIssuingDate: dateTime.value,
        oldPassportFinishDate: dateTime.value,
        city: country.value,
        town: townCont.text,
        neighborhood: neighborhoodCont.text,
        phoneNumber: phoneCont.text,

    ),
      UploadImageModel(
        personalImage:personalImage.value ,
        personalIdImage1:nationalIdFront.value ,
        personalIdImage2: nationalIdBack.value,
      ),
    );
    if(!res.hasError){
      addPassportState.value = AddPassportState.success;
      dateController.clear();
      idCont.clear();
      firstNameCont.clear();
      firstNameACont.clear();
      lastNameCont.clear();
      lastNameACont.clear();
      motherNameCont.clear();
      motherNameACont.clear();
      birthCityCont.clear();
      birthCityACont.clear();
      passNoCont.clear();
      passPlaceCont.clear();
      townCont.clear();
      neighborhoodCont.clear();
      phoneCont.clear();
    }
    else{
      addPassportState.value = AddPassportState.failure;
      errorMessage.value=res.message;
      Get.back();
    }
  }
  @override
  void onInit() async{
    // TODO: implement onInit
    subscription = Connectivity()
        .onConnectivityChanged
        .listen(showConnectivity);
    final result =
        await Connectivity().checkConnectivity();
    isInternet.value =
       showConnectivity(result);
    super.onInit();
  }
}
enum AddPassportState {
  none,
  waiting,
  failure,
  success,
}
