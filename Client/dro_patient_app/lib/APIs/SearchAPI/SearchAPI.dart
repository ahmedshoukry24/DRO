import 'dart:convert';

import 'package:dro_patient_app/APIs/URL/mainURL.dart';
import 'package:http/http.dart'as http;
class SearchAPI{

  Future getSearchResult(String query)async{
    String url = '${mainURL}Search/search.php';
    try{
      http.Response response = await http.post(url,body: {
        'query':query
      });
      if(response.statusCode == 200){
        return jsonDecode(response.body);
      }else return [];
    }catch(e){
      return [];
    }
  }

  Future getDoctorByName(String txt)async{
    String url = '${mainURL}Search/searchByName.php';
    http.Response response = await http.post(url,body: {
      "txt" : txt
    });

    if(response.statusCode == 200){
      return jsonDecode(response.body);
    }return [];

  }

}