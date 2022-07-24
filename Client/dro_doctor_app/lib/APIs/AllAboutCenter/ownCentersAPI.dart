import 'dart:convert';
import 'package:dro_doctor_app/APIs/mainURL/mainURL.dart';
import 'package:dro_doctor_app/Model/CenterModel.dart';
import 'package:http/http.dart' as http;

class OwnCentersAPI{

  Future<List<CenterModel>> centers(String doctorID) async{

    String url = '${mainURL}Center/ownCenter.php';

    http.Response response = await http.post(url,body: {
      'doctorID' : doctorID,
    });
    if(response.statusCode == 200){

      List jsonData = jsonDecode(response.body);
      List<CenterModel> centers = List<CenterModel>();

      if(jsonData.length == 0){
        return centers = [];
      }else{
        for(var i in jsonData){
          CenterModel centerModel = CenterModel(
            centerName: i['NAME'],
            address: i['ADDRESS'],
            specialty: i['SPECIALITY'],
            centerID: i['CENTER_ID'],
            centerKey: i['CENTER_KEY'],
            centerPhone: i['CENTER_PHONE'],
            docAdmin: i['DOC_ADMIN'],
            fee: i['FEE'],
            centerPhoto: i['CENTER_PHOTO'],
          );
          centers.add(centerModel);
        }
        return centers;
      }

    }else{
      List<CenterModel> centers = [];
      return centers;
    }
  }
}