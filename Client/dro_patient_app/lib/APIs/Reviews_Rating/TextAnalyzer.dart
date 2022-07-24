import 'dart:convert';

import 'package:dro_patient_app/APIs/URL/mainURL.dart';
import 'package:http/http.dart' as http;

class TextAnalyzer{

  Future getAnalyzedText(String text)async{
    http.Response response = await http.post(pythonURL,body: {
      'text':text,
    });
    if(response.statusCode == 200){
      return jsonDecode(response.body);
    }else return {'happy': 1, 'sad': 0};
  }

}