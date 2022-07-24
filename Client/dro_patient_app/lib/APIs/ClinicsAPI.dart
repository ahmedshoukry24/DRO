import 'dart:convert';

import 'package:http/http.dart' as http;
import 'URL/mainURL.dart';


class ClinicsAPI{
  Future getClinics(String cat) async{
    String url = '${mainURL}getClinics.php';
    http.Response response = await http.post(url,body: {
      'cat' : cat
    });
    if(response.statusCode == 200){
      return jsonDecode(response.body);
    }else{
      return [];
    }
  }

  Future getClinicDetailsAPI({String clinicID}) async{
    String url = '${mainURL}clinicDetails/clinicDetails.php';

    http.Response response = await http.post(url,body: {
      'CLINIC_ID': clinicID,
    });

    if(response.statusCode == 200){
      return jsonDecode(response.body);
    }else{
      return [];
    }
  }



}