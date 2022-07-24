import 'dart:convert';

import '../mainURL/mainURL.dart';
import 'package:http/http.dart' as http;

class ClinicInfoAPI{

  Future getClinicInfo(String clinicID) async{
    String url = '${mainURL}Clinic/clinicInfo.php';
    List data = List();

    http.Response response = await http.post(url,body: {
      'CLINIC_ID' : clinicID,
    });

    if(response.statusCode == 200){
      data = jsonDecode(response.body);
     return data;
    }else{
      return data;
    }
  }

}