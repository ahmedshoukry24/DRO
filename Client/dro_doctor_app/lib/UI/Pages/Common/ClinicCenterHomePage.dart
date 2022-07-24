import 'package:dro_doctor_app/APIs/AllAboutCenter/ownCentersAPI.dart';
import 'package:dro_doctor_app/APIs/mainURL/mainURL.dart';
import 'package:dro_doctor_app/Model/CenterModel.dart';
import 'package:dro_doctor_app/UI/Custom/CustomDialog.dart';
import 'package:dro_doctor_app/UI/Custom/MyCustomImage.dart';
import 'package:dro_doctor_app/UI/Custom/MyPageRoute.dart';
import 'package:dro_doctor_app/UI/Pages/CenterZone/empView/EmpHomePage.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import '../../../Model/ClinicModel.dart';
import '../CenterZone/CreateCenter.dart';
import '../ClinicZone/MainPages/ClinicHome.dart';
import '../ClinicZone/CreateClinic.dart';
import 'package:flutter/cupertino.dart';
import '../../../APIs/AllAboutClinic/ownClinicsAPI.dart';
import 'package:flutter/material.dart';
import 'package:fleva_icons/fleva_icons.dart';
import '../CenterZone/adminView/AdminHomePage.dart';

class ClinicCenterHomePage extends StatefulWidget {
  final String doctorID;

  ClinicCenterHomePage(this.doctorID);

  @override
  _ClinicCenterHomePageState createState() => _ClinicCenterHomePageState();
}

class _ClinicCenterHomePageState extends State<ClinicCenterHomePage> {
  OwnClinicsAPI ownClinicAPI = OwnClinicsAPI();
  OwnCentersAPI ownCentersAPI = OwnCentersAPI();
  final key = GlobalKey<ScaffoldState>();
  bool show = false;
  Color floatingColor = Colors.blue[800];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: key,
      appBar: AppBar(
        title: Row(
          children: <Widget>[
            Icon(Icons.work),
            SizedBox(
              width: 10,
            ),
            Text('Clinics and Centers'),
          ],
        ),
        actions: <Widget>[
          IconButton(
              icon: Icon(FlevaIcons.plus_circle_outline),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return Dialog(
                        backgroundColor: Colors.white,
                        shape: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none),
                        child: SizedBox(
                          height: MediaQuery.of(context).size.width / 2,
                          child: NotificationListener(
                            // ignore: missing_return
                            onNotification:
                                // ignore: missing_return
                                (OverscrollIndicatorNotification over) {
                              over.disallowGlow();
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: <Widget>[
                                SizedBox(
                                  width: 5.0,
                                ),
                                Expanded(
                                  child: FlatButton(
                                      color: Colors.grey[100],
                                      shape: OutlineInputBorder(
                                          borderSide: BorderSide.none,
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            topRight: Radius.circular(10),
                                          )),
                                      child: Text('Clinic'),
                                      onPressed: () {
                                        Navigator.pop(context);
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    CreateClinic(
                                                      widget.doctorID,
                                                    )));
                                      }),
                                ),
                                Expanded(
                                  child: FlatButton(
                                    color: Colors.grey[300],
                                    shape: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(10),
                                          bottomRight: Radius.circular(10),
                                        )),
                                    child: Text('Center'),
                                    onPressed: () {
                                      Navigator.pop(context);
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  CreateCenter(
                                                    widget.doctorID,
                                                  )));
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    });
              }),
        ],
      ),
      body: show == false
          // ** clinic **
          ? FutureBuilder(
              future: ownClinicAPI.clinics(widget.doctorID),
              builder: (context, ss) {
                if (ss.hasError) {
                  print('Error ::: ss has error');
                }
                if (ss.hasData) {
                  List myList = ss.data;
                  return myList.length > 0 ? ListView.builder(
                    itemCount: myList.length,
                    itemBuilder: (context, position) {
                      return _clinicCard(
                        clinicID: myList[position]['CLINIC_ID'],
                        clinicName: myList[position]['CLINIC_NAME'],
                        address: myList[position]['ADDRESS'],
                        phone: myList[position]['CLINIC_PHONE'],
                        doctorPhoto: myList[position]['PROFILE_PICTURE'],
                        drName: "${myList[position]['FIRST_NAME']} ${myList[position]['LAST_NAME']}"
                      );
                    },
                  ) : Center(
                    child: Text('You have no clinic yet!'),
                  );
                } else {
                  return Center(
                    child: Text('Loading...'),
                  );
                }
              },
            )
          // ** center **
          : FutureBuilder(
              future: ownCentersAPI.centers(widget.doctorID),
              builder: (BuildContext context, AsyncSnapshot ss) {
                if (ss.hasError) {
                  print('Error in own centers snapShot');
                }
                if (ss.hasData) {
                  List<CenterModel> myData = ss.data;
                  print(myData);
                  return ListView.builder(
                    itemCount: myData.length,
                    itemBuilder: (context, position) {
                      return _centerCard(
                          admin: myData[position].docAdmin,
                          centerID:myData[position].centerID,
                          centerPhoto: myData[position].centerPhoto,
                          centerName: myData[position].centerName,
                          address: myData[position].address,
                          centerPhone: myData[position].centerPhone
                      );
                    },
                  );
                } else {
                  return Center(
                    child: Text("Loading..."),
                  );
                }
              },
            ),
      floatingActionButton: SpeedDial(
        backgroundColor: floatingColor,
        child: Icon(Icons.work),
        animatedIcon: AnimatedIcons.menu_close,
        onOpen: () {
          setState(() {
            floatingColor = Colors.red[700];
          });
        },
        onClose: () {
          setState(() {
            floatingColor = Colors.blue[800];
          });
        },
        children: [
          SpeedDialChild(
              onTap: () {
                setState(() {
                  show = false;
                });
              },
              child: CircleAvatar(
                child: Text(
                  'Clinic',
                  style: TextStyle(fontSize: 10),
                ),
              )),
          SpeedDialChild(
              onTap: () {
                setState(() {
                  show = true;
                });
              },
              child: CircleAvatar(
                child: Text(
                  'Center',
                  style: TextStyle(fontSize: 10),
                ),
              )),
        ],
      ),
    );
  }

  Widget _centerCard({String admin,String centerID,String centerPhoto,
    String centerName,String address,String centerPhone}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.width*0.01,horizontal: MediaQuery.of(context).size.width*0.01),
      child: GestureDetector(
        onTap: () {
          if(widget.doctorID == admin){
            MyPageRoute().routeNow(context, AdminHomePage(widget.doctorID,centerID,admin));
          }else{
            MyPageRoute().routeNow(context, EmpHomePage(widget.doctorID,centerID,admin),);
          }
        },
        child: Card(
          color: Colors.grey[50],
            elevation: 5,
            margin: EdgeInsets.all(0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width*0.2,
                  height: MediaQuery.of(context).size.width*0.2,
                  child:  centerPhoto == '--'? CircleAvatar(
                      backgroundColor: Colors.grey[200],
                      child: Icon(
                        FlevaIcons.briefcase_outline,
                        color: Colors.black,
                      ))
                      : ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: MyCustomImage(
                      secImg: '0',
                      image: "${imageLoc}PhotosOf/$centerPhoto",
                      height: MediaQuery.of(context).size.width*0.2,
                      width: MediaQuery.of(context).size.width*0.2,
                    ),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width*0.7,
                  child: Padding(
                    padding:  EdgeInsets.all(MediaQuery.of(context).size.width*0.02),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(0,2,0,2),
                          child: Wrap(
                            children: [
                              Icon(Icons.arrow_right,size: MediaQuery.of(context).size.width*0.04),
                              Text(' $centerName',style: TextStyle(color: Colors.blue[900],fontWeight: FontWeight.w500),),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(0,2,0,2),
                          child: Wrap(
                            children: [
                              Icon(Icons.place,size: MediaQuery.of(context).size.width*0.04),
                              Text(' $address',style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.035),),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(0,2,0,2),
                          child: Wrap(
                            children: [
                              Icon(Icons.phone,size: MediaQuery.of(context).size.width*0.04,),
                              Text(' $centerPhone',style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.035)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )
        ),
      ),
    );
  }

  Widget _clinicCard({String clinicID,String clinicName,String address,String phone,String doctorPhoto,String drName}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.width*0.01,horizontal: MediaQuery.of(context).size.width*0.01),
      child: GestureDetector(
        onTap: () {
          MyPageRoute().routeNow(context, ClinicHome(
              clinicID,
              widget.doctorID));
        },
        child: Card(
          margin: EdgeInsets.all(0),
          elevation: 5,
          color: Colors.grey[50],
          shape: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide.none,
          ),
          child: Row(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width*0.2,
                height: MediaQuery.of(context).size.width*0.2,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: MyCustomImage(
                    width: MediaQuery.of(context).size.width*0.2,
                    height: MediaQuery.of(context).size.width*0.2,
                    image: "${imageLoc}doctorImages/$doctorPhoto",
                    secImg: '0',
                  ),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width*0.7,
                child: Padding(
                  padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.02),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.fromLTRB(0,2,0,2),
                        child: Wrap(
                          children: [
                            Icon(Icons.arrow_right,size: MediaQuery.of(context).size.width*0.04,),
                            Text(clinicName !='--' ? ' $clinicName' : ' $drName',style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.035)),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0,2,0,2),
                        child: Wrap(
                          children: [
                            Icon(Icons.place,size: MediaQuery.of(context).size.width*0.04,),
                            Text(' $address',style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.035)),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0,2,0,2),
                        child: Wrap(
                          children: [
                            Icon(Icons.phone,size: MediaQuery.of(context).size.width*0.04,),
                            Text(' $phone',style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.035)),
                          ],
                        ),
                      ),

                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
