import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'URL/mainURL.dart';

class BookingSectionAPIs{

  // from week_days table
  Future<List> getSchedule({String clinicID,String centerID}) async{

    String url = "${mainURL}getSchedule.php";

    http.Response response = await http.post(url,body: {
      'CLINIC_ID' : clinicID,
      'CENTER_ID' : centerID
    });

    if(response.statusCode == 200){
      return jsonDecode(response.body);
    }else{
      return [];
    }

  }

  // from reservation table
  Future selectedTimes({String clinicID,String date,String centerID})async{
    String url = '${mainURL}selectedTimes.php';
    http.Response response = await http.post(url,body: {
      'CLINIC_ID':clinicID,
      'DATE':date,
      'CENTER_ID' : centerID,
    });

    if(response.statusCode == 200){
      return jsonDecode(response.body);
    }else{
      return [];
    }
  }


  // from doctor, clinic, patient
  Future clinicConfirmBookingAPI({String clinicId,String patientId})async{

    String url = '${mainURL}clinicConfirmPage.php';

    http.Response response = await http.post(url,body: {
      'CLINIC_ID': clinicId,
      'PATIENT_ID': patientId,
    });

    if(response.statusCode == 200){
      return jsonDecode(response.body);
    }else{
      return [];
    }

  }

  // from patient, center
  Future centerConfirmBookingAPI({String centerID,String patientID})async{
    String url = '${mainURL}centerConfirmPage.php';
    http.Response response = await http.post(url,body: {
      'CENTER_ID' : centerID,
      'PATIENT_ID' : patientID
    });
    if(response.statusCode == 200){
      return jsonDecode(response.body);
    }else return {};
  }

  // to reservation table
  Future setAppointment({String clinicID,String patientID,String centerID,String date,String time,String channelID})async{
    String url = '${mainURL}setAppointment.php';
    http.Response response = await http.post(url,body: {
      'PATIENT_ID' : patientID,
      'CLINIC_ID' : clinicID,
      'DATE': date,
      'TIME' : time,
      'CENTER_ID': centerID,
      'CHANNEL_ID': channelID
    });
    if(response.statusCode == 200){
      return jsonDecode(response.body);
    }else{
      return false;
    }
  }

}