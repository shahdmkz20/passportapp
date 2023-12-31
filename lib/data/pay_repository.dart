import 'dart:ui';

import 'package:ayat_project/model/pay_model.dart';
import 'package:ayat_project/model/response/pey_response.dart';
import 'package:ayat_project/utlis/error_hundle.dart';
import 'package:dio/dio.dart';

import '../model/response_model.dart';

class PeyRepository{
  Dio dio=Dio(
    BaseOptions(
      baseUrl: 'http://rahmawayat-001-site1.itempurl.com/api/Payment/AddPayment',
      receiveDataWhenStatusError: true,
      connectTimeout:const Duration( seconds: 60), // 60 seconds
      receiveTimeout:const Duration( seconds: 60), // 60 seconds
    ),
  );
  Future<ResponseModel<PeyResponseModel>>addPey(PymentModel pymentModel)async{
    try{
      var response=await dio.post('http://rahmawayat-001-site1.itempurl.com/api/Payment/AddPayment',data: pymentModel.toJson());

      if(response.statusCode==200){
        var res=PeyResponseModel.fromJson(response.data);
        return ResponseModel.complete(data: res);
      }

      else {
        return ResponseModel.withError(message: HandleError.tryAgain);
      }
      
    }on DioException catch (e) {


      if(e.type==DioExceptionType.connectionTimeout){
        return ResponseModel.withError(message: HandleError.internetWeak);
      }
      if(e.response!.statusCode==400){
        var res=PeyResponseModel.fromJson(e.response!.data);
        return ResponseModel.withError(message: res.message);
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