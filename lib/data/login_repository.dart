import 'dart:developer';
import 'package:ayat_project/model/login_model.dart';
import 'package:ayat_project/storage/storage.dart';
import 'package:ayat_project/utlis/error_hundle.dart';
import 'package:dio/dio.dart';
import '../model/response/response_register_model.dart';
import '../model/response/send_code_response_model.dart';
import '../model/response_model.dart';

class LogInRepository{
  Dio dio=Dio(
    BaseOptions(
      baseUrl: 'http://rahmawayat-001-site1.itempurl.com/api/Auth/login',
       connectTimeout:const Duration( seconds: 60), // 60 seconds
      receiveTimeout:const Duration( seconds: 60), // 60 seconds
    ),
  );

  Future<ResponseModel<SendCodeResponseModel>>logInPress(LogInModel logInModel)async{
    try{
      var response=await dio.post(
          'http://rahmawayat-001-site1.itempurl.com/api/Auth/login',
          data:logInModel.toJson() );
      if(response.statusCode==200){
        var res = SendCodeResponseModel.fromJson(response.data);
       await StorageServices().setUserId(
          res.data.toString(),
        );
        return ResponseModel.complete(data: res);
      }
      else{
        var res = RegisterResponseModel.fromJson(response.data);
        return ResponseModel.withError(message:res.message );
      }

    }on DioException catch (e) {
      if(e.response!.statusCode==400){
        var res=SendCodeResponseModel.fromJson(e.response!.data);
        return ResponseModel.withError(message: res.message);
      }
      if(e.type==DioExceptionType.connectionTimeout){
        return ResponseModel.withError(message: HandleError.internetWeak);
      }
      if(e.type==DioExceptionType.receiveTimeout){
        return ResponseModel.withError(message: HandleError.internetWeak);
      }
      return ResponseModel.withError(message: HandleError.tryAgain);

    }
    catch(e){
      return ResponseModel.withError(message: HandleError.tryAgain);
    }

  }


}