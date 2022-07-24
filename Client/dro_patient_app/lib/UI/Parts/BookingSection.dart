import 'package:dro_patient_app/APIs/BookingSectionAPIs.dart';
import 'Custom/MyPageRoute.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../OtherPages/BookingSectionPages/slotsPage.dart';
import 'package:table_calendar/table_calendar.dart';
import 'Loader.dart';

class BookingSection extends StatefulWidget {

  final String _patientID,_clinicID,_centerID;

  BookingSection(this._patientID,this._clinicID,this._centerID);


  @override
  _BookingSectionState createState() => _BookingSectionState();
}

class _BookingSectionState extends State<BookingSection> {

  BookingSectionAPIs _bookingSectionAPIs = BookingSectionAPIs();

  List<int> workingWeekDays = List<int>();

  CalendarController _controller;

  MyPageRoute myPageRoute = MyPageRoute();

  @override
  void initState() {
    super.initState();
    _controller = CalendarController();
  }

  @override
  void dispose() {
    super.dispose();
    _controller?.dispose();
  }

  TimeOfDay stringToTimeOfDay(String tod){
    final format = DateFormat.jm(); //"6:00 AM"
    return TimeOfDay.fromDateTime(format.parse(tod));
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _bookingSectionAPIs.getSchedule(clinicID: widget._clinicID,centerID: widget._centerID),
      builder: (BuildContext context, AsyncSnapshot ss) {
        if (ss.hasError) {
          print('Error');
        }
        if (ss.hasData) {
          List myJsonList = ss.data;
          if (myJsonList.length > 0) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  /*
                  I get days from db ... then I put conditions to show the day ... like => if saturday have start time and end time
                  in database then I show saturday : I hide it ....
                  when I show saturday I add to the list (weekDays) the number of the day[ (saturday) = 6 ] ...
                  then I make a table calender
                  and set weekendDays = my list(weekDays) that will make (saturday) different color so I can make it special between other days
                  then when I select some day from the calender I ask a question(put a condition) ...
                  if the day I selected(the number of the day in the week => [DateTime.weekDay]) is in the list like (saturday = 6) ...
                  then I put some actions : I ignore the day I selected.

                  --- no number will enter my actions except my days from database ---
                  --- no case in the switch case I create will run except the cases with numbers of selected days ---

                  * * * actions :::

                  switch case to detect the day I select ...
                  like => if case 6 that means the day is saturday

                   */

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(widget._clinicID!='-1' ? 'Clinic Working days' : 'Center Working days'),
                    ],
                  ),

                  // ** Saturday
                  (myJsonList[0]['SAT_START'] != '--') &&
                      (myJsonList[0]['SAT_END'] != '--')
                      ? showDay(
                      dayName: 'Saturday',
                      dayStart: myJsonList[0]['SAT_START'],
                      dayEnd: myJsonList[0]['SAT_END'],
                      context: context)
                      : Container(),

                  // ** Sunday
                  (myJsonList[0]['SUN_START'] != '--') &&
                      (myJsonList[0]['SUN_END'] != '--')
                      ? showDay(
                      dayName: 'Sunday',
                      dayStart: myJsonList[0]['SUN_START'],
                      dayEnd: myJsonList[0]['SUN_END'],
                      context: context)
                      : Container(),

                  // ** Monday
                  (myJsonList[0]['MON_START'] != '--') &&
                      (myJsonList[0]['MON_END'] != '--')
                      ? showDay(
                      dayName: 'Monday',
                      dayStart: myJsonList[0]['MON_START'],
                      dayEnd: myJsonList[0]['MON_END'],
                      context: context)
                      : Container(),

                  // ** Tuesday
                  (myJsonList[0]['TUES_START'] != '--') &&
                      (myJsonList[0]['TUES_END'] != '--')
                      ? showDay(
                      dayName: 'Tuesday',
                      dayStart: myJsonList[0]['TUES_START'],
                      dayEnd: myJsonList[0]['TUES_END'],
                      context: context)
                      : Container(),

                  // ** Wednesday
                  (myJsonList[0]['WED_START'] != '--') &&
                      (myJsonList[0]['WED_END'] != '--')
                      ? showDay(
                      dayName: 'Wednesday',
                      dayStart: myJsonList[0]['WED_START'],
                      dayEnd: myJsonList[0]['WED_END'],
                      context: context)
                      : Container(),

                  // ** Thursday
                  (myJsonList[0]['THU_START'] != '--') &&
                      (myJsonList[0]['THU_END'] != '--')
                      ? showDay(
                      dayName: 'Thursday',
                      dayStart: myJsonList[0]['THU_START'],
                      dayEnd: myJsonList[0]['THU_END'],
                      context: context)
                      : Container(),

                  // ** Friday
                  (myJsonList[0]['FRI_START'] != '--') &&
                      (myJsonList[0]['FRI_END'] != '--')
                      ? showDay(
                      dayName: 'Friday',
                      dayStart: myJsonList[0]['FRI_START'],
                      dayEnd: myJsonList[0]['FRI_END'],
                      context: context)
                      : Container(),
                  Card(
                    color: Colors.white.withOpacity(0.8),
                    child: ExpansionTile(
                      title: Text('Book'),
                      subtitle: Text(
                        'Select date and time',
                        style: TextStyle(color: Colors.grey),
                      ),
                      children: <Widget>[
                        TableCalendar(
                          calendarController: _controller,
                          initialCalendarFormat: CalendarFormat.week,
                          startDay: DateTime.now(),
                          weekendDays: workingWeekDays,
                          calendarStyle: CalendarStyle(
                              selectedColor: Colors.blue[800],
                              todayColor: Colors.blue[200],
                              weekdayStyle: TextStyle(color: Colors.grey[300]),
                              weekendStyle: TextStyle(
                                  color: Colors.blue[900],
                                  fontWeight: FontWeight.w600)),
                          daysOfWeekStyle: DaysOfWeekStyle(
                            weekdayStyle: TextStyle(color: Colors.grey[300]),
                            weekendStyle: TextStyle(
                                color: Colors.blue[800],
                                fontWeight: FontWeight.w600),
                          ),
                          onDaySelected: (date, list) {
                            if (workingWeekDays.contains(date.weekday)) {
                              switch (date.weekday) {
                              // ** Monday
                                case 1:
                                  _goToSlotsPage(
                                      patientID: widget._patientID,
                                      clinicID: widget._clinicID,
                                      centerID: widget._centerID,
                                      date: date,
                                      startTime: myJsonList[0]['MON_START'],
                                      endTime: myJsonList[0]['MON_END']
                                  );
                                  break;
                              // ** Tuesday
                                case 2:
                                  _goToSlotsPage(
                                      patientID: widget._patientID,
                                      clinicID: widget._clinicID,
                                      centerID: widget._centerID,
                                      date: date,
                                      startTime: myJsonList[0]['TUES_START'],
                                      endTime: myJsonList[0]['TUES_END']
                                  );
                                  break;
                              // ** wednesday
                                case 3:
                                  _goToSlotsPage(
                                      patientID: widget._patientID,
                                      clinicID: widget._clinicID,
                                      centerID: widget._centerID,
                                      date: date,
                                      startTime: myJsonList[0]['WED_START'],
                                      endTime: myJsonList[0]['WED_END']
                                  );
                                  break;
                              // ** thursday
                                case 4:
                                  _goToSlotsPage(
                                      patientID: widget._patientID,
                                      clinicID: widget._clinicID,
                                      centerID: widget._centerID,
                                      date: date,
                                      startTime: myJsonList[0]['THU_START'],
                                      endTime: myJsonList[0]['THU_END']
                                  );
                                  break;
                              // ** friday
                                case 5:
                                  _goToSlotsPage(
                                      patientID: widget._patientID,
                                      clinicID: widget._clinicID,
                                      centerID: widget._centerID,
                                      date: date,
                                      startTime: myJsonList[0]['FRI_START'],
                                      endTime: myJsonList[0]['FRI_END']
                                  );
                                  break;
                              // ** saturday
                                case 6:
                                  _goToSlotsPage(
                                      patientID: widget._patientID,
                                      clinicID: widget._clinicID,
                                      centerID: widget._centerID,
                                      date: date,
                                      startTime: myJsonList[0]['SAT_START'],
                                      endTime: myJsonList[0]['SAT_END']
                                  );
                                  break;
                              // ** sunday
                                case 7:
                                  _goToSlotsPage(
                                      patientID: widget._patientID,
                                      clinicID: widget._clinicID,
                                      centerID: widget._centerID,
                                      date: date,
                                      startTime: myJsonList[0]['SUN_START'],
                                      endTime: myJsonList[0]['SUN_END']
                                  );
                                  break;
                              }
                            }
                          },
                        )
                      ],
                    ),
                  )
                ],
              ),
            );
          } else {
            return Center(child: Text('Has no working days yet'),);
          }
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
    );
  }

  _goToSlotsPage({String patientID,String clinicID,String centerID,DateTime date,String startTime,String endTime}){
    myPageRoute.slideTransitionRouting(context, SlotsPage(
      patientID,
      clinicID,
      centerID,
      date,
      stringToTimeOfDay(startTime),
      stringToTimeOfDay(endTime),
      10,));

  }

  Widget showDay({String dayName, String dayStart, String dayEnd, context}) {
    switch (dayName) {
      case 'Saturday':
        // if else to avoid repeating
        if (workingWeekDays.contains(DateTime.saturday)) {
        } else {
          workingWeekDays.add(DateTime.saturday);
        }
        break;
      case 'Sunday':
        if (workingWeekDays.contains(DateTime.sunday)) {
        } else {
          workingWeekDays.add(DateTime.sunday);
        }
        break;
      case 'Monday':
        if (workingWeekDays.contains(DateTime.monday)) {
        } else {
          workingWeekDays.add(DateTime.monday);
        }
        break;
      case 'Tuesday':
        if (workingWeekDays.contains(DateTime.tuesday)) {
        } else {
          workingWeekDays.add(DateTime.tuesday);
        }
        break;
      case 'Wednesday':
        if (workingWeekDays.contains(DateTime.wednesday)) {
        } else {
          workingWeekDays.add(DateTime.wednesday);
        }
        break;
      case 'Thursday':
        if (workingWeekDays.contains(DateTime.thursday)) {
        } else {
          workingWeekDays.add(DateTime.thursday);
        }
        break;
      case 'Friday':
        if (workingWeekDays.contains(DateTime.friday)) {
        } else {
          workingWeekDays.add(DateTime.friday);
        }
        break;
    }
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          color: Colors.grey[100],
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                    child: Text(
                      '$dayName',
                      style: TextStyle(color: Colors.blue[900], fontSize: 20),
                    )),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text(
                          'From: ',
                          style: TextStyle(color: Colors.blue[800]),
                        ),
                        Text('$dayStart'),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          'To: ',
                          style: TextStyle(color: Colors.blue[800]),
                        ),
                        Text('$dayEnd'),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
