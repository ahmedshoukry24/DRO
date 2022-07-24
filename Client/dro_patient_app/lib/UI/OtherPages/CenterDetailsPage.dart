import 'package:dro_patient_app/APIs/CentersAPI.dart';
import 'package:dro_patient_app/APIs/URL/mainURL.dart';
import 'package:dro_patient_app/UI/Parts/BookingSection.dart';
import 'package:dro_patient_app/UI/Parts/Custom/CustomDialog.dart';
import 'package:dro_patient_app/UI/Parts/Custom/MyCustomImage.dart';
import 'package:dro_patient_app/UI/Parts/FavoriteIcon.dart';
import 'package:dro_patient_app/UI/Parts/Insurance.dart';
import 'package:dro_patient_app/UI/Parts/Loader.dart';
import 'package:dro_patient_app/UI/Parts/PhotosOf.dart';
import 'package:dro_patient_app/UI/Parts/Rating_Review_Section.dart';
import 'package:dro_patient_app/UI/Parts/TotalRate.dart';
import 'package:fleva_icons/fleva_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'ClinicDetailsPage.dart';

class CenterDetailsPage extends StatefulWidget {
  final String _patientID;
  final Map _centerInfo;
  /*
  come from 3 places:
  1- favorite =>> CENTER_ID, NAME, ADDRESS, CENTER_PHONE, SPECIALITY, FEE, DOC_ADMIN, CENTER_KEY
  2- centerCard =>> CENTER_ID, NAME, ADDRESS, CENTER_PHONE, SPECIALITY, FEE, DOC_ADMIN, CENTER_KEY
  3- AppointmentPage - CenterAppointmentModel =>> CENTER_ID, NAME, ADDRESS, CENTER_PHONE, SPECIALITY, FEE
  ------------

  _centerInfo:::

  CENTER_ID,
  NAME,
  ADDRESS,
  CENTER_PHONE,
  SPECIALITY,
  FEE,
  DOC_ADMIN, ==> not used
  CENTER_KEY ==> not used
   */

  CenterDetailsPage(this._patientID, this._centerInfo);

  @override
  _CenterDetailsPageState createState() => _CenterDetailsPageState();
}

class _CenterDetailsPageState extends State<CenterDetailsPage>{

  CentersAPI _centersAPI;
  Widget insurance;
  Widget bookingSection;
  Widget photosOf;


  @override
  initState(){
    super.initState();
    insurance = InsuranceSection(clinicID: '-1',centerID: widget._centerInfo['CENTER_ID'],);
    bookingSection = BookingSection(widget._patientID,'-1',widget._centerInfo['CENTER_ID']);
    _centersAPI = CentersAPI();
    photosOf = PhotosOf(clinicID: '-1',centerID: widget._centerInfo['CENTER_ID'],);

  }

  _callPhone(String phone)async{
  if(await canLaunch('tel:$phone')){
    await launch('tel:$phone');
  }else{
    throw 'could not call';
  }
}

  @override
  Widget build(BuildContext context) {
    print(widget._centerInfo);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('${widget._centerInfo['NAME']}',
            style: TextStyle(fontSize: MediaQuery.of(context).size.width/15),),
          automaticallyImplyLeading: false,
          actions: <Widget>[
            FavoriteIcon(widget._patientID,'-1',widget._centerInfo['CENTER_ID']),
          ],
        ),
        body: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: MyCustomImage(
                image: '${imageLoc}PhotosOf/${widget._centerInfo['CENTER_PHOTO']}',
                height: MediaQuery.of(context).size.width/2,
                width: MediaQuery.of(context).size.width/2,
              ),
            ),
            TotalRate('-1',MediaQuery.of(context).size.width / 15,widget._centerInfo['CENTER_ID']),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('${widget._centerInfo['SPECIALITY']}',textAlign: TextAlign.center,),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(5)
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text('About',textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.w600),),
                    Text('${widget._centerInfo['ABOUT_CENTER']}',textAlign: TextAlign.center,)
                  ],
                ),
              ),
            ),

            Card(
              color: Colors.white70,
              elevation: 0,
              child: Column(
                children: <Widget>[
                  ListTile(
                    title: Text('${widget._centerInfo['CENTER_PHONE']}'),
                    leading: Icon(FlevaIcons.phone_outline, color: Colors.blue[800]),
                    onTap: ()=>_callPhone(widget._centerInfo['CENTER_PHONE']),
                  ),
                  Divider(endIndent: MediaQuery.of(context).size.width/3.5,indent: MediaQuery.of(context).size.width/3.5,),
                  ListTile(
                    title: Text('${widget._centerInfo['ADDRESS']}'),
                    leading: Icon(FlevaIcons.pin_outline, color: Colors.blue[800],),
                  ),
                ],
              ),
            ),


            Column(
              children: [

                Text('Center\'s doctors',style: TextStyle(fontWeight: FontWeight.w600),),

                doctors(widget._centerInfo['CENTER_ID']),
              ],
            ),
            insurance,
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Text('Photos Of Center',style: TextStyle(fontWeight: FontWeight.w600)),
                  ),
                  photosOf,
                ],
              ),
            ),
            bookingSection,
            RatingReview(widget._patientID,'-1',widget._centerInfo['CENTER_ID']),

          ],
        )
      ),
    );
  }

  Widget doctors(String centerID){
    return SizedBox(
      height: MediaQuery.of(context).size.width/3,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder(
          future: _centersAPI.getCenterDoctorsAPI(centerID: centerID),
          builder: (context,ss){
            if(ss.hasError){
              print(''' ***Error ==>> center doctors*** ''');
            }if(ss.hasData){
              List myList = ss.data;
              return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: myList.length,
                  itemBuilder: (context,position){
                    return GestureDetector(
                      onTap: (){
                        showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (context){
                          return MyCustomDialog(
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                ListTile(
                                  title: Text('${myList[position]['FIRST_NAME']} ${myList[position]['LAST_NAME']}'),
                                  subtitle: Text('${myList[position]['DOCTOR_PHONE']}'),
                                  leading: Icon(Icons.person),
                                ),
                                ListTile(
                                  title: Text('About doctor'),
                                  subtitle: Text('${myList[position]['BIO']}'),
                                  leading: Icon(Icons.info_outline),
                                ),
                                Divider(indent: MediaQuery.of(context).size.width/10,
                                  endIndent: MediaQuery.of(context).size.width/10,),

                                _clinicInCenter(myList[position]['DOCTOR_ID']),
                              ],
                            ),
                            actions: <Widget>[
                              RaisedButton(
                                color: Colors.blue[800],
                                textColor: Colors.white,
                                shape: OutlineInputBorder(
                                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20),topLeft: Radius.circular(20)),
                                  borderSide: BorderSide.none
                                ),
                                child: Text('Ok'),
                                onPressed: (){
                                  Navigator.pop(context);
                                },
                              ),
                            ],);
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Container(
                          height: MediaQuery.of(context).size.width/10,
                          width: MediaQuery.of(context).size.width/3,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                  image: myList[position]['PROFILE_PICTURE'] != '--'
                                      ?NetworkImage("${imageLoc}doctorImages/${myList[position]['PROFILE_PICTURE']}")
                                  : ExactAssetImage('image/1.jpg'),
                                  fit: BoxFit.cover
                              ),
                          ),
                        ),
                      ),
                    );
                  });
            }else{
              return Loader();
            }
          },
        ),
      ),
    );
  }

  _clinicInCenter(String doctorID) {
    return ListTile(
      title: Text('Clinic'),
      subtitle: FutureBuilder(
        future: _centersAPI.clinicInCenter(doctorID:doctorID ),
        builder: (context,AsyncSnapshot ss){
          if(ss.hasError){
            print(Error);
          }if(ss.hasData){
            print(ss.data);
            return ss.data.length != 0 ? ListView.builder(
              padding: EdgeInsets.all(0),
              shrinkWrap: true,
              itemCount: ss.data.length,
              itemBuilder: (context,index){
                return GestureDetector(
                  onTap: (){
                    Navigator.pop(context);
                    Navigator.push(context,
                        CupertinoPageRoute(builder: (context)=>ClinicDetailsPage(widget._patientID,ss.data[index]['CLINIC_ID'])));
                  },
                    child: Text('${ss.data[index]['CLINIC_NAME']}'),
                );
              },
            ) : Text('has no clinics');
          }else{
            return Loader();
          }
        },
      ),
      leading: Icon(Icons.work),
    );
  }

}