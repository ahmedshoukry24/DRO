import 'dart:convert';

import 'package:http/http.dart' as http;
import '../URL/mainURL.dart';

class AnswerAPI{
  Future getAnswer(String quesNum) async{
    String url = '${mainURL}QuestionSection/getAnswer.php';

    http.Response response = await http.post(url,body: {
      'QUESTION_NUM' : quesNum,
    });

    if(response.statusCode == 200){
      return jsonDecode(response.body);
    }else return [];

  }
}