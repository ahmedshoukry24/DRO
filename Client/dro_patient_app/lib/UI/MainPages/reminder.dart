import 'package:dro_patient_app/Model/AlarmNotification.dart';
import 'package:dro_patient_app/UI/OtherPages/BookingSectionPages/ReminderDialogs.dart';
import 'package:dro_patient_app/UI/Parts/Custom/CustomDialog.dart';
import 'package:fleva_icons/fleva_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';

class Reminder extends StatefulWidget {

  final String _patientID;
  Reminder(this._patientID);

  @override
  _ReminderState createState() => _ReminderState();
}

class _ReminderState extends State<Reminder> {

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  AlarmNotification alarmNotification = AlarmNotification();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: <Widget>[
            Icon(Icons.alarm),
            SizedBox(width: 10,),
            Text('Reminder'),
          ],
        ),
        actions: [
          IconButton(
            onPressed: ()=>_setAlarm(context),
            icon: Icon(Icons.add),
          )
        ],
      ),
      body: FutureBuilder(
        future: flutterLocalNotificationsPlugin.pendingNotificationRequests(),
        builder: (context,ss){
          if(ss.hasError){
            print('Error');
          }
          if(ss.hasData){
            List<PendingNotificationRequest> appointments = ss.data;
            appointments.sort((a,b){
              return DateTime.parse(a.payload).compareTo(DateTime.parse(b.payload));
            });
            return ListView.builder(
                itemCount: appointments.length,
                itemBuilder: (context,position){
                  DateTime myDateTime = DateTime.parse(appointments[position].payload);
                  return DateTime.parse(appointments[position].payload).isAfter(DateTime.now())
                      ? GestureDetector(
                    onTap: (){
//                      DateFormat('HH:mm').parse(appointments[position].payload);
                    print(appointments[position].payload);

                    print(DateFormat('MMMMEEEEd').format(DateTime.parse(appointments[position].payload)));
                    },
                    onDoubleTap: ()async{
                        await flutterLocalNotificationsPlugin.cancel(appointments[position].id).then((value){
                          setState(() {
                          });
                        });
                    },
                    child: Card(
                      margin: EdgeInsets.all(MediaQuery.of(context).size.width*0.01),
                      child: ListTile(
                        title: Text(' ${appointments[position].title}'),
                        subtitle: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.width*0.01),
                              child: Text(' ${appointments[position].body}'),
                            ),
                            Container(
                              color: Colors.grey[50],
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.width*0.01),
                                child: RichText(
                                  overflow: TextOverflow.fade,
                                  text: TextSpan(
                                    children:[
                                      TextSpan(text: '${DateFormat('EEEE').format(myDateTime)}',
                                          style: TextStyle(color: Colors.blue[900],fontWeight: FontWeight.w500)),
                                      TextSpan(text: ', ',style: TextStyle(color: Colors.black)),
                                      TextSpan(text: '${DateFormat('MMMM d').format(myDateTime)}',
                                          style: TextStyle(color: Colors.blue[700])),

                                    ]
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        leading: Icon(Icons.notifications,color: Colors.grey[400],),
                        trailing: SizedBox(
                          width: MediaQuery.of(context).size.width*0.15,
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.width*0.01),
                                child: RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(text: '${DateFormat('jm').format(myDateTime)}',
                                          style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600)),
                                    ]
                                  ),
                                ),
                              ),
                              timeToDouble(TimeOfDay.fromDateTime(myDateTime)) < timeToDouble(TimeOfDay(hour: 17,minute: 00)) ?
                              Icon(Icons.wb_sunny,color: Colors.amber[100],) : Icon(Icons.brightness_2,color: Colors.grey[600],)
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                  : Container();
                });
          }else{
            return SpinKitRipple(color: Colors.blue[800],);
          }
        },
      )
    );
  }

  void _setAlarm(BuildContext context){
    showDialog(context: context,builder: (context){
      TextEditingController contentController = TextEditingController();
      TextEditingController titleController = TextEditingController();
      return MyCustomDialog(
        content: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text('Alarm',style: TextStyle(fontWeight: FontWeight.bold),),
            ),
            Padding(
              padding: const EdgeInsets.all(3.0),
              child: TextField(
                controller: titleController,
                cursorColor: Colors.blue[800],
                cursorWidth: 1.2,
                maxLines: 1,
                decoration: InputDecoration(
                    filled: true,
                    isDense: true,
                    fillColor: Colors.grey[200],
                    hintText: 'Title',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none
                    )
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(3.0),
              child: TextField(
                controller: contentController,
                cursorColor: Colors.blue[800],
                cursorWidth: 1.2,
                maxLines: 3,
                decoration: InputDecoration(
                    filled: true,
                    isDense: true,
                    fillColor: Colors.grey[200],
                    hintText: 'Content',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none
                    )
                ),
              ),
            ),
            FlatButton(
              child: Text('Select time'),
              onPressed: (){
                DateTime dateTime;
                showDatePicker(context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(Duration(days: 90))).then((dateFromDatePicker){
                  if(dateFromDatePicker != null){
                    showTimePicker(context: context,
                      initialTime: TimeOfDay.now(),).then((timeFromTimePicker){
                      if(timeFromTimePicker!= null){
                        Navigator.pop(context);
                        dateTime = DateTime(
                            dateFromDatePicker.year,
                            dateFromDatePicker.month,
                            dateFromDatePicker.day,
                            timeFromTimePicker.hour,
                            timeFromTimePicker.minute
                        );
                        ReminderDialogs().whenTimeSelected(
                            context: context,
                            title: titleController.text,
                            content: contentController.text,
                            dateTime: dateTime,
                            payload: '$dateTime'
                        );

                      }
                    });
                  }
                });
              },
            )
          ],
        ),
      );
    });
  }

  double timeToDouble(TimeOfDay time){
    return time.hour + time.minute/60;
  }


}
