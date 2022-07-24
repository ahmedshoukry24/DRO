import 'dart:math';

import 'package:dro_patient_app/APIs/BookingSectionAPIs.dart';
import 'package:dro_patient_app/APIs/URL/mainURL.dart';
import 'package:dro_patient_app/UI/OtherPages/BookingSectionPages/ReminderDialogs.dart';
import 'package:dro_patient_app/UI/OtherPages/BookingSectionPages/switchBTN.dart';
import 'package:dro_patient_app/UI/Parts/Custom/MyCustomImage.dart';
import 'package:dro_patient_app/UI/Parts/Loader.dart';
import 'package:fleva_icons/fleva_icons.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class ConfirmClinicAppointmentPage extends StatelessWidget {

  final String _patientID,_clinicID;
  final DateTime _date;
  final TimeOfDay _time;

  ConfirmClinicAppointmentPage(this._patientID,this._clinicID,this._date,this._time);

  static int x ;
  static BookingSectionAPIs _bookingSectionAPIs = BookingSectionAPIs();

  static ReminderDialogs reminderDialogs = ReminderDialogs();
  static SwitchBTN switchBTN = SwitchBTN();


  @override
  Widget build(BuildContext context) {
    x = MediaQuery.of(context).size.width~/1;
    return Scaffold(
      appBar: AppBar(
        title: Text('Confirm appointment'),
      ),
      body: NotificationListener<OverscrollIndicatorNotification>(
        // ignore: missing_return
        onNotification: (OverscrollIndicatorNotification over){
          over.disallowGlow();
        },
        child: FutureBuilder(
          future: _bookingSectionAPIs.clinicConfirmBookingAPI(clinicId: _clinicID,patientId: _patientID),
          builder: (context,ss){
            if(ss.hasError){
              print('Error');
            }
            if(ss.hasData){
              Map myData =  ss.data[0];
              print(myData);
              return ListView(
                children: <Widget>[
                  imageAndName(
                      drName: '${myData['DR_F_N']} ${myData['DR_L_N']} ',
                      clinicName: myData['CLINIC_NAME'],
                    drImage: myData['PROFILE_PICTURE'],
                    context: context
                  ),
                  _body(mapData: myData,context: context),

                  // *** book button ***
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        FlatButton(
                          child: Text('Book'),
                          onPressed: (){
                            bookBTN(context);
                          },
                        ),
                      ],
                    ),
                  )
                ],
              );
            }else{
              return Material(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Loader(),
                    SizedBox(height: 10,),
                    Text('loading...')
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }

  Widget imageAndName({String drName,String clinicName,String drImage,BuildContext context}){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 0,
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // "${imageLoc}doctorImages/$drImage"
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: MyCustomImage(
                    height: MediaQuery.of(context).size.width/2.5,
                    width: MediaQuery.of(context).size.width/2.5,
                    image: "${imageLoc}doctorImages/$drImage" ,
                  ),
                ),
              ],
            ),
            ListTile(
              title: Text('Dr. $drName',textAlign: TextAlign.center,),
              subtitle: clinicName != '--' ? Text('$clinicName',textAlign: TextAlign.center)
                  :Container(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _body({Map mapData,context}){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 0,
        child: Column(
          children: <Widget>[
            ListTile(
              title: Text('${mapData['FIRST_NAME']} ${mapData['LAST_NAME']}'),
              subtitle: Text('${mapData['PATIENT_PHONE']}'),
              leading: Icon(FlevaIcons.person_done_outline),
            ),
            Divider(height: 0,indent: x/4,endIndent: x/4,),
            ListTile(
              title: Text('${DateFormat('MMMMEEEEd').format(_date)}'),
              subtitle: Text('${_time.format(context)}'),
              leading: Icon(FlevaIcons.calendar_outline),
            ),
            ListTile(
              title: Text('${mapData['ADDRESS']}'),
              leading: Icon(FlevaIcons.pin_outline),
            ),
            ListTile(
              title: Text('Clinic phone'),
              subtitle: Text('${mapData['CLINIC_PHONE']}'),
              leading: Icon(FlevaIcons.phone_outline),
            ),
            ListTile(
              title: Text('${mapData['FEE']} L.E'),
              leading: Icon(Icons.attach_money),
            ),
            mapData['SPECIALITY'].toString().contains('Psychiatry') ? switchBTN : Container(),

          ],
        ),
      ),
    );
  }

  bookBTN(context) async {
    bool res = await _bookingSectionAPIs.setAppointment(
        patientID: _patientID,
        clinicID: _clinicID,
        centerID: '-1',
        date: DateFormat('yyy-M-d').format(_date),
        time: "${_time.hour}:${_time.minute}",
        channelID: switchBTN.switchValue ?'$_patientID${Random().nextInt(1000)}$_clinicID' : '--'
    );
    // في حالة اتنين فتحو الصفحة وداسو على نفس ميعاد الحجز ف نفس الوقت
    if(res){
      Navigator.pop(context);
      Navigator.pop(context);
      reminderDialogs.doneDialog(context, _date,_time);
    }else{
      Navigator.pop(context);
      showDialog(context: context,builder: (context){
        return AlertDialog(
          content: Text('Sorry there\'s something wrong!\nPlease try again'),
        );
      });
    }
  }

}

