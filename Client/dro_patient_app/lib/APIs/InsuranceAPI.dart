import 'dart:convert';

import 'package:dro_patient_app/APIs/URL/mainURL.dart';
import 'package:http/http.dart' as http;

class InsuranceAPI{
  Future<List> getInsurance({String clinicID,String centerID})async{
    String url = '${mainURL}clinicDetails/getInsurance.php';
    try{
      http.Response response = await http.post(url,body: {
        'CENTER_ID' : centerID,
        'CLINIC_ID' : clinicID,
      });
      if(response.statusCode == 200){
        return jsonDecode(response.body);
      }else return [];
    }catch (e){
      return [];
    }
  }
}