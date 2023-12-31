import 'dart:developer';

import 'package:ayat_project/model/get_passport_information_model.dart';
import 'package:ayat_project/model/response_model.dart';
import 'package:ayat_project/utlis/error_hundle.dart';
import 'package:dio/dio.dart';

import '../storage/storage.dart';

class GetPassportRepository{
  Dio dio=Dio(
    BaseOptions(
      baseUrl: 'http://rahmawayat-001-site1.itempurl.com/api/PassportRequest/GetPassportRequestByUserId/',
      receiveDataWhenStatusError: true,
      connectTimeout:const Duration( seconds: 30), // 60 seconds
      receiveTimeout:const Duration( seconds: 30), // 60 seconds
    ),
  );
  Future<ResponseModel<GetPassportInformationModel>>getInformation()async{
    try{
      String? x=await StorageServices().getUserId??'';
      int y=int.parse(x);
      var response=await dio.get(
          'http://rahmawayat-001-site1.itempurl.com/api/PassportRequest/GetPassportRequestByUserId?id=$y');
      if(response.statusCode==200){
        var res= GetPassportInformationModel.fromJson(response.data);

        return ResponseModel.complete(data:GetPassportInformationModel.fromJson( response.data));
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
      log(e.toString(), name: "DioException catch (e) 1");
      return ResponseModel.withError(message: HandleError.tryAgain);
    }
    catch(e){
      log(e.toString(), name: "DioException catch (e) 1");
      return ResponseModel.withError(message: HandleError.tryAgain);
    }
  }
}