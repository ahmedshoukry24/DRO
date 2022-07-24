import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';


class AlarmNotification{

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  Future initialization()async{
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    var android = AndroidInitializationSettings('@mipmap/ic_launcher');
    var ios = IOSInitializationSettings();
    var initSettings = InitializationSettings(android, ios);
    // ignore: missing_return
    flutterLocalNotificationsPlugin.initialize(initSettings,onSelectNotification: (String payload){
      print(payload);
    });
  }

  void showNotification(int id, String title, String body,DateTime scheduledDate, String payload)async{
    var android = AndroidNotificationDetails(
      'channel ID',
      'channel Name',
      'channel Description',
      priority: Priority.Max,
      importance: Importance.Max,
      styleInformation: BigTextStyleInformation(''),
      channelShowBadge: true,
      color: Colors.blue[800],
    );
    var ios = IOSNotificationDetails();
    var platform = NotificationDetails(android,ios);
    await flutterLocalNotificationsPlugin.schedule(
        id,
        title,
        body,
        scheduledDate,
        platform,
        payload: '$payload');
  }
}

