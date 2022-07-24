import 'dart:convert';
import 'package:dro_patient_app/Model/Review.dart';
import 'package:http/http.dart' as http;
import '../URL/mainURL.dart';

class ReviewsAPI{

  // center and clinic
  Future<List<ReviewModel>> getReview({String clinicID,String centerID}) async{
    String url = '${mainURL}clinicReview/getReview.php';
    List<ReviewModel> reviews =[];

    http.Response response = await http.post(url,body: {
      'clinic_id' : clinicID,
      'center_id' : centerID,
    });

    if(response.statusCode == 200){
//      print(jsonDecode(response.body));
      List jsonData = jsonDecode(response.body);
      jsonData.forEach((i) {
        reviews.add(ReviewModel(
          firstName:i['FIRST_NAME'],
          lastName: i['LAST_NAME'],
          clinicID: i['CK_ID1']!='null' ? i['CK_ID1'] : i['CK_ID2'],
          centerID: i['CR_ID1']!='null' ? i['CR_ID1'] : i['CR_ID2'],
          dateTime: i['date_time'],
          patientID:i['P_ID1'] != 'null' ? i['P_ID1'] : i['P_ID2'],
          rate:     "${i['rate']}" == 'null'? '0' : "${i['rate']}",
          review:   i['review'],
          profilePicture : i['PROFILE_PICTURE'],
          status: i['STATUS']
        ));
      });
      return reviews;
    }else{
      return reviews;
    }


  }

  // center and clinic
  Future setReview({String clinicId,String patientID,String review,String status,String centerID})async{
    String url = '${mainURL}clinicReview/setReview.php';

    http.Response response = await http.post(url,body: {
      'patient_id' : patientID,
      'clinic_id' : clinicId,
      'center_id': centerID,
      'review' : """$review""",
      'STATUS': status,
      'date_time' : '${DateTime.now()}',
    });
    if(response.statusCode == 200){
      return jsonDecode(response.body);
    }else{
      return [];
    }

  }

  // center and clinic
  Future setRate({String clinicID,String patientID,int rate,String centerID})async{
    String url = '${mainURL}clinicReview/setRate.php';
    http.post(url,body: {
      'clinic_id' : clinicID,
      'center_id': centerID,
      'patient_id' : patientID,
      'rate' : '$rate',
    });
  }

  // center and clinic
  Future getTotalRate(String clinicID,String centerID)async{
    String url = '${mainURL}clinicReview/getTotalRate.php';

    http.Response response = await http.post(url,body: {
      'clinic_id' : clinicID,
      'center_id': centerID
    });

    if(response.statusCode == 200){
      return jsonDecode(response.body);
    }else return [];

  }

}