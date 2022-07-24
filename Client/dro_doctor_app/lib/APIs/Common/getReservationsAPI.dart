import 'dart:convert';

import 'package:dro_doctor_app/APIs/mainURL/mainURL.dart';
import 'package:dro_doctor_app/Model/reservation.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class ReservationsAPI{

  Future getReservations(String clinicID,String centerID)async{
    String url = '${mainURL}common/getReservations.php';
    List<Reservation> reservations = [];

    http.Response response = await http.post(url,body: {
      'CLINIC_ID' : clinicID,
      'CENTER_ID' : centerID
    });


    if(response.statusCode == 200){
      for(var i in jsonDecode(response.body)){
        DateTime curDate = DateFormat('yyy-M-d HH:mm:ss').parse("${i['DATE']} ${i['TIME']}");
        reservations.add(Reservation(
            img: i['PROFILE_PICTURE'],
            phone: i['PHONE'],
          firstName: i['FIRST_NAME'],
          lastName: i['LAST_NAME'],
          gender: i['GENDER'],
          date: curDate,
          patientID: i['PATIENT_ID'],
          clinicID: i['CLINIC_ID'],
          centerID: i['CENTER_ID'],
          channelID: i['CHANNEL_ID'],
        ));
      }

      return reservations;
    }else{
      return reservations;
    }
  }

}