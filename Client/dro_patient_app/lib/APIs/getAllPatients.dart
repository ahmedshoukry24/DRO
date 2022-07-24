import 'dart:convert';

import 'package:http/http.dart' as http;
import '../Model/patient.dart';

import 'URL/mainURL.dart';

class GetPatients{
  Future<List<Patient>> getPatients() async {
    String url = '${mainURL}getPatients.php';
    http.Response response = await http.get(url);

    var jsonData =jsonDecode(response.body);

    print(jsonData);
    return jsonData;
}
}