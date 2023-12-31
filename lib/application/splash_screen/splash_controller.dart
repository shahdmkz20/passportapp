import 'package:get/get.dart';

import '../../storage/storage.dart';


class SplashController extends GetxController {
  RxBool isFoundUser = false.obs;
  RxString? s = ''.obs;
  final roleUser = StateRole.non.obs;
  Future foundUser() async {
    s?.value = (await Get.find<StorageServices>().getAccountType())??'';
    // ignore: unrelated_type_equality_checks
     if (s!.value == StorageServices.userLogin) {
      roleUser.value = StateRole.userLogin;
    }

  }

  @override
  Future<void> onInit() async {
    super.onInit();
    await foundUser();
  }
}

enum StateRole { non, userLogin }
