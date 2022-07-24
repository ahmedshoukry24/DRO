import 'package:dro_patient_app/APIs/BookingSectionAPIs.dart';
import 'package:dro_patient_app/UI/Parts/Custom/MyPageRoute.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../Parts/Loader.dart';
import 'ConfirmCenterAppointmentPage.dart';
import 'confirmClinicAppointmentPage.dart';

class SlotsPage extends StatefulWidget {

 final String _clinicID, _patientID,_centerID;
 final DateTime _date;
 final TimeOfDay _startTime, _endTime;
 final int _duration;

  SlotsPage(
        this._patientID,
        this._clinicID,
        this._centerID,
        this._date,
        this._startTime,
        this._endTime,
        this._duration,
      );

  @override
  _SlotsPageState createState() => _SlotsPageState();
}

class _SlotsPageState extends State<SlotsPage> {
  List<TimeOfDay> listOfAvailableTimes = List<TimeOfDay>();
  List<TimeOfDay> listOfNotAvailableTimes = List<TimeOfDay>();

  BookingSectionAPIs _bookingSectionAPIs = BookingSectionAPIs();


  @override
  Widget build(BuildContext context) {
    var availableHours = timeToDouble(widget._endTime) - timeToDouble(widget._startTime); // the clinic work 2 hours

    // we convert the (2 hours) to (120 minutes) ... and divide to duration the doctor set
    int numberOfReservations = (availableHours * 60) ~/ widget._duration; // we have 12 reservations in 2 hours

    DateTime x = DateTime.utc(0, 0, 0, widget._startTime.hour, widget._startTime.minute); // made this to be able to add duration

    for (int i = 0; i <= numberOfReservations; i++) {
      listOfAvailableTimes.add(TimeOfDay.fromDateTime(x.add(Duration(minutes: i * widget._duration))));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('${DateFormat('EEEE, (d - M - y)').format(widget._date)}'),
        automaticallyImplyLeading: false,
      ),
      body: FutureBuilder(
        future: _bookingSectionAPIs.selectedTimes(
            centerID: widget._centerID,
            clinicID: widget._clinicID,
            date: DateFormat('yyyy-M-d').format(widget._date)
        ),
        builder: (context, ss) {
          if (ss.hasError) {
            print('Error+++++');
          }
          if (ss.hasData) {
            List jsonData = ss.data;
            for (int i = 0; i < jsonData.length; i++) {
              listOfNotAvailableTimes.add(TimeOfDay.fromDateTime(DateFormat('HH:mm').parse(jsonData[i]['TIME'])));
            }
            return NotificationListener<OverscrollIndicatorNotification>(
              // ignore: missing_return
              onNotification: (OverscrollIndicatorNotification over){
                over.disallowGlow();
              },
              child: ListView(
                children: <Widget>[
                  Center(
                    child: GridView.builder(
                      physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4, childAspectRatio: 2),
                        itemCount: numberOfReservations + 1,
                        itemBuilder: (context, position) {
                        return showSlots(position);
                        }),
                  ),
                ],
              ),
            );
          } else {
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
    );
  }
  double timeToDouble(TimeOfDay time) => time.hour + time.minute / 60.0;
  TimeOfDay stringToTimeOfDay(String myString) {
    final format = DateFormat.jm();
    return TimeOfDay.fromDateTime(format.parse(myString));
  }

  Widget showSlots(int position){
    if (
    (widget._date.day == DateTime.now().day && timeToDouble(listOfAvailableTimes[position])<=timeToDouble(TimeOfDay.now()))
    ||
        listOfNotAvailableTimes.contains(listOfAvailableTimes[position])
    ) {
      // 03:50:00

      return Chip(
        label: Text(
          '${listOfAvailableTimes[position].format(context)}',
          textAlign: TextAlign.center,
          style: TextStyle(decoration: TextDecoration.lineThrough,color: Colors.grey[500]),
        ),
        backgroundColor: Colors.grey[200],
      );
    }
    else {
      return GestureDetector(
        onTap: () async {
          // to check if I'll go to center confirmation or clinic confirmation page
          if(widget._clinicID != '-1') {
            MyPageRoute().slideTransitionRouting(context, ConfirmClinicAppointmentPage(
              widget._patientID,
              widget._clinicID,
              widget._date,
              listOfAvailableTimes[position],
            ));
          }
          else{
            MyPageRoute().slideTransitionRouting(context, ConfirmCenterAppointmentPage(
                widget._patientID,
                widget._centerID,
                widget._date,
                listOfAvailableTimes[position]
            ));
          }
        },
        child: Chip(
          elevation: 1,
          shadowColor: Colors.blue[900],
          shape: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none
          ),
          label: Text(
            '${listOfAvailableTimes[position].format(context)}',
            textAlign: TextAlign.center,
          ),
        ),
      );
    }
  }

}
