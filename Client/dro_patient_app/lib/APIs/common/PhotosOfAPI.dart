import 'dart:convert';

import '../URL/mainURL.dart';
import 'package:http/http.dart' as http;
class PhotosOfAPI{

  Future getClinicPhotos({String clinicID,String centerID})async{
    String url = '${mainURL}getPhotosOf.php';
    http.Response response = await http.post(url,body: {
      'CLINIC_ID' : clinicID,
      'CENTER_ID' : centerID
    });

    if(response.statusCode == 200){
      return jsonDecode(response.body);
    }return [];

  }

}