import 'dart:convert';

import 'package:dro_doctor_app/APIs/mainURL/mainURL.dart';
import 'package:http/http.dart' as http;

class SetAlarmAPI{

  Future<bool> setAlarm({String patientID,String title,String body})async{
    String url = '${mainURL}Alarm/setAlarm.php';
    try{
      http.Response response = await http.post(url,body: {
        'PATIENT_ID' : patientID,
        'TITLE' : title,
        'BODY' : body,
        'DATE_TIME' : '${DateTime.now()}'
      });
      if(response.statusCode == 200){
        return jsonDecode(response.body);
      }else return false;
    }catch (e){
      print('cancel notification API ======)>)>)>)>)> $e');
      return false;
    }

  }

}