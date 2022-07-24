import 'dart:convert';

import 'package:dro_doctor_app/APIs/mainURL/mainURL.dart';
import 'package:http/http.dart' as http;

class ClinicSettingsAPI{

  Future<bool> updateClinicName({String clinicID,String newName})async{

    String url = '${mainURL}Clinic/Settings/updateName.php';

    http.Response response = await http.post(url,body: {
      "CLINIC_NAME" : newName,
      "CLINIC_ID" : clinicID,
    });

    if(response.statusCode == 200){
      return jsonDecode(response.body);
    }return false;

  }


  Future<bool> updateClinicPhone({String clinicID,String newPhone})async{

    String url = '${mainURL}Clinic/Settings/updatePhone.php';

    http.Response response = await http.post(url,body: {
      "CLINIC_ID" : clinicID,
      "CLINIC_PHONE" : newPhone,
    });

    if(response.statusCode == 200){
      return jsonDecode(response.body);
    }return false;

  }


  Future<bool> updateClinicFEE({String clinicID,String newFee})async{

    String url = '${mainURL}Clinic/Settings/updateFee.php';

    http.Response response = await http.post(url,body: {
      "CLINIC_ID" : clinicID,
      "FEE" : newFee,
    });

    if(response.statusCode == 200){
      return jsonDecode(response.body);
    }return false;

  }



}