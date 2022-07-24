import 'dart:convert';
import '../APIs/URL/mainURL.dart';
import '../Model/patient.dart';
import 'package:http/http.dart' as http;

class LoginAPI{
  Future<Patient>login(String email,String password)async{
    String url = '${mainURL}login.php';
    Patient patient;
    http.Response response = await http.post(url,body: {
      'EMAIL': email,
      'PASSWORD':password
    });
    if(response.statusCode == 200){
      var jsonData = jsonDecode(response.body);
      if(jsonData.length == 0){
        print('In LoginAPI class ::: No data came from database ');
        patient = Patient(email: '0',password: '0',gender: '0',phone: '0',lName: '0',fName: '0',date: '0');
      }else{
        patient = Patient(
          fName: jsonData[0]['FIRST_NAME'],
          lName: jsonData[0]['LAST_NAME'],
          phone: jsonData[0]['PHONE'],
          gender: jsonData[0]['GENDER'],
          date: jsonData[0]['BIRTH_DATE'],
          email: jsonData[0]['EMAIL'],
          password: jsonData[0]['PASSWORD'],
          id: jsonData[0]['PATIENT_ID'],
        );
      }
    }else{
      print('In LoginAPI class ::: Can\'t connect the server');
      patient = Patient(email: '0',password: '0',gender: '0',phone: '0',lName: '0',fName: '0',date: '0');
    }
    return patient;
  }

}