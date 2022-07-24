import 'package:dro_doctor_app/APIs/ScheduleAPI/ScheduleAPIs.dart';
import 'package:flutter/material.dart';

import '../../Home.dart';



class SetSchedulePage extends StatefulWidget{

  final String clinicID,doctorID,centerID;
  SetSchedulePage(this.clinicID,this.doctorID,this.centerID);

  @override
  _SetSchedulePageState createState() => _SetSchedulePageState();
}

class _SetSchedulePageState extends State<SetSchedulePage> {


  TimeOfDay sat1,sat2; // 1/2
  TimeOfDay sun1,sun2; // 3/4
  TimeOfDay mon1,mon2; // 5/6
  TimeOfDay tue1,tue2; // 7/8
  TimeOfDay wed1,wed2; // 9/10
  TimeOfDay thu1,thu2; // 11/12
  TimeOfDay fri1,fri2; // 13/14

  ScheduleAPIs setScheduleAPI = ScheduleAPIs();
  String message = 'Check time sequence';

  final scaffoldKey = GlobalKey<ScaffoldState>();
  TextStyle textStyle2 = TextStyle(color: Colors.blue);
  TextStyle textStyle = TextStyle(color: Colors.grey);

  double toDouble(TimeOfDay time)=>time.hour + time.minute/60.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: body(),
    );
  }

  Widget body(){
    return NotificationListener<OverscrollIndicatorNotification>(
      // ignore: missing_return
      onNotification: (OverscrollIndicatorNotification overScroll){
        overScroll.disallowGlow();
      },
      child: ListView(
        children: <Widget>[
          DataTable(
            columns: [
              DataColumn(label: Text('Day',style: textStyle2,)),
              DataColumn(label: Text('From:',style: textStyle2)),
              DataColumn(label: Text('To:',style: textStyle2)),
              DataColumn(label: Text('Cancel',style: textStyle2)),
            ],
            rows: [
              DataRow(
                  cells: [
                    DataCell(Text('Saturday')),
                    DataCell(timePickerFunction(time: sat1,x: 1)),
                    DataCell(timePickerFunction(time: sat2,x: 2)),
                    DataCell(GestureDetector(child: Icon(Icons.remove),onTap: (){setState(() {
                      sat1 = null;
                      sat2 = null;
                    });},)),
                  ]
              ),
              DataRow(
                  cells: [
                    DataCell(Text('Sunday')),
                    DataCell(timePickerFunction(time: sun1,x: 3)),
                    DataCell(timePickerFunction(time: sun2,x: 4)),
                    DataCell(GestureDetector(child: Icon(Icons.remove),onTap: (){setState(() {
                      sun1 = null;
                      sun2 = null;
                    });},)),
                  ]
              ),
              DataRow(
                  cells: [
                    DataCell(Text('Monday')),
                    DataCell(timePickerFunction(time: mon1,x: 5)),
                    DataCell(timePickerFunction(time: mon2,x: 6)),
                    DataCell(GestureDetector(child: Icon(Icons.remove),onTap: (){setState(() {
                      mon1 = null;
                      mon2 = null;
                    });},)),
                  ]
              ),
              DataRow(
                  cells: [
                    DataCell(Text('Tuesday')),
                    DataCell(timePickerFunction(time: tue1,x: 7)),
                    DataCell(timePickerFunction(time: tue2,x: 8)),
                    DataCell(GestureDetector(child: Icon(Icons.remove),onTap: (){setState(() {
                      tue1 = null;
                      tue2 = null;
                    });},)),
                  ]
              ),
              DataRow(
                  cells: [
                    DataCell(Text('Wednesday')),
                    DataCell(timePickerFunction(time: wed1,x: 9)),
                    DataCell(timePickerFunction(time: wed2,x: 10)),
                    DataCell(GestureDetector(child: Icon(Icons.remove),onTap: (){setState(() {
                      wed1 = null;
                      wed2 = null;
                    });},)),
                  ]
              ),
              DataRow(
                  cells: [
                    DataCell(Text('Thursday')),
                    DataCell(timePickerFunction(time: thu1,x: 11)),
                    DataCell(timePickerFunction(time: thu2,x: 12)),
                    DataCell(GestureDetector(child: Icon(Icons.remove),onTap: (){setState(() {
                      thu1 = null;
                      thu2 = null;
                    });},)),
                  ]
              ),
              DataRow(
                  cells: [
                    DataCell(Text('Friday')),
                    DataCell(timePickerFunction(time: fri1,x: 13)),
                    DataCell(timePickerFunction(time: fri2,x: 14)),
                    DataCell(GestureDetector(child: Icon(Icons.remove),onTap: (){setState(() {
                      fri1 = null;
                      fri2 = null;
                    });},)),
                  ]
              ),
            ],
          ),

          // ** buttons
          FlatButton(
            child: Text('Save'),
            onPressed: ()=>_createBtn(),
          ),

          // ** hint
          Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  sat1 == null ? Container() : Text('Saturday : ${sat1.format(context)} - ',style: textStyle,),
                  sat2 == null ? Container() : Text('${sat2.format(context)}' , style: textStyle,),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  sun1 == null ? Container() : Text('Sunday : ${sun1.format(context)} - ',style: textStyle,),
                  sun2 == null ? Container() : Text('${sun2.format(context)}' , style: textStyle,),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  mon1 == null ? Container() : Text('Monday : ${mon1.format(context)} - ',style: textStyle,),
                  mon2 == null ? Container() : Text('${mon2.format(context)}' , style: textStyle,),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  tue1 == null ? Container() : Text('Tuesday : ${tue1.format(context)} - ',style: textStyle,),
                  tue2 == null ? Container() : Text('${tue2.format(context)}' , style: textStyle,),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  wed1 == null ? Container() : Text('Wednesday : ${wed1.format(context)} - ',style: textStyle,),
                  wed2 == null ? Container() : Text('${wed2.format(context)}' , style: textStyle,),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  thu1 == null ? Container() : Text('Thursday : ${thu1.format(context)} - ',style: textStyle,),
                  thu2 == null ? Container() : Text('${thu2.format(context)}' , style: textStyle,),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  fri1 == null ? Container() : Text('Friday : ${fri1.format(context)} - ',style: textStyle,),
                  fri2 == null ? Container() : Text('${fri2.format(context)}' , style: textStyle,),
                ],
              ),
            ],
          )

        ],
      ),
    );
  }

  _createBtn(){
  if(sat1 == null && sat2 == null && sun1 == null && sun2 == null &&
  mon1 == null && mon2 == null && tue1 == null && tue2 == null &&
  wed1 == null && wed2 == null && thu1 == null && thu2 == null &&
  fri1 == null && fri2 == null){
    // No action
  }else{
    // --- if some data == null .. then I send (--) to database to help me after to know the type of data I receive from database --
    // --- in getSchedulePage
    setScheduleAPI.setClinicOrCenterSchedule(
    clinicID: widget.clinicID,
    centerID: widget.centerID,
    sat1: sat1 != null ? sat1.format(context) : '--',
    sat2: sat2 != null ? sat2.format(context) : '--',
    sun1: sun1 != null ? sun1.format(context) : '--',
    sun2: sun2 != null ? sun2.format(context) : '--',
    mon1: mon1 != null ? mon1.format(context) : '--',
    mon2: mon2 != null ? mon2.format(context) : '--',
    tue1: tue1 != null ? tue1.format(context) : '--',
    tue2: tue2 != null ? tue2.format(context) : '--',
    wed1: wed1 != null ? wed1.format(context) : '--',
    wed2: wed2 != null ? wed2.format(context) : '--',
    thu1: thu1 != null ? thu1.format(context) : '--',
    thu2: thu2 != null ? thu2.format(context) : '--',
    fri1: fri1 != null ? fri1.format(context) : '--',
    fri2: fri2 != null ? fri2.format(context) : '--');
   Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>
       Home(widget.doctorID,0)), (Route<dynamic>route) => false);
  }

  }

  Widget timePickerFunction({TimeOfDay time,int x}){
    return GestureDetector(
      child: Text(time != null ? '${time.format(context)}' : '00:00 AM',style:time != null ? textStyle2: textStyle,),
      onTap: () {
        DateTime now = DateTime.now();
        showTimePicker(
          context: context,
          initialTime: TimeOfDay(hour: now.hour, minute: now.minute),
        ).then((TimeOfDay value){
          if (value != null) {
            switch(x){
              case 1:
                setState(() {
                  sat1 = value;
                });
                break;
              case 2:
                if(toDouble(sat1) < toDouble(value)){
                  setState(() {
                    sat2 = value;
                  });
                }else{
                  scaffoldKey.currentState.showSnackBar(
                    SnackBar(backgroundColor: Colors.red, content: Text('$message'),
                    ),
                  );
                }
                break;
              case 3:
                setState(() {
                  sun1 = value;
                });
                break;
              case 4:
                if(toDouble(sun1) < toDouble(value)){
                  setState(() {
                    sun2 = value;
                  });
                }else{
                  scaffoldKey.currentState.showSnackBar(
                    SnackBar(backgroundColor: Colors.red, content: Text('$message'),
                    ),
                  );
                }
                break;
              case 5:
                setState(() {
                  mon1 = value;
                });
                break;
              case 6:
                if(toDouble(mon1) < toDouble(value)){
                  setState(() {
                    mon2 = value;
                  });
                }else{
                  scaffoldKey.currentState.showSnackBar(
                    SnackBar(backgroundColor: Colors.red,content: Text('$message'),
                    ),
                  );
                }
                break;
              case 7:
                setState(() {
                  tue1 = value;
                });
                break;
              case 8:
                if(toDouble(tue1) < toDouble(value)){
                  setState(() {
                    tue2 = value;
                  });
                }else{
                  scaffoldKey.currentState.showSnackBar(
                      SnackBar(
                        backgroundColor: Colors.red,
                        content: Text('$message'),
                      )
                  );
                }
                break;
              case 9:
                setState(() {
                  wed1 = value;
                });
                break;
              case 10:
                if(toDouble(wed1) < toDouble(value)){
                  setState(() {
                    wed2 = value;
                  });
                }else{
                  scaffoldKey.currentState.showSnackBar(
                      SnackBar(
                        backgroundColor: Colors.red,
                        content: Text('$message'),
                      )
                  );
                }
                break;
              case 11:
                setState(() {
                  thu1 = value;
                });
                break;
              case 12:
                if(toDouble(thu1) < toDouble(value)){
                  setState(() {
                    thu2 = value;
                  });
                }else{
                  scaffoldKey.currentState.showSnackBar(
                      SnackBar(
                        backgroundColor: Colors.red,
                        content: Text('$message'),
                      )
                  );
                }
                break;
              case 13:
                setState(() {
                  fri1 = value;
                  print("Fri 1 is equal ${fri1.format(context)}");
                });
                break;
              case 14:
                if(toDouble(fri1) < toDouble(value)){
                  setState(() {
                    fri2 = value;
                    print("Fri 2 is equal ${fri2.format(context)}");
                  });
                }else{
                  scaffoldKey.currentState.showSnackBar(
                      SnackBar(
                        backgroundColor: Colors.red,
                        content: Text('$message'),
                      )
                  );
                }
                break;
              default:
                break;
            }
          }
        });
      },
    );
  }
}