import 'package:dro_doctor_app/APIs/ScheduleAPI/ScheduleAPIs.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/material.dart';


class GetSchedule extends StatelessWidget {

  final String clinicID,doctorID,centerID;
  GetSchedule(this.clinicID,this.doctorID,this.centerID);

  static ScheduleAPIs scheduleAPIs = ScheduleAPIs();


  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: scheduleAPIs.getClinicSchedule(clinicID,centerID),
      builder: (BuildContext context, AsyncSnapshot ss){
        if(ss.hasError){
          print('in get Schedule :: futurebuilder :: hasError');
        }
        if(ss.hasData){
          return body(clinicTimes: ss.data);
        }else{
          return SpinKitRipple(color: Colors.blue[800],);
        }
      },
    );
  }


  Widget body({List clinicTimes}){
    if (clinicTimes.isNotEmpty) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Table(
          border: TableBorder.all(color: Colors.grey),
          children: [
            TableRow(
              children:[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Day'),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('From:'),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('To:'),
                ),
              ]
            ),
            _myRow(clinicTimes, 'Saturday', 'SAT_START', 'SAT_END'),
            _myRow(clinicTimes, 'Sunday', 'SUN_START', 'SUN_END'),
            _myRow(clinicTimes, 'Monday', 'MON_START', 'MON_END'),
            _myRow(clinicTimes, 'Tuesday', 'TUES_START', 'TUES_END'),
            _myRow(clinicTimes, 'Wednesday', 'WED_START', 'WED_END'),
            _myRow(clinicTimes, 'Thursday', 'THU_START', 'THU_END'),
            _myRow(clinicTimes, 'Friday', 'FRI_START', 'FRI_END'),
          ],
        ),
      );
    } else {
      return Container(child: Center(child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text('No Times Selected yet!'),
      ),),);
    }
  }

  TableRow _myRow(List clinicTimes,String day,String start,String end){
    return clinicTimes[0]['$start'] == '--' || clinicTimes[0]['$end'] == '--' ?TableRow(
        children:[
          Container(),
          Container(),
          Container(),
        ]
    )
        : TableRow(
        children:[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('$day'),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('${clinicTimes[0]['$start']}'),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('${clinicTimes[0]['$end']}'),
          ),
        ]
    );
  }



}
