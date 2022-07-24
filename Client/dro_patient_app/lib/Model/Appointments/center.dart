import 'package:dro_patient_app/APIs/URL/mainURL.dart';
import 'package:dro_patient_app/UI/OtherPages/CenterDetailsPage.dart';
import 'package:dro_patient_app/UI/Parts/Custom/MyCustomImage.dart';
import 'package:dro_patient_app/UI/Parts/Custom/MyPageRoute.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CenterAppointmentModel extends StatelessWidget {

  final String patientID,clinicID,centerID,channelID,name,address,centerPhone,speciality,fee,centerPhoto;
  final DateTime dateTime;

  CenterAppointmentModel({this.patientID, this.clinicID, this.centerID,
    this.channelID, this.name, this.address, this.centerPhone, this.speciality, this.fee,this.dateTime,this.centerPhoto});




  @override
  Widget build(BuildContext context) {
    double _fontSize = MediaQuery.of(context).size.width*0.04;
    return GestureDetector(
      onTap: ()=>MyPageRoute().fadeTransitionRouting(context,
          CenterDetailsPage(patientID,{"CENTER_ID":centerID,"NAME":name,"ADDRESS":address,"CENTER_PHONE":centerPhone,"SPECIALITY":speciality,"FEE":fee})),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          centerPhoto != '--' ? Padding(
            padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.02),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: MyCustomImage(
                width: MediaQuery.of(context).size.width*0.2,
                height: MediaQuery.of(context).size.width*0.2,
                image: "${imageLoc}PhotosOf/$centerPhoto",
              ),
            ),
          ) : Icon(Icons.local_hospital,size: MediaQuery.of(context).size.width*0.2,color: Colors.grey[300],),
          SizedBox(
            width: MediaQuery.of(context).size.width*0.57,
            child: Padding(
              padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.01),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                 Text(name, style: TextStyle(fontWeight: FontWeight.w500,fontSize: _fontSize)),
                  RichText(
                    text: TextSpan(
                        children:[
                          TextSpan(
                              text: "${DateFormat("yMMMEd").format(dateTime)}",
                              style: TextStyle(color: Colors.grey[600])
                          ),
                          TextSpan(text: ' . ',style: TextStyle(color: Colors.grey)),
                          TextSpan(
                              text: "${DateFormat("jm").format(dateTime)}",
                              style: TextStyle(color: Colors.grey[700])
                          ),
                        ]
                    ),
                  ),
                  Text(address),
                  Text(centerPhone),

                  Text(speciality,style: TextStyle(color: Colors.blue[900]),),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
