import 'dart:convert';

import 'package:dro_patient_app/APIs/URL/mainURL.dart';
import 'package:http/http.dart' as http;

class MedicalRecordAPI{

  Future getMedicalRecord(String patientID)async{
    String url = '${mainURL}getMedicalRecord.php';
    http.Response response = await http.post(url,body: {
      'PATIENT_ID' : patientID
    });
    if(response.statusCode == 200){
      return jsonDecode(response.body);
    }else return [];
  }

}