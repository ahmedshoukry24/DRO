import 'dart:convert';
import 'package:http/http.dart' as http;

import 'mainURL/mainURL.dart';

class QuestionsAPI{

  Future getQuestions({String specialty}) async{
    String url = '${mainURL}questions/showQuestions.php';
    http.Response response = await http.post(url,body: {
      'SPECIALITY' : specialty,
    });

    if(response.statusCode == 200){
      return jsonDecode(response.body);
    }else return [];
  }

  Future<bool> postAnswer({String questionNum,String doctorID,String answer}) async{
    String url = '${mainURL}questions/postAnswer.php';
    http.Response response = await http.post(url,body: {
      'QUESTION_NUM' : questionNum,
      'DOCTOR_ID' : doctorID,
      'ANSWER' : answer,
      'DATE' : '${DateTime.now()}'
    });

    if(response.statusCode == 200){
      return jsonDecode(response.body);
    }else return false;
  }

}