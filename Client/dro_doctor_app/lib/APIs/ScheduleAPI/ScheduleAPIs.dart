import 'dart:convert';

import 'package:dro_doctor_app/APIs/mainURL/mainURL.dart';
import 'package:http/http.dart' as http;

class ScheduleAPIs{
  Future setClinicOrCenterSchedule(
      {String clinicID,String sat1,String sat2,String sun1,String sun2,
        String mon1,String mon2,String tue1,String tue2,
        String wed1,String wed2,String thu1,String thu2,
        String fri1,String fri2,String centerID}) async{

    String url = '${mainURL}Schedule/setSchedule.php';

    http.post(url,body: {
      'CLINIC_ID' : clinicID,
      'SAT_START' : sat1,
      'SAT_END' : sat2,
      'SUN_START':sun1,
      'SUN_END' : sun2,
      'MON_START' : mon1,
      'MON_END' : mon2,
      'TUES_START' : tue1,
      'TUES_END' : tue2,
      'WED_START' : wed1,
      'WED_END' : wed2,
      'THU_START': thu1,
      'THU_END' : thu2,
      'FRI_START': fri1,
      'FRI_END' : fri2,
      'CENTER_ID' : centerID,
    });
  }

  Future getClinicSchedule(String clinicID,String centerID) async{
    String url = '${mainURL}Schedule/getSchedule.php';

    http.Response response = await http.post(url,body: {
      'CLINIC_ID' : clinicID,
      'CENTER_ID' :centerID
    });
    if(response.statusCode == 200){
      return jsonDecode(response.body);
    } else{
      return null;
    }
  }

}