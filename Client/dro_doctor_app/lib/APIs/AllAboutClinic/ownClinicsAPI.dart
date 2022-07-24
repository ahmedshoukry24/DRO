 // ** Manage and create clinic (Page API)
import 'dart:convert';

import '../mainURL/mainURL.dart';

import '../../Model/ClinicModel.dart';
import 'package:http/http.dart' as http;


class OwnClinicsAPI{
  Future<List> clinics(String doctorID) async{
    String url = '${mainURL}clinic/ownClinic.php';
    http.Response response = await http.post(url,body: {
      'DOCTOR_ID' : doctorID,
    });

    if(response.statusCode == 200){
      return jsonDecode(response.body);
    }else{
      return  [];
    }
    }
  }