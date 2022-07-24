import 'dart:convert';

import 'package:dro_doctor_app/APIs/mainURL/mainURL.dart';
import 'package:http/http.dart' as http;

class OffersAPI{


  Future<bool> postOffer({String clinicID,String centerID,String figureName, String content})async{
    String url = '${mainURL}common/Offers.php';
    http.Response response = await http.post(url,body: {
      "CLINIC_ID" : clinicID,
      "CENTER_ID" : centerID,
      "CONTENT" : content,
      "FIGURE_NAME" : figureName,
      "DATE_TIME" : "${DateTime.now()}"
    });

    if(response.statusCode == 200){
      return jsonDecode(response.body);
    }return false;

  }

}