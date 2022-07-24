import 'dart:convert';
import 'package:http/http.dart' as http;
import 'URL/mainURL.dart';

class CentersAPI{

  Future getCenter(String cat)async{
    String url = '${mainURL}getCenters.php';

    http.Response response = await http.post(url,body: {
      'cat' : cat
    });
    if(response.statusCode == 200){
      return jsonDecode(response.body);
    }else return [];
  }

  Future getCenterDoctorsAPI({String centerID})async{
    String url = '${mainURL}centerDoctors.php';
    http.Response response = await http.post(url,body: {
      'CENTER_ID' : centerID
    });
    if(response.statusCode == 200){
      return jsonDecode(response.body);
    }else return [];
  }

  Future clinicInCenter({String doctorID}) async {
    String url = '${mainURL}getClinicInCenter.php';
    http.Response response = await http.post(url,body: {
      'DOCTOR_ID' : doctorID,
    });

    if(response.statusCode == 200){
      return jsonDecode(response.body);
    }else return [];
  }

  Future getCenterPhoto(String centerAPI)async{
    String url = '${mainURL}getCenterPhoto.php';

    http.Response response = await http.post(url,body: {
      'CENTER_ID' : centerAPI
    });
    if(response.statusCode == 200){
      return jsonDecode(response.body);
    }return [];
  }

}