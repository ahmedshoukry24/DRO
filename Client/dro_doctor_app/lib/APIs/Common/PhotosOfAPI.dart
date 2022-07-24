import 'dart:convert';

import 'package:dro_doctor_app/APIs/mainURL/mainURL.dart';
import 'package:http/http.dart' as http;

class PhotosOfAPI{

  Future<bool> postPhotoOf({String centerID,String clinicID,String imageName})async{
    String url = '${mainURL}common/postPhotoOf.php';
    http.Response response = await http.post(url,body: {
      'CLINIC_ID': clinicID,
      'CENTER_ID': centerID,
      'PHOTO_NAME': imageName
    });
    if(response.statusCode == 200){
      return jsonDecode(response.body);
    }return false;
  }

  Future<List> getPhotosOf({String centerID,String clinicID})async{
    String url = '${mainURL}common/getPhotosOf.php';
    http.Response response = await http.post(url,body: {
      'CENTER_ID':centerID,
      'CLINIC_ID': clinicID,
    });
    if(response.statusCode == 200){
      return jsonDecode(response.body);
    }return [];
  }

  Future<bool> postListPhotosOf({String clinicID,String centerID,List myList})async{

    String url = '${mainURL}common/postListPhotosOf.php';

   http.Response response = await http.post(url,body: {
      'CLINIC_ID' : clinicID,
      'CENTER_ID': centerID,
      'images' : jsonEncode(myList)
    });
   if(response.statusCode == 200){
     return jsonDecode(response.body);
   }return false;

  }

  void deletePhotoOf({String photoName,String path}){
    String url = '${imageLoc}delete.php';
    http.post(url,body: {
      'fileName': photoName,
      'path' : path,
    });
  }

  Future<bool> deletePhotoOfFromDB({String fileName})async{
    String url = '${mainURL}common/deletePhotoOf.php';

    http.Response response = await http.post(url,body: {
      'PHOTO_NAME': fileName,
    });
    if(response.statusCode == 200){
      return jsonDecode(response.body);
    }return false;
  }

}