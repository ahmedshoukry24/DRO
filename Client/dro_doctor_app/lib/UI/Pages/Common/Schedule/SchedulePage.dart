import 'package:dro_doctor_app/UI/Pages/Common/Schedule/setSchedulePage.dart';

import 'getSchedulePage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SchedulePage extends StatelessWidget {
  final String clinicID,doctorID,centerID;
  SchedulePage(this.clinicID,this.doctorID,this.centerID);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('See & Edit Schedule'),
      ),
      body: Center(
        child: ListView(
          children: <Widget>[
            GetSchedule(clinicID,doctorID,centerID),
            RaisedButton(
              child: Text('Set Schedule'),
              onPressed: (){
                Navigator.push(context,
                    CupertinoPageRoute(builder: (context)=>SetSchedulePage(clinicID,doctorID,centerID)));
              },
            ),
          ],
        ),
      ),
    );
  }
}
