import 'dart:math';
import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:dro_patient_app/APIs/Notifications/ReceiveNotificationAPI.dart';
import 'package:dro_patient_app/APIs/Reviews_Rating/ReviewsAPI.dart';
import 'package:dro_patient_app/Model/AlarmNotification.dart';
import 'package:dro_patient_app/Model/Review.dart';
import 'package:flutter/material.dart';
import 'UI/StartPage.dart';
import 'OfflineDatabase/helper.dart';
import 'OfflineDatabase/model.dart';
import 'UI/LoginPage.dart';
main()async{
  runApp(MyApp());
  await AndroidAlarmManager.initialize();
  await AndroidAlarmManager.periodic(Duration(minutes: 1), Random().nextInt(1000),awakeFun);
}
void awakeFun()async{
  DatabaseHelper db = DatabaseHelper();
  var myUser = await db.getUser();
  if(myUser.id != null){
    pushNotification(myUser.id);
  }
}

void pushNotification(String patientID)async{
  List notification = await ReceiveNotificationAPI().getNotification(patientID:patientID);
  if(notification.length !=0 ){
    for(var i in notification){
      AlarmNotification alarmNotification = AlarmNotification();
      alarmNotification.initialization();
      Random random = Random();
      alarmNotification.showNotification(
          random.nextInt(1000),
          '${i['TITLE']}',
          '${i['BODY']}',
          DateTime.now(),
          '${DateTime.now()}',
      );
      ReceiveNotificationAPI().updateNotification(alarmID: i['ALARM_ID']);
    }
  }
}

class MyApp extends StatelessWidget {

  static DatabaseHelper db = DatabaseHelper();

  @override
  Widget build(BuildContext context) {

    return  MaterialApp(
      title: 'Doctor Reservation Online',
      color: Colors.white,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: TextTheme(
          body1: TextStyle(
              fontSize: 15.0,
          ),
        ),
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        primaryColor: Colors.blue[800],
        accentColor: Colors.blue[800],
        appBarTheme: AppBarTheme(
            color: Colors.white,
            elevation: 0.8,
            textTheme: TextTheme(
              title: TextStyle(color: Colors.blue[800],fontSize: 20.0),
            ),
            iconTheme: IconThemeData(
                color: Colors.blue[800]
            ),
        ),
        buttonTheme: ButtonThemeData(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            buttonColor: Colors.white,
            textTheme: ButtonTextTheme.accent,
            shape: OutlineInputBorder(borderRadius: BorderRadius.circular(15),borderSide: BorderSide.none)
        ),
      ),
      home: FutureBuilder(
        future: db.getUser(),
        builder: (context,ss){
          if(ss.hasError){
            print('Error');
          }if(ss.hasData){
            OfflinePatient offlinePatient = ss.data;
            if(offlinePatient.status != '1'){
              return LoginPage();
            }else{
            return StartPage(offlinePatient.id,);
            }
          }else{
            return Material(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text('DRO',style: TextStyle(fontSize: 50,fontWeight: FontWeight.w800)),
                      Text('Doctor Reservation Online.',style: TextStyle(fontSize: 20),),
                      Text('Patient version.')
                    ],
                  ),
                ));
          }
        },
      ),
    );
  }
}