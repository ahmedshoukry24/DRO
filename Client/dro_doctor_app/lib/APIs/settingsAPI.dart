import 'dart:convert';

import 'package:flutter/cupertino.dart';

import 'mainURL/mainURL.dart';
import '../OfflineDatabase/helper.dart';
import '../OfflineDatabase/model.dart';
import 'package:http/http.dart' as http;


class SettingsAPIs{

  DatabaseHelper db = DatabaseHelper();

  Future<bool> updateImage({@required String doctorID,@required String imageName})async{
    String url = "${mainURL}settings/updateImage.php";
    http.Response response = await http.post(url,body: {
      'PROFILE_PICTURE': imageName,
      'DOCTOR_ID': doctorID,
    });

    if(response.statusCode == 200){
      return jsonDecode(response.body);
    }else{
      return false;
    }

}

  Future<int> editName({String email,String newFName,String newLName,String id})async{
    String url = '${mainURL}settings/changeName.php';
    int result;

    http.Response response = await http.post(url,body: {
      'DOCTOR_ID':id,
      'FIRST_NAME':newFName,
      'LAST_NAME':newLName,
    });

    if(response.statusCode == 200){
      if(jsonDecode(response.body) != true){
        result = 0;
      }else result = 1;
    } else result = 0;

    // ** edit offline database
    OfflineUser user = await db.getUser();
    OfflineUser newUser = OfflineUser(email: user.email,fName: newFName,lName: newLName,id: user.id,status: user.status);
    await db.updateName(newUser);
    // * end editing database

    return result;
  }

  Future<int> editPhone({String email, String newPhone,String id})async{
    String url = '${mainURL}settings/changePhone.php';
    int result;
    http.Response response = await http.post(url,body: {
      'DOCTOR_ID':id,
      'PHONE' : newPhone,
    });

    if(response.statusCode == 200){
      if(jsonDecode(response.body) != true){
        result = 0;
      }else result = 1;
    }

    return result;

  }

  Future<int> editPassword({String email,String newPassword,String id})async{
    String url = '${mainURL}settings/changePAssword.php';
    int result;

    http.Response response = await http.post(url,body: {
      'DOCTOR_ID':id,
      'PASSWORD':newPassword,
    });

    if(response.statusCode == 200){
      if(jsonDecode(response.body) != true){
        result = 0;
      }else result = 1;
    }
    return result;
  }

  Future<bool> editBio({String bio,String doctorID})async{
    String url = '${mainURL}settings/changeBio.php';

    http.Response response = await http.post(url,body: {
      'BIO' : bio,
      'DOCTOR_ID' : doctorID,
    });
    if(response.statusCode == 200){
      return jsonDecode(response.body);
    }return false;
  }


}