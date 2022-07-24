import 'dart:convert';

import 'package:dro_doctor_app/Model/ClinicModel.dart';

import '../mainURL/mainURL.dart';
import 'package:http/http.dart' as http;

class CreateClinicAPI{

  Future<ClinicModel> createClinic({String clinicName,String phone,String address,String doctorID,String clinicKey,String fee}) async{

    String url = '${mainURL}Clinic/CreateClinic.php';
    ClinicModel clinicModel;

    http.Response response = await http.post(url,body: {
      'CLINIC_NAME' : clinicName,
      'PHONE' : phone,
      'ADDRESS' : address,
      'DOCTOR_ID' : doctorID,
      'CLINIC_KEY' : clinicKey,
      'FEE' : fee,
    });

    if(response.statusCode == 200){
      bool result = jsonDecode(response.body);
      if(result){
        clinicModel = await getClinic(clinicKey);
        if(clinicModel.clinicID !='0'){
          return clinicModel;
        }else return ClinicModel(clinicID: '0',doctorID: '0',clinicKey: '0');
      }else return ClinicModel(clinicID: '0',doctorID: '0',clinicKey: '0');
    }else return ClinicModel(clinicID: '0',doctorID: '0',clinicKey: '0');
  }


  Future<ClinicModel> getClinic(String clinicKey) async{
    String url = '${mainURL}Clinic/getClinic.php';
    http.Response response = await http.post(url,body: {
      'CLINIC_KEY' : clinicKey,
    });

    if(response.statusCode == 200){
      List jsonData = jsonDecode(response.body);
      return ClinicModel(
        clinicKey: jsonData[0]['CLINIC_KEY'],
        doctorID: jsonData[0]['DOCTOR_ID'],
        clinicID: jsonData[0]['CLINIC_ID'],
        phone: jsonData[0]['CLINIC_PHONE'],
        clinicName: jsonData[0]['CLINIC_NAME'],
        address: jsonData[0]['ADDRESS'],
        fee: jsonData[0]['FEE'],
      );
    }else return ClinicModel(clinicKey: '0',doctorID: '0',clinicID: '0');

  }

}