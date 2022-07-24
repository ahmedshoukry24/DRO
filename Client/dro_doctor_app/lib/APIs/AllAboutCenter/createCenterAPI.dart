import 'dart:convert';

import 'package:dro_doctor_app/APIs/mainURL/mainURL.dart';
import 'package:dro_doctor_app/Model/CenterModel.dart';
import 'package:http/http.dart' as http;

class CreateCenterAPI{

  Future<CenterModel> createCenterAPI(
      String doctorID,String speciality,String centerName,
      String centerPhone,String address,String fee,String centerKey) async {

    String url = '${mainURL}Center/CreateCenter.php';
    CenterModel centerModel;

    http.Response response = await http.post(url,body: {
      'DOC_ADMIN':doctorID,
      'SPECIALITY' : speciality,
      'NAME' : centerName,
      'CENTER_PHONE' : centerPhone,
      'ADDRESS': address,
      'FEE' : fee,
      'CENTER_KEY' : centerKey,
    });

    if(response.statusCode == 200){

      bool result = jsonDecode(response.body);

      if(result){
        centerModel = await getCenter(centerKey);
        if(centerModel.centerID !='0'){
          return centerModel;
        }else return CenterModel(centerKey: '0',docAdmin: '0',centerID: '0');
      }else return CenterModel(centerKey: '0',docAdmin: '0',centerID: '0');
    }else return CenterModel(centerKey: '0',docAdmin: '0',centerID: '0');

  }

  Future<CenterModel> getCenter(String centerKey)async{
    String url = '${mainURL}Center/getCenter.php';
    http.Response response = await http.post(url,body: {
      'CENTER_KEY' : centerKey
    });

    if(response.statusCode == 200){
      List jsonData = jsonDecode(response.body);
      return CenterModel(
        centerID: jsonData[0]['CENTER_ID'],
        docAdmin: jsonData[0]['DOC_ADMIN'],
        centerName: jsonData[0]['NAME'],
        centerPhone: jsonData[0]['CENTER_PHONE'],
        specialty: jsonData[0]['SPECIALITY'],
        address: jsonData[0]['ADDRESS'],
        centerKey: jsonData[0]['CENTER_KEY'],
        fee: jsonData[0]['FEE'],
      );
    }else return CenterModel(centerID: '0',docAdmin: '0',centerKey: '0');

  }

}

