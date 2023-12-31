import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

class StorageServices {
  FlutterSecureStorage storage = const FlutterSecureStorage(
      aOptions: AndroidOptions(
        encryptedSharedPreferences: true,
      ));
  static const userLogin = 'userIsLogIn';
  static const userNotLogin = 'userNotLogIn';
  static const keyLoginType = 'typeLoginUser';
  static const noAccount = 'noAccount';
  static const idKey = 'idKey';
  static const idPassport = 'idPassport';
//splash screen login or first dtep
  void setIsUserLogin() {
    storage.write(key: keyLoginType, value: userLogin);
  }


  void setIsUserNotLogin() {
    storage.write(key: keyLoginType, value: userNotLogin);
  }
  Future<String?> getAccountType() async {
    if (GetUtils.isNull(storage.read(key: keyLoginType))) {
      return noAccount;
    } else {
      return await storage.read(key: keyLoginType);
    }
  }
//--------------------------------------



  Future<void>setUserId(String? id)async{
    if(id !=null) {
      await storage.write(key: idKey, value: id);
    }
}
  Future<void>setPassportId(String? id)async{
    if(id !=null) {
      await storage.write(key: idPassport, value: id);
    }
  }
  Future<String?> get getPassportId async{
    return await storage.read(key: idPassport);
  }
  Future<String?> get getUserId async{

   return await storage.read(key: idKey);

  }
  void logOut() {
    storage.delete(key: idKey);
    storage.delete(key: keyLoginType);  }



}
