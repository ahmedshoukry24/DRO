import 'dart:convert';

import '../Model/patient.dart';
import 'package:http/http.dart' as http;

import 'URL/mainURL.dart';

class PatientInfo{
  Future<Patient> getPatientInfo(String id)async{
    String url = '${mainURL}patientInfo.php';
    Patient patient;

    http.Response response = await http.post(url,body: {
      'PATIENT_ID': id,
    });

    if(response.statusCode == 200){
      var jsonData = jsonDecode(response.body);
      patient = Patient(
        fName: jsonData[0]['FIRST_NAME'],
        lName: jsonData[0]['LAST_NAME'],
        phone: jsonData[0]['PHONE'],
        gender: jsonData[0]['GENDER'],
        date: jsonData[0]['BIRTH_DATE'],
        email: jsonData[0]['EMAIL'],
        password: jsonData[0]['PASSWORD'],
        id: jsonData[0]['PATIENT_ID'],
        profilePicture: jsonData[0]['PROFILE_PICTURE']
      );
    }
    else{
      print('In SettingsAPI class ::: Can\'t connect the server');
      patient = Patient(email: '0',password: '0',gender: '0',phone: '0',lName: '0',fName: '0',date: '0',id: '0');
    }
    return patient;
  }

}