import 'dart:developer';
import 'package:ayat_project/model/regester_model.dart';
import 'package:ayat_project/model/response_model.dart';
import 'package:ayat_project/utlis/error_hundle.dart';
import 'package:dio/dio.dart';
import '../model/response/response_register_model.dart';
import '../storage/storage.dart';
class RegisterRepository{
Dio dio=Dio(
  BaseOptions(
    baseUrl: 'http://rahmawayat-001-site1.itempurl.com/api/Auth/register',
  receiveDataWhenStatusError: true,
  connectTimeout:const Duration( seconds: 30), // 60 seconds
  receiveTimeout:const Duration( seconds: 30), // 60 seconds
  ),
);
  Future<ResponseModel<RegisterResponseModel>>register(RegisterModel registerModel)async{
    try{
      var response=await dio.post('http://rahmawayat-001-site1.itempurl.com/api/Auth/register',data: registerModel.toJson());
      if(response.statusCode==200){

        return ResponseModel.complete(data: RegisterResponseModel.fromJson(response.data));
      }
      else{
        var res = RegisterResponseModel.fromJson(response.data);
        return ResponseModel.withError(message:res.message );
      }
    }on DioException catch (e) {
      log(e.toString(), name: "DioException catch (e) 1");
      if(e.response!.statusCode==400){
        var res=RegisterResponseModel.fromJson(e.response!.data);
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