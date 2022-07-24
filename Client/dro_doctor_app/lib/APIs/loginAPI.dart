import 'dart:convert';

import '../Model/doctor.dart';
import 'package:http/http.dart' as http;

import 'mainURL/mainURL.dart';

class LoginAPI{

  Future<DoctorModel> login(String email,String password)async{
    String url = '${mainURL}login.php';
    DoctorModel doctor;

    http.Response response = await http.post(url,body: {
      'EMAIL': email,
      'PASSWORD': password
    });

    if(response.statusCode == 200){
      var jsonData = jsonDecode(response.body);
      if(jsonData.length == 0 || jsonData.length > 1){
        doctor = DoctorModel(fName: '0',lName: '0',password: '0',email: '0',date: '0',gender: '0',phone: '0',title: '0',specialty: '0');
      }else{
        doctor = DoctorModel(
          fName:    jsonData[0]['FIRST_NAME'],
          lName:    jsonData[0]['LAST_NAME'],
          email:    jsonData[0]['EMAIL'],
          title:    jsonData[0]['TITLE'],
          password: jsonData[0]['PASSWORD'],
          phone:    jsonData[0]['PHONE'],
          specialty:jsonData[0]['SPECIALITY'],
          gender:   jsonData[0]['GENDER'],
          date:     jsonData[0]['BIRTH_DATE'],
          id:       jsonData[0]['DOCTOR_ID'],
          bio:      jsonData[0]['BIO'],
          profilePicture: jsonData[0]['PROFILE_PICTURE']
        );
      }
    }else{
      doctor = DoctorModel(fName: '0',lName: '0',password: '0',email: '0',date: '0',gender: '0',phone: '0',title: '0',specialty: '0');
    }

    return doctor;
  }

}