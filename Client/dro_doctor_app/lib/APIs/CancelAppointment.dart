import 'dart:convert';

import 'package:http/http.dart' as http;

import 'mainURL/mainURL.dart';

class CancelAppointment{
  Future<bool> cancelAppointment({
    String patientID,
    String clinicID,
    String centerID,
    String date,
    String time
  })async{
    print(patientID);
    print(clinicID);
    print(centerID);
    print(date);
    print(time);
    String url = '${mainURL}cancelAppointment.php';
    try{
      http.Response response = await http.post(url,body: {
        'PATIENT_ID' : patientID,
        'CLINIC_ID' : clinicID,
        'CENTER_ID' : centerID,
        'DATE' : date,
        'TIME' : time
      });

      if(response.statusCode == 200){
        print("${jsonDecode(response.body)} ++++");
        return jsonDecode(response.body);
      }else return false;
    }catch (e){
      print(e);
      return false;
    }
  }
}