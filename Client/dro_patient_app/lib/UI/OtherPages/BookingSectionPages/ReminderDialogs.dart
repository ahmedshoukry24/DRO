import 'dart:math';
import 'package:dro_patient_app/Model/AlarmNotification.dart';
import 'package:dro_patient_app/UI/Parts/Custom/CustomDialog.dart';
import 'package:fleva_icons/fleva_icons.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ReminderDialogs{

  static AlarmNotification alarmNotification = AlarmNotification();

  void doneDialog(BuildContext context,DateTime date,TimeOfDay time){
    DateTime dateTime = DateTime(date.year,date.month,date.day,time.hour,time.minute);
    showDialog(
        barrierDismissible: false,
        context: context,builder: (context){
      return MyCustomDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              children: <Widget>[
                Icon(FlevaIcons.done_all),
                Text('  Done.'),
              ],
            ),
            Text('Your Appointment',style: TextStyle(fontWeight: FontWeight.w900),),
            SizedBox(height: 10,),
            Text('${DateFormat('MMMMEEEEd').format(dateTime)}'),
            Text('${TimeOfDay.fromDateTime(dateTime).format(context)}'),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(3.0),
            child: RaisedButton(
              child: Text('Remind me!'),
              color: Colors.blue[800],
              textColor: Colors.white,
              shape: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                ),
              ),
              onPressed: ()=>_sureFun(context),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(3.0),
            child: RaisedButton(
              child: Text('Done'),
              color:Colors.white,
              shape: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  )
              ),
              onPressed: (){
                Navigator.pop(context);
              },
            ),
          ),
        ],
      );
    });
  }
  void _sureFun(BuildContext context){
    showDialog(context: context,builder: (context){
      TextEditingController contentController = TextEditingController();
      return MyCustomDialog(
        content: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text('Appointment notification.',style: TextStyle(fontWeight: FontWeight.bold),),
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
                        Navigator.pop(context);
                        Navigator.pop(context);
                        dateTime = DateTime(
                            dateFromDatePicker.year,
                            dateFromDatePicker.month,
                            dateFromDatePicker.day,
                            timeFromTimePicker.hour,
                            timeFromTimePicker.minute
                        );
                        whenTimeSelected(
                            context: context,
                            title: 'Appointment reminder.',
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
  void whenTimeSelected({String title,String content, DateTime dateTime, String payload, BuildContext context}){
    Random random = Random();
    alarmNotification.initialization();
    int id = random.nextInt(1000000);
    alarmNotification.showNotification(
        id,
        '${title != '' ? title : 'reminder'}',
        '${content != '' ? content : 'empty content'}',
        dateTime,
      '$payload',
    );

  }

}