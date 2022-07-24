import 'dart:convert';
import 'package:dro_patient_app/APIs/URL/mainURL.dart';
import 'package:dro_patient_app/Model/OffersModel.dart';
import 'package:http/http.dart' as http;

class OffersAPI{

  Future<List<OffersModel>> getOffers() async{

    String url = '${mainURL}getOffers.php';
    List<OffersModel> offers = List<OffersModel>();

    http.Response response = await http.get(url);
    if(response.statusCode == 200){
      List jsonData = jsonDecode(response.body);
      jsonData.forEach((element) {
        offers.add(OffersModel(
          clinicID: element['CLINIC_ID'],
          centerID: element['CENTER_ID'],
          content: "${element['CONTENT']}",
          figureName: element['FIGURE_NAME'],
          centerAddress: element['CENTER_ADDRESS'],
          clinicAddress: element['CLINIC_ADDRESS'],
          dateTime: element['DATE_TIME'],
        ));
      });
    }
    return offers;
  }

}