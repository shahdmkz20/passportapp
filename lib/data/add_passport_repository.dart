import 'dart:developer';
 import 'package:ayat_project/model/add_passport_model.dart';
import 'package:ayat_project/model/response/add_passport_response_model.dart';
import 'package:ayat_project/model/response/upload_image_response_model.dart';
import 'package:ayat_project/model/upload_image_model.dart';
import 'package:ayat_project/storage/storage.dart';
import 'package:ayat_project/utlis/error_hundle.dart';
import 'package:dio/dio.dart';
import '../model/response_model.dart';
class AddPassportRepository{
  Dio dio=Dio(
    BaseOptions(
      baseUrl: 'http://rahmawayat-001-site1.itempurl.com/api/PassportRequest/AddPassportRequest/',
      receiveDataWhenStatusError: true,
      connectTimeout:const Duration( seconds: 30), // 60 seconds
      receiveTimeout:const Duration( seconds: 30), // 60 seconds
    ),
  );
  //500 طلب تاني
 Future<ResponseModel<AddPassportResponseModel>>addPassport(AddPassportModel addPassportModel,UploadImageModel uploadImageModel)async{
   
   try{

     String? x=await StorageServices().getUserId??'';
     int y=int.parse(x);
    var response =await dio.post(
        'http://rahmawayat-001-site1.itempurl.com/api/PassportRequest/AddPassportRequest?id=$y',
        data: addPassportModel.toJson(),

    );
    if(response.statusCode==200){
      var res=AddPassportResponseModel.fromJson(response.data);
      await StorageServices().setPassportId(res.data);
       await uploadImage(
           uploadImageModel,
       );
      return ResponseModel.complete(data: res);
    }
    else{
      return ResponseModel.withError(message: HandleError.tryAgain);

    }
     
   }on DioException catch (e) {
     if(e.type==DioExceptionType.connectionTimeout){
       return ResponseModel.withError(message: HandleError.internetWeak);
     }
     if(e.type==DioExceptionType.receiveTimeout){
       return ResponseModel.withError(message: HandleError.internetWeak);
     }
     if(e.response!.statusCode==400){
       var res=AddPassportResponseModel.fromJson(e.response!.data);
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
 
 Future<ResponseModel<UploadImageResponseModel>>uploadImage(UploadImageModel uploadImageModel)async{

   try{

     Map<String, String?> headers = {
       "UserId": "${ int.parse(await StorageServices().getUserId??'') }",
       "Content-Type": "multipart/form-data"
     };
     FormData formData=FormData.fromMap({
       "f":await MultipartFile.fromFile( uploadImageModel. personalImage!.path),
       "f2":await MultipartFile.fromFile( uploadImageModel. personalImage!.path),
       "f3":await MultipartFile.fromFile( uploadImageModel. personalImage!.path),
     });
     var response=await dio.post('http://rahmawayat-001-site1.itempurl.com/api/PassportRequest/UploadImagesToPassPortRequest',
         data: formData,
         options: Options(
           headers:headers,
         )
     );
     if(response.statusCode==200){
       return ResponseModel.complete(data: UploadImageResponseModel.fromJson(response.data));
     }
     else{
     return  ResponseModel.withError(message: HandleError.tryAgain);
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
     return ResponseModel.withError(message: HandleError.tryAgain);
   }
   
 }
}

