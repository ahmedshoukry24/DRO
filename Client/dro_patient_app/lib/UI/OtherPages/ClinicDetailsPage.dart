import 'package:dro_patient_app/APIs/URL/mainURL.dart';
import 'package:dro_patient_app/UI/Parts/Custom/MyCustomImage.dart';
import 'package:dro_patient_app/UI/Parts/Insurance.dart';
import 'package:dro_patient_app/UI/Parts/PhotosOf.dart';
import 'package:dro_patient_app/UI/Parts/Rating_Review_Section.dart';
import 'package:dro_patient_app/UI/Style/style.dart';
import 'package:fleva_icons/fleva_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../UI/Parts/BookingSection.dart';
import '../../UI/Parts/Loader.dart';
import '../../UI/Parts/TotalRate.dart';
import '../../APIs/ClinicsAPI.dart';
import '../Parts/FavoriteIcon.dart';
import 'package:url_launcher/url_launcher.dart';

class ClinicDetailsPage extends StatefulWidget {
  final String _patientId, _clinicID;
  ClinicDetailsPage( this._patientId,this._clinicID);

  @override
  _ClinicDetailsPageState createState() => _ClinicDetailsPageState();
}

class _ClinicDetailsPageState extends State<ClinicDetailsPage> {
  ClinicsAPI clinicsAPI = ClinicsAPI();
  var scaffoldKey = GlobalKey<ScaffoldState>();

  Widget insurance;
  Widget bookingSection;
  Style _style;
  Widget photosOf;

  _callPhone(String phone)async{
    if(await canLaunch('tel:$phone')){
      await launch('tel:$phone');
    }else throw 'Could not call';
  }

  @override
  void initState() {
    super.initState();
    insurance = InsuranceSection(centerID: '-1',clinicID: widget._clinicID,);
    bookingSection = BookingSection(widget._patientId,widget._clinicID,'-1');
    _style = Style();
    photosOf = PhotosOf(centerID: '-1',clinicID: widget._clinicID,);
  }

  @override
  Widget build(BuildContext context) {

    return FutureBuilder(
      future: clinicsAPI.getClinicDetailsAPI(clinicID: widget._clinicID),
      builder: (context, ss) {
        if (ss.hasError) {
          print('Error');
        }
        if (ss.hasData) {
          Map map = ss.data[0]; // data from clinic and doctor tables where clinicID ↑
          return _body(context, map);
        } else {
          return Material(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Loader(),
                SizedBox(
                  height: 10,
                ),
                Text('loading...')
              ],
            ),
          );
        }
      },
    );
  }

  Widget _body(BuildContext context, Map mapData) {
    double size = MediaQuery.of(context).size.width;
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Dr. ${mapData['FIRST_NAME']} ${mapData['LAST_NAME']}"),
        actions: <Widget>[
          FavoriteIcon(
            widget._patientId,
            mapData['CLINIC_ID'],
            '-1'
          )
        ],
      ),
      body: Container(
        color: Colors.grey[200],
        child: ListView(
          children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: MyCustomImage(
                  image: '${imageLoc}doctorImages/${mapData['PROFILE_PICTURE']}',
                  height: MediaQuery.of(context).size.width/2,
                  width: MediaQuery.of(context).size.width/2,
                ),
              ),
            ],
          ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: mapData['CLINIC_NAME']== '--'?Container() :Text('${mapData['CLINIC_NAME']}',textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.w500),),
            ),
            TotalRate(widget._clinicID, _style.getWidthSize(context)*0.09,'-1'),

            // Bio ****
            Card(
              elevation: 0,
              color: Colors.white.withOpacity(0.2),
              shape: OutlineInputBorder(
                borderRadius: BorderRadius.circular(7),
                borderSide: BorderSide.none,
              ),
              child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            FlevaIcons.person_outline,
                            color: Colors.blue[800],
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text('Dr. info',),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text('${mapData['BIO']}',),
                    ],
                  )),
            ),

            // Some details
            _something(phone: mapData['CLINIC_PHONE'],address:mapData['ADDRESS'],fee: mapData['FEE'] ),

            insurance,

            Divider(height: size / 15,indent:size / 4,endIndent: size / 4,),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Text('Photos Of Clinic'),
                  ),
                  photosOf,
                ],
              ),
            ),

            // *** Clinic Schedule ***
            bookingSection,

            // ** Reviews section **
            RatingReview(widget._patientId,widget._clinicID,'-1'),
          ],
        ),
      ),
    );
  }
  Widget _something({String phone,String address,String fee}){
    return Column(
      children: <Widget>[
        ListTile(
          title: Text('$phone'),
          leading: Icon(FlevaIcons.phone_outline, color: Colors.blue[800]),
          onTap: ()=>_callPhone(phone),
        ),
        ListTile(
          title: Text('$address'),
          leading: Icon(
            FlevaIcons.pin_outline,
            color: Colors.blue[800],
          ),
        ),
        ListTile(
          title: Text('$fee L.E'),
          leading: Icon(Icons.attach_money, color: Colors.blue[800]),
        ),
      ],
    );
  }
}