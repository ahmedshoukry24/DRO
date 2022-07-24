import 'dart:convert';

import 'package:dro_doctor_app/APIs/mainURL/mainURL.dart';
import 'package:http/http.dart' as http;

class PrescriptionAPI{

  Future<bool> setPrescription({String patientID,String doctorID,String description,String image})async{
    String url = '${mainURL}setMedicalRecord.php';

    try{
      http.Response response = await http.post(url,body: {
        'PATIENT_ID' :patientID,
        'DOCTOR_ID' : doctorID,
        'DESCRIPTION' : description,
        'IMAGE' : image,
        'DATE_TIME' : '${DateTime.now()}'
      });

      if(response.statusCode == 200){
        return jsonDecode(response.body);
      }else return false;
    }catch (e){
      return false;
    }

  }

}