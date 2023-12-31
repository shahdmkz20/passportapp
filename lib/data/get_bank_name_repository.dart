import 'dart:developer';
import 'package:ayat_project/model/response/grt_bank_name_model.dart';
import 'package:ayat_project/model/response_model.dart';
import 'package:ayat_project/utlis/error_hundle.dart';
import 'package:dio/dio.dart';

class GetBankNameRepository{
  Dio dio=Dio(  BaseOptions(
    baseUrl: 'http://rahmawayat-001-site1.itempurl.com/api/Payment/GetBanknNames',
    receiveDataWhenStatusError: true,
    connectTimeout:const Duration( seconds: 30), // 60 seconds
    receiveTimeout:const Duration( seconds: 30), // 60 seconds
  ),);


  Future<ResponseModel<GetBankNameModel>>getBankName()async{
    try{
    var response=await dio.get('http://rahmawayat-001-site1.itempurl.com/api/Payment/GetBanknNames');
    if(response.statusCode==200){
      var res=GetBankNameModel.fromJson(response.data);
      return ResponseModel.complete(data: res);
    }
    else if(response.statusCode==400){
      var res=GetBankNameModel.fromJson(response.data);
      return ResponseModel.withError(message: res.message);
    }
    else{
      return ResponseModel.withError(message:HandleError.tryAgain);
    }

    }on DioException catch (e) {
      if(e.type==DioExceptionType.connectionTimeout){
        return ResponseModel.withError(message: HandleError.internetWeak);
      }
      if(e.type==DioExceptionType.receiveTimeout){
        return ResponseModel.withError(message: HandleError.internetWeak);
      }

      if(e.response!.statusCode==400){
        var res=GetBankNameModel.fromJson(e.response!.data);
        return ResponseModel.withError(message: res.message);
      }
      log(e.toString(), name: "DioException catch (e) 1");
      return ResponseModel.withError(message: HandleError.tryAgain);
    }
    catch(e){
      log(e.toString(), name: "DioException catch (e) 1");
      return ResponseModel.withError(message: HandleError.tryAgain);
    }


  }

}