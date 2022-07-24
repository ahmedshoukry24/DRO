import 'dart:convert';
import 'package:http/http.dart' as http;
import '../URL/mainURL.dart';


class FavoriteAPI{

  // ** All about adding and removing from favorite
  Future addToFavorite({String clinicID,String patientID,String centerID})async{

    String url = '${mainURL}Favorite_section/addToFavorite.php';

    http.post(url,body: {
      'PATIENT_ID' : patientID,
      'CLINIC_ID' : clinicID,
      'CENTER_ID' : centerID,
    });
  }

  Future removeFromFavorite({String patientID,String clinicID,String centerID}) async{
    String url = '${mainURL}Favorite_section/removeFromFavorite.php';
    http.post(url,body: {
      'PATIENT_ID': patientID,
      'CLINIC_ID' : clinicID,
      'CENTER_ID' : centerID,
    });
  }

  Future<bool> isFavorite({String patientID,String clinicID, String centerID}) async{
    String url = "${mainURL}Favorite_section/isFavorite.php";

    http.Response response = await http.post(url,body: {
      "PATIENT_ID":patientID,
      'CLINIC_ID' :clinicID,
      'CENTER_ID' : centerID,
    });

    if(response.statusCode == 200){
      List jsonData = jsonDecode(response.body);
      if(jsonData.length > 0){
        return true;
      }else{
        return false;
      }
    }else{
      return false;
    }

  }


  // ** All about showing favorite items in favorite page
  Future<List> getMyFavoriteItems(String patientID)async{
    String url = '${mainURL}Favorite_section/getMyFavoriteItems.php';

    List jsonData = [];

    http.Response response = await http.post(url,body: {
      'PATIENT_ID': patientID,
    });

    if(response.statusCode == 200){
      jsonData = jsonDecode(response.body);

      return jsonData;
    }else{
      return jsonData;
    }
  }

}