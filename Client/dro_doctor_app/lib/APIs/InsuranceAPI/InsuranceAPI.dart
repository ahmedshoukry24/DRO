import 'dart:convert';

import 'package:dro_doctor_app/APIs/mainURL/mainURL.dart';
import 'package:http/http.dart' as http;

class InsuranceAPI{

  Future setInsurance({String clinicID,String centerID,String insurance})async{
    String url = '${mainURL}common/setInsurance.php';

    try{
      http.Response response = await http.post(url,body: {
        'CLINIC_ID' : clinicID,
        'CENTER_ID' : centerID,
        'INSUR_NAME' : insurance
      });

      if(response.statusCode == 200){
        return jsonDecode(response.body);
      }else return false;
    }catch (e){
      return false;
    }

  }

}