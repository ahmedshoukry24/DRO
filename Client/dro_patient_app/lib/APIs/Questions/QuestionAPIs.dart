import 'dart:convert';

import 'package:http/http.dart' as http;
import '../URL/mainURL.dart';

class QuestionsAPI{
  Future postQuestion({String patientID,String specialty, String question}) async{
    String url = '${mainURL}QuestionSection/postQuestion.php';
    http.Response response = await http.post(url,body: {
      "PATIENT_ID" : patientID,
      'SPECIALITY' : specialty == 'General' ? '--' : specialty,
      'QUESTION' : question,
      'DATE' : '${DateTime.now()}'
    });
    if(response.statusCode == 200){
      return jsonDecode(response.body);
    }else return false;
  }

  Future getQuestions(String specialty)async{
    if(specialty != 'General'){
      String url = '${mainURL}QuestionSection/getQuestions.php';
      http.Response response = await http.post(url,body: {
        'SPECIALITY' : specialty,
      });
      if(response.statusCode == 200){
        return jsonDecode(response.body);
      }else return [];
    }else{
      String url = '${mainURL}QuestionSection/getAllQuestions.php';
      http.Response response = await http.get(url);
      if(response.statusCode == 200){
        return jsonDecode(response.body);
      }else return [];
    }

  }

}