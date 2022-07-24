

import 'dart:convert';
import 'package:dro_patient_app/Model/Appointments/center.dart';
import 'package:dro_patient_app/Model/Appointments/clinic.dart';
import 'package:intl/intl.dart';

import '../URL/mainURL.dart';
import 'package:http/http.dart' as http;

class AppointmentsAPI{


  Future getAppointmentsAPI(String patientID) async{
    String url = '${mainURL}getAppointments.php';
    http.Response response = await http.post(url,body: {
      'PATIENT_ID' : patientID,
    });
    if(response.statusCode == 200){
      List jsonData = jsonDecode(response.body);
      List finalList =[];
      jsonData.forEach((element) {
        if(element['CLINIC_ID']=='-1'){
          DateTime dateTime = DateFormat("yyy-M-d HH:mm:ss").parse("${element['DATE']} ${element['TIME']}");
          finalList.add(CenterAppointmentModel(
            patientID: element['PATIENT_ID'],
            clinicID: element['CLINIC_ID'],
            centerID: element['CENTER_ID'],
           dateTime: dateTime,
            channelID: element['CHANNEL_ID'],
            name: element['NAME'],
            address: element['ADDRESS'],
            centerPhone: element['CENTER_PHONE'],
            speciality: element['SPECIALITY'],
            fee: element['FEE'],
            centerPhoto: element['CENTER_PHOTO'],
          ));
        }else{
          DateTime dateTime = DateFormat("yyy-M-d HH:mm:ss").parse("${element['DATE']} ${element['TIME']}");
          finalList.add(ClinicAppointmentModel(
            patientID: element['PATIENT_ID'],
            clinicID: element['CLINIC_ID'],
            centerID: element['CENTER_ID'],
            dateTime: dateTime,
            channelID: element['CHANNEL_ID'],
            clinicName: element['CLINIC_NAME'],
            doctorID: element['DOCTOR_ID'],
            address: element['ADDRESS'],
            clinicPhone: element['CLINIC_PHONE'],
            fee: element['FEE'],
            firstName: element['FIRST_NAME'],
            lastName: element['LAST_NAME'],
            speciality: element['SPECIALITY'],
            profilePicture: element['PROFILE_PICTURE'],
          ));
        }
      });
      return finalList;
    }else{
      return [];
    }
  }

  Future<bool> cancelAppointment({String patientID,String clinicID,String centerID,String date,String time}) async{
    String url = '${mainURL}cancelAppointment.php';
    http.Response response = await http.post(url,body:{
      'PATIENT_ID' : patientID,
      'CLINIC_ID' : clinicID,
      'CENTER_ID' : centerID,
      'DATE' : date,
      'TIME' : time,
    });
    if(response.statusCode == 200){
      return jsonDecode(response.body);
    }else return false;
  }
}