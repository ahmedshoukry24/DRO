import 'dart:ui';
import 'package:dro_doctor_app/APIs/mainURL/mainURL.dart';
import 'package:dro_doctor_app/UI/Custom/MyCustomImage.dart';
import 'package:flutter/cupertino.dart';
import '../../APIs/doctorInfoAPI.dart';
import '../../Model/doctor.dart';
import '../../OfflineDatabase/helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'Questions/questinsPage.dart';

class Profile extends StatefulWidget {
  final String doctorID;
  Profile(this.doctorID);
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  DoctorInfoAPI doctorInfo = DoctorInfoAPI();
  DatabaseHelper db = DatabaseHelper();

  ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: doctorInfo.getDoctorInfo(widget.doctorID),
      builder: (context, ss) {
        if (ss.hasError) {
          print('Error---------profile');
        }
        if (ss.hasData) {
          DoctorModel doctor = ss.data;
          return _profile(doctor);
        } else {
          return SpinKitRipple(color: Colors.blue[800],);
        }
      },
    );
  }


  Widget _profile(DoctorModel doctor){
    return SafeArea(
      child: Scaffold(
//              appBar: AppBar(
//                title: Text('${doctor.fName} ${doctor.lName}'),
//                centerTitle: true,
//              ),
          body: Stack(
            children: <Widget>[
              SizedBox(
                height: MediaQuery.of(context).size.width/2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MyCustomImage(
                    image: '${imageLoc}doctorImages/${doctor.profilePicture}',
                    height: MediaQuery.of(context).size.width/2,
                    width: MediaQuery.of(context).size.width,
                  ),
                ],
              ),
              ),
              ListView(
                controller: _scrollController,
                children: <Widget>[
                  SizedBox(height: MediaQuery.of(context).size.width/3,),
                  Container(
                    color: Colors.black54,
                    child: Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Text('${doctor.fName} ${doctor.lName}',
                        style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.w500),
                        textAlign: TextAlign.center,),
                    ),
                  ),
                  _drInfo(doctor),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0,right: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          child: Card(
                            color: Colors.white.withOpacity(0.4),
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Text('Views',textAlign: TextAlign.center,),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Card(
                            color: Colors.white.withOpacity(0.4),
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Text('Bookings',textAlign: TextAlign.center,),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // ** questions
                  _questions(widget.doctorID,doctor.specialty),
                ],
              ),
            ],
          )),
    );
  }

  //*** doctor info ***
  Widget _drInfo(DoctorModel doctor){
    return Padding(
      padding: const EdgeInsets.only(left: 8,right: 8,),
      child: doctor != null ? Card(
        margin: EdgeInsets.fromLTRB(8.0, 0, 8.0, 8.0),
        color: Colors.grey[200],
        elevation: 4,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('Doctor Info.', style: TextStyle(color: Colors.blue[800]),),
                    Icon(Icons.edit,color: Colors.blue[800],size: 20,)
                  ],
                ),
              ),
            ),
            SingleChildScrollView(
                padding: EdgeInsets.all(0),
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0,right: 8.0,bottom: 8.0),
                  child:Text('${doctor.bio}'),
                ))
          ],
        ),
      ) : Card(
        color: Colors.grey.withOpacity(0.2),
        elevation: 20,
      ),
    );
  }
  

  // *** questions
  Widget _questions(String doctorID,specialty) {
    return GestureDetector(
      onTap: ()=>Navigator.push(context, CupertinoPageRoute(builder: (context)=>QuestionsPage(doctorID,specialty))),
      child: Card(
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            title: Text('Questions'),
            subtitle: Text('Answer some samll questions about your specialty'),
            leading: Icon(Icons.question_answer),
            trailing: Icon(Icons.arrow_forward),
          ),
        ),
      ),
    );
  }


}
