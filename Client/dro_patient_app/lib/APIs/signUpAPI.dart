import 'dart:convert';
import 'loginAPI.dart';

import '../Model/patient.dart';
import 'package:http/http.dart' as http;
import 'URL/mainURL.dart';

class SignUpAPI  {

  LoginAPI loginAPI = LoginAPI();

  Future<Patient> signUp(fName,lName,phone,email,password,birthDate,gender)async{
    String url = '${mainURL}signUp.php';
    Patient patient;
    http.Response response = await http.post(url,body: {
      'FIRST_NAME': fName,
      'LAST_NAME': lName,
      'PHONE': phone,
      'EMAIL': email,
      'PASSWORD': password,
      'BIRTH_DATE': birthDate,
      'GENDER': gender,
    });
    if(response.statusCode == 200){
      if(jsonDecode(response.body)){
//        patient = Patient(fName: fName,lName: lName,phone: phone,password: password,email: email,date: birthDate,gender: gender);
      patient = await loginAPI.login(email, password);
      print(patient.id);
      print(patient.date);
      print(patient.phone);
      print(patient.email);
      print(patient.fName);
      print(patient.lName);
      print(patient.gender);
      print(patient.password);

      }else{
        return patient = Patient(email: '0',password: '0',gender: '0',phone: '0',lName: '0',fName: '0',date: '0');
      }
    }
    else{
      patient = Patient(email: '0',password: '0',gender: '0',phone: '0',lName: '0',fName: '0',date: '0');
    }
    return patient;
  }
}
