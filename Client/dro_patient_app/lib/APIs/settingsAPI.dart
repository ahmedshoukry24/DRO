import 'dart:convert';
import 'package:flutter/cupertino.dart';

import '../OfflineDatabase/helper.dart';
import '../OfflineDatabase/model.dart';
import '../APIs/URL/mainURL.dart';
import 'package:http/http.dart' as http;

class SettingsAPI{

  DatabaseHelper db = DatabaseHelper();

  Future updateImage({@required String patientID, @required String imageName})async{
    String url = '${mainURL}settings/updateImage.php';
    http.Response response = await http.post(url,body:{
      'PATIENT_ID' : patientID,
      'PROFILE_PICTURE' : imageName,
    });
    if(response.statusCode == 200){
      return jsonDecode(response.body);
    }else return false;

  }

  Future<int> editName({String newFName,String newLName,String email,String id}) async{
    String url = '${mainURL}settings/changeName.php';
    int result;

    http.Response response = await http.post(url,body: {
      'FIRST_NAME': newFName,
      'LAST_NAME':newLName,
      'PATIENT_ID': id,
    });
     if(response.statusCode == 200){
       if(jsonDecode(response.body)){
         result = 1;
       }else{
         result = 0;
       }
     }else{
       result = 0;
     }
     // ** edit offline database
     OfflinePatient user = await db.getUser();
     OfflinePatient newUser = OfflinePatient(id: user.id,email: user.email,fName: newFName,lName: newLName,status: user.status);
     await db.updateName(newUser);
     // ** end editing offline database

     return result;
  }

  Future<int> editPassword({String newPassword,String email,String id})async{
    String url = '${mainURL}settings/changePassword.php';
    int result;
    http.Response response = await http.post(url,body: {
      'PASSWORD':newPassword,
      'PATIENT_ID': id,
    });
    if(response.statusCode == 200){
      if(jsonDecode(response.body)){
        result = 1 ;
      }else result = 0;
    }else result = 0;
    return result;
  }

  Future<int> editPhone({String newPhone,String email,String id}) async{
    String url = '${mainURL}settings/changePhone.php';
    int result;
    http.Response response = await http.post(url,body: {
      'PHONE': newPhone,
      'PATIENT_ID': id,
    });
    if(response.statusCode == 200){
      if(jsonDecode(response.body)){
        result = 1;
      }else result = 0;
    }else result = 0;

    return result;
  }

}