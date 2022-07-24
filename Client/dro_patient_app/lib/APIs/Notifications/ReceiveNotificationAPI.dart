import 'package:http/http.dart' as http;
import '../URL/mainURL.dart';
import 'dart:convert';


class ReceiveNotificationAPI{

  Future<List> getNotification({String patientID})async{
    String url = '${mainURL}Alarm/getNotification.php';
    try{
      http.Response response = await http.post(url,body: {
        'PATIENT_ID' : patientID
      });
      if(response.statusCode == 200){
        return jsonDecode(response.body);
      }else return [];
    }catch (e){
      return [];
    }
  }

  void updateNotification({String alarmID}){
    String url ='${mainURL}Alarm/updateNotification.php';
    http.post(url,body: {
      'ALARM_ID' : alarmID
    });
  }

}