import 'dart:convert';
import 'package:dro_doctor_app/APIs/mainURL/mainURL.dart';
import 'package:dro_doctor_app/Model/doctor.dart';
import 'package:http/http.dart' as http;


class CenterDoctorsAPI{

  // doctors who work at center
  Future<List<DoctorModel>> getCenterDoctors({String centerID})async{
    String url = '${mainURL}Center/ManagerView/centerDoctors.php';
    http.Response response = await http.post(url,body: {
      'CENTER_ID': centerID,
    });
    List<DoctorModel> doctors = [];

    if(response.statusCode == 200){
      List jsonData = jsonDecode(response.body);
      for(int i=0; i<jsonData.length; i++){
        doctors.add(DoctorModel(
          fName: jsonData[i]['FIRST_NAME'],
          lName: jsonData[i]['LAST_NAME'],
          id: jsonData[i]['DOCTOR_ID'],
          specialty: jsonData[i]['SPECIALITY'],
          title: jsonData[i]['TITLE'],
          phone: jsonData[i]['PHONE'],
          gender: jsonData[i]['GENDER'],
          email: jsonData[i]['EMAIL'],
          profilePicture: jsonData[i]['PROFILE_PICTURE'],
        ));
      }
      return doctors;
    } else return doctors;
  }

  // add doctors page
  Future<List<DoctorModel>> getDoctors({String centerID})async{

    List<DoctorModel> doctors = [];

    String url = '${mainURL}Center/ManagerView/addDoctors.php';
    http.Response response = await http.post(url,body: {
      'CENTER_ID':centerID
    });

    if(response.statusCode == 200){

      for(var i in jsonDecode(response.body)){
        doctors.add(DoctorModel(
          id: i['DOCTOR_ID'],
          fName: i['FIRST_NAME'],
          lName: i['LAST_NAME'],
          specialty: i['SPECIALITY'],
          title: i['TITLE'],
          phone: i['PHONE'],
          gender: i['GENDER'],
          email: i['EMAIL'],
          bio: i['BIO'],
          profilePicture: i['PROFILE_PICTURE']
        ));
      }

      return doctors;
    }else return [];
  }

  // add doctors page
  Future addDoctorToCenter({String centerID,String doctorID})async{
    String url = "${mainURL}Center/ManagerView/addDoctor.php";
    http.Response response = await http.post(url,body: {
      'CENTER_ID': centerID,
      'DOCTOR_ID' : doctorID,
    });
    if(response.statusCode == 200){
      return jsonDecode(response.body);
    }else return false;
  }

}