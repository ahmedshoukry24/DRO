import 'dart:convert';

import 'mainURL/mainURL.dart';
import '../Model/doctor.dart';
import 'package:http/http.dart' as http;


class DoctorInfoAPI{

  Future<DoctorModel> getDoctorInfo(String id) async{

    String url = '${mainURL}DoctorInfo.php';
    DoctorModel doctor;

    http.Response response = await http.post(url,body: {
      'DOCTOR_ID':id,
    });

    if(response.statusCode == 200){
      var jsonData = jsonDecode(response.body);

      doctor = DoctorModel(
        fName:      jsonData[0]['FIRST_NAME'],
        lName:      jsonData[0]['LAST_NAME'],
        email:      jsonData[0]['EMAIL'],
        title:      jsonData[0]['TITLE'],
        specialty:  jsonData[0]['SPECIALITY'],
        gender:     jsonData[0]['GENDER'],
        date:       jsonData[0]['BIRTH_DATE'],
        phone:      jsonData[0]['PHONE'],
        password:   jsonData[0]['PASSWORD'],
        id:         jsonData[0]['DOCTOR_ID'],
        bio:        jsonData[0]['BIO'],
        profilePicture: jsonData[0]['PROFILE_PICTURE']
      );

    }

    return doctor;

  }

}