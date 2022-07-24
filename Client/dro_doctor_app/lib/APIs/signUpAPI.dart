import 'dart:convert';

import 'loginAPI.dart';
import 'mainURL/mainURL.dart';
import '../Model/doctor.dart';
import 'package:http/http.dart' as http;

class SignUpAPI{

  Future<DoctorModel> signUpAPI({String fN,String lN,String email,String password,
    String phone,String specialty,String title,String date,String gender}) async{
    String url = '${mainURL}signUp.php';
    DoctorModel doctor;

    LoginAPI loginAPI = LoginAPI();

    http.Response response = await http.post(url,body: {
      'FIRST_NAME': fN,
      'LAST_NAME' : lN,
      'EMAIL' : email,
      'PASSWORD' : password,
      'PHONE' : phone,
      'SPECIALITY' : specialty,
      'TITLE':title,
      'BIRTH_DATE':date,
      'GENDER': gender,
    });

    if(response.statusCode == 200){
      var jsonData = jsonDecode(response.body);
      if(jsonData != true){
        doctor = DoctorModel(title: '0',specialty: '0',gender: '0',date: '0',email: '0',
          bio: '0',id: '0',phone: '0',lName: '0',fName: '0',password: '0',);
      }else{
      doctor = await loginAPI.login(email, password);
      }
    }

    return doctor;
  }



}