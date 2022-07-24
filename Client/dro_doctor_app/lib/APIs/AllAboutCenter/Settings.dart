import 'dart:convert';

import 'package:dro_doctor_app/APIs/mainURL/mainURL.dart';
import 'package:http/http.dart' as http;


class CenterSettingsAPI{

  Future getCenterInfo({String centerID})async{
    String url = '${mainURL}Center/Settings/GetCenterInfo.php';
    http.Response response = await http.post(url,body: {
      'CENTER_ID': centerID,
    });
    if(response.statusCode == 200){
      return jsonDecode(response.body);
    }
  }

  Future<bool> updateCenterImage({String centerID,String image})async{
    String url = "${mainURL}Center/Settings/updateCenterImage.php";
    http.Response response = await http.post(url,body: {
      'CENTER_ID':centerID,
      'CENTER_PHOTO' : image
    });

    if(response.statusCode == 200){
      return jsonDecode(response.body);
    }else return false;
  }

  Future<bool> updateName({String centerID,String centerName})async{
    String url = "${mainURL}Center/Settings/updateName.php";
    http.Response response = await http.post(url,body: {
      'CENTER_ID':centerID,
      'NAME' : centerName
    });
    if(response.statusCode == 200){
      return jsonDecode(response.body);
    }else return false;

  }

  Future<bool> updateCenterPhone({String centerID,String centerPhone})async{
    String url = "${mainURL}Center/Settings/updateCenterPhone.php";
    http.Response response = await http.post(url,body: {
      'CENTER_ID': centerID,
      'CENTER_PHONE' : centerPhone,
    });
    if(response.statusCode == 200){
      return jsonDecode(response.body);
    }return false;

  }







}