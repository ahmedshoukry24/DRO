import 'dart:convert';

import 'package:dro_patient_app/APIs/common/AppointmentsAPI.dart';
import 'package:dro_patient_app/UI/Parts/Custom/MyPageRoute.dart';
import 'package:dro_patient_app/UI/Parts/Loader.dart';
import 'package:dro_patient_app/VideoCall/pages/call.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:http/http.dart' as http;


class Appointments extends StatefulWidget {

  final String _patientID;
  Appointments(this._patientID);

  @override
  _AppointmentsState createState() => _AppointmentsState();
}

class _AppointmentsState extends State<Appointments> {


  AppointmentsAPI appointmentAPI;

  @override
  void initState() {
    super.initState();
    appointmentAPI = AppointmentsAPI();
    appointmentAPI.getAppointmentsAPI(widget._patientID);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: <Widget>[
            Icon(Icons.av_timer),
            SizedBox(width: 10,),
            Text('Appointments'),
          ],
        ),
      ),
      body: FutureBuilder(
        future: appointmentAPI.getAppointmentsAPI(widget._patientID),
        builder: (BuildContext context,AsyncSnapshot ss){
          if(ss.hasError){
            print('Error');
          }
          if(ss.hasData){
            List res = ss.data;
            res.sort((a,b)=>a.dateTime.compareTo(b.dateTime));
            return ListView.builder(
                itemCount: res.length,
                itemBuilder: (context,position){
                return Card(
                  child:  DateTime.now().isAfter(res[position].dateTime) ? Container() : Row(
                  children: [
                    Expanded(
                      child:res[position],
                    ),
                    rightSide(
                      channelID: res[position].channelID,
                      dateTime: res[position].dateTime,
                      centerID: res[position].centerID,
                      clinicID: res[position].clinicID,
                    ),
                  ],
                  ),
                );
                });
          }
          else{
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Material(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Loader(),
                      SizedBox(height: 10,),
                      Text('loading...')
                    ],
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }

  _cancelAppointment({String clinicID,String centerID,String date,String time}){
    showDialog(context: context,builder: (context){
      return AlertDialog(
        title: Column(
          children: <Widget>[
            Text('Confirm cancelation'),
            Divider()
          ],
        ),
        content: Text('Are you sure you want to cancel this appointment ?'),
        shape: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none
        ),
        actions: <Widget>[
          RaisedButton(
            shape: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    topLeft: Radius.circular(20)
                )
            ),
            child: Text('Yes'),
            onPressed: ()async{
              bool isCancel = await appointmentAPI.cancelAppointment(
                clinicID: clinicID,
                centerID: centerID,
                patientID: widget._patientID,
                date: date,
                time: time,
              );
              if(isCancel) {
                Navigator.pop(context);
                setState(() {

                });
              }
            },
          ),
          RaisedButton(
            color: Colors.blue[800],
            shape: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(20),
                    topRight: Radius.circular(20)
                )
            ),
            child: Text('No'),
            onPressed: ()=>Navigator.pop(context),
          )
        ],);
    });

  }

  Widget rightSide({String channelID,String clinicID,String centerID,DateTime dateTime}){
    return SizedBox(
      width: MediaQuery.of(context).size.width*0.1,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            icon: Icon(Icons.cancel,color: Colors.grey,),
            onPressed: ()=>_cancelAppointment(
              centerID: centerID,
              clinicID: clinicID,
              date:"${dateTime.year}-${dateTime.month}-${dateTime.day}",
              time: "${dateTime.hour}:${dateTime.minute}:${dateTime.second}"
            ),
          ),
          channelID == '--'? Container()
              :IconButton(
            icon: Icon(Icons.video_call,color: Colors.blue[800],),
            onPressed: ()async{
              await _handleCameraAndMic();
              MyPageRoute().fadeTransitionRouting(context,CallPage(channelName: channelID,));
            },
          )
        ],
      ),
    );
  }

  Future<void> _handleCameraAndMic() async {
    await PermissionHandler().requestPermissions(
      [PermissionGroup.camera, PermissionGroup.microphone],
    );
  }
}
