import 'package:cached_network_image/cached_network_image.dart';
import 'package:dro_doctor_app/APIs/AlarmAPI/SetAlarm.dart';
import 'package:dro_doctor_app/APIs/CancelAppointment.dart';
import 'package:dro_doctor_app/APIs/Common/getReservationsAPI.dart';
import 'package:dro_doctor_app/APIs/mainURL/mainURL.dart';
import 'package:dro_doctor_app/Model/reservation.dart';
import 'package:dro_doctor_app/UI/Custom/CustomDialog.dart';
import 'package:dro_doctor_app/UI/Custom/MyPageRoute.dart';
import 'package:dro_doctor_app/UI/Pages/CenterZone/CenterMedicalPrescription.dart';
import 'package:dro_doctor_app/UI/Pages/ClinicZone/ClinicMedicalPrescription.dart';
import 'package:dro_doctor_app/UI/Style/StyleFile.dart';
import 'package:dro_doctor_app/VideoCall/pages/call.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';

class ReservationPage extends StatefulWidget {
  final String clinicID,doctorID,centerID;
  final int x;
  ReservationPage(this.clinicID,this.doctorID,this.centerID,this.x);
  @override
  _ReservationPageState createState() => _ReservationPageState();
}

class _ReservationPageState extends State<ReservationPage> {

  ReservationsAPI reservations = ReservationsAPI();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.x ==0 ? 'Reservations': 'History'),automaticallyImplyLeading: false,actions: [
        widget.x == 0 ?IconButton(
          icon: Icon(Icons.history),
          onPressed: ()=>MyPageRoute().routeNow(context, ReservationPage(widget.clinicID,widget.doctorID,widget.centerID,1)),
        ) : Container()
      ],),
      body: FutureBuilder(
        future: reservations.getReservations(widget.clinicID,widget.centerID),
        builder: (context,ss){
          if(ss.hasError){
            print('Error');
          }
          if(ss.hasData){
            List<Reservation> res = ss.data;
            res.sort((a,b)=>a.date.compareTo(b.date));
            res.forEach((element) {
              print(element.date);
            });
            return ListView.builder(
                itemCount: res.length,
                itemBuilder: (context,position){
                  return _body(res[position]);
                }
            );
          }else{
            return Material(
              child: Center(
                child: SpinKitRipple(color: Colors.blue[800]),
              ),
            );
          }
        },
      ),
    );
  }
  Widget _body(Reservation res){
    DateTime now = DateTime.now();
    DateTime yesterday = DateTime(now.year,now.month,now.day).add(Duration(days: -1));
//    print("Y=> $yesterday");
    return widget.x ==0 ?(res.date.isAfter(DateTime.now())? _reservationCard(res) : Container())
    : (res.date.isBefore(DateTime.now()) && res.date.isAfter(yesterday)? _reservationCard(res) : Container()) ;
  }

  Widget _reservationCard(Reservation res){
    return Card(
      elevation: 0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: CachedNetworkImage(
              height: MediaQuery.of(context).size.width*0.2,
              width: MediaQuery.of(context).size.width*0.2,
              imageUrl: "${imageLoc}patientImages/${res.img}",
              placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, error) => Icon(Icons.error),
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width*0.5,
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0,right: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('${res.firstName} ${res.lastName}',style: TextStyle(
                      fontSize: Style().getWidthSize(context)*0.04,
                      fontWeight: FontWeight.w600
                  ),),
                  Text('${DateFormat('yMMMEd').format(res.date)}',style: TextStyle(color: Colors.red[900],fontWeight: FontWeight.w600),),
                  Text('${DateFormat('jm').format(res.date)}',style: TextStyle(color: Colors.red[900],fontWeight: FontWeight.w600)),
                  Text('${res.phone}'),
                  Text('${res.gender}'),
                ],
              ),
            ),
          ),
          widget.x == 0 ?
          SizedBox(
            width: MediaQuery.of(context).size.width*0.2,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                res.channelID=='--'?Container()
                    :InkWell(onTap: ()async{
                  await _handleCameraAndMic();
                  MyPageRoute().routeNow(context, CallPage(channelName: res.channelID,));
                      },
                    child: Icon(Icons.video_call)),
                IconButton(
                  icon: Icon(Icons.cancel,color: Colors.grey,),
                  onPressed: ()=>_cancel(res.patientID,res.date),
                ),
              ],
            ),
          ): SizedBox(
            width: MediaQuery.of(context).size.width*0.2,
            child: IconButton(
              icon: Icon(Icons.assignment),
              onPressed: (){
                if(widget.clinicID != '-1'){
                  MyPageRoute().routeNow(context,
                      ClinicMedicalPrescription(res.patientID,widget.doctorID,widget.clinicID));
                }else{
                  MyPageRoute().routeNow(context,
                      CenterMedicalPrescription(res.patientID,widget.doctorID,widget.centerID));
                }
              },
            ),
          ),

        ],
      ),
    );
  }

  void _cancel(String patientID,DateTime dateTime){

    CancelAppointment cancelAppointment;
    SetAlarmAPI setAlarm;

    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context){
          return MyCustomDialog(
            content: Text('Are you sure you want to cancel this appointment ?'),
            actions: [
              Padding(
                padding: const EdgeInsets.all(3.0),
                child: RaisedButton(
                  color: Colors.blue[800],
                  child: Text('Yes',style: TextStyle(color: Colors.white),),
                  shape: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(25),
                          topLeft: Radius.circular(25)
                      )
                  ),
                  onPressed: ()async{
                    setAlarm = SetAlarmAPI();
                    cancelAppointment = CancelAppointment();
                    await cancelAppointment.cancelAppointment(
                      patientID: patientID,
                      centerID:widget.centerID,
                      clinicID: widget.clinicID,
                      date: DateFormat('yyy-M-d').format(dateTime),
                      time: DateFormat('HH:mm:ss').format(dateTime),
                    ).then((value){
                      // *** this is the part of alarm table
                      print('The value of cancellation $value');
                      if(value){
                        setState(() {
                          Navigator.pop(context);
                          setAlarm.setAlarm(
                            title: 'Appointment Cancellation',
                              body: '${DateFormat('MMMMd').format(dateTime)}\n'
                                  '${DateFormat('jm').format(dateTime)}\n'
                                  'is canceled.',
                              patientID: patientID
                          );
                        });
                      }else{
                        Navigator.pop(context);
                        showDialog(context: context,
                            builder: (context)=>MyCustomDialog(title: Text('Please check your internet and try again'),));
                      }
                    }
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(3.0),
                child: RaisedButton(
                  child:Text('No'),
                  shape: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(25),
                        topRight: Radius.circular(25)
                    ),
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

  Future<void> _handleCameraAndMic() async {
    await PermissionHandler().requestPermissions(
      [PermissionGroup.camera, PermissionGroup.microphone],
    );
  }

}
