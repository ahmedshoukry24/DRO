import 'package:dro_patient_app/APIs/BookingSectionAPIs.dart';
import 'package:dro_patient_app/UI/OtherPages/BookingSectionPages/ReminderDialogs.dart';
import 'package:dro_patient_app/UI/Parts/Custom/CustomDialog.dart';
import 'package:dro_patient_app/UI/Parts/Loader.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ConfirmCenterAppointmentPage extends StatelessWidget {

  final String _centerID,_patientID;
  final DateTime _date;
  final TimeOfDay _time;

  ConfirmCenterAppointmentPage(this._patientID,this._centerID,this._date,this._time);

  static BookingSectionAPIs _bookingSectionAPIs = BookingSectionAPIs();
  static ReminderDialogs reminderDialogs = ReminderDialogs();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Confirm Appointment'),
        automaticallyImplyLeading: false,
      ),
      body: FutureBuilder(
        future: _bookingSectionAPIs.centerConfirmBookingAPI(centerID: _centerID,patientID: _patientID),
        builder: (BuildContext context,AsyncSnapshot ss){
          if(ss.hasError){
            print('Error');
          }
          if(ss.hasData){
            Map myData = ss.data;
            return myData['NAME'] != null ? ListView(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Card(
                      color: Colors.white70,
                      elevation: 0,
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child:Text('SomeInfo'),
                          ),
                          ListTile(
                            title: Text('${myData['NAME']}'),
                            subtitle: Text('${myData['CENTER_PHONE']}'),
                            leading: Icon(Icons.place),
                          ),
                        ],
                      )
                  ),
                ),
                Card(
                  color: Colors.white70,
                  elevation: 0,
                  child: Column(
                    children: <Widget>[
                      ListTile(
                        title: Text('${myData['FIRST_NAME']} ${myData['LAST_NAME']}'),
                        subtitle: Text('${myData['PATIENT_PHONE']}'),
                        leading: Icon(Icons.phone),
                      ),
                      Divider(height: 0,
                        endIndent: MediaQuery.of(context).size.width/3.5,
                        indent: MediaQuery.of(context).size.width/3.5,),
                      ListTile(
                        title: Text('${DateFormat('MMMMEEEEd').format(_date)}'),
                        subtitle: Text('${_time.format(context)}'),
                        leading: Icon(Icons.calendar_today),
                      ),
                      ListTile(
                        title: Text('${myData['FEE']}'),
                        leading: Icon(Icons.attach_money),
                      ),
                    ],
                  ),
                ),
                RaisedButton(
                  child: Text('Book'),
                  onPressed: (){
                    bookBTN(context);
                  }
                )
              ],
            )
            : Center(child: Text('Please check your internet connection and try again'),) ;
          }else{
            return Loader();
          }
        },
      )
    );
  }

  bookBTN(context)async{
    bool res = await _bookingSectionAPIs.setAppointment(
        patientID: _patientID,
        clinicID: '-1',
        centerID: _centerID,
        time: "${_time.hour}:${_time.minute}",
        date: DateFormat('yyy-M-d').format(_date),
        channelID: '--'
    );
    if(res){
      print(res);
      Navigator.pop(context);
      Navigator.pop(context);
      reminderDialogs.doneDialog(context, _date,_time);
    }else{
      Navigator.pop(context);
      Navigator.pop(context);
      showDialog(context: context,builder: (context){
        return MyCustomDialog(
          content: Text('Sorry there\'s something wrong!\nPlease try again',style: TextStyle(fontWeight: FontWeight.bold),),
        );
      });
    }
  }
}
