import 'package:dro_patient_app/APIs/URL/mainURL.dart';
import 'package:dro_patient_app/UI/OtherPages/ClinicDetailsPage.dart';
import 'package:dro_patient_app/UI/Parts/Custom/MyCustomImage.dart';
import 'package:dro_patient_app/UI/Parts/Custom/MyPageRoute.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ClinicAppointmentModel extends StatelessWidget{
  final String patientID,clinicID,centerID,channelID,clinicName,
      doctorID,address,clinicPhone,fee,firstName,lastName,speciality,profilePicture;
  final DateTime dateTime;

  ClinicAppointmentModel({this.patientID, this.clinicID, this.centerID,this.channelID,
    this.clinicName, this.doctorID, this.address, this.clinicPhone,
      this.fee, this.firstName, this.lastName, this.speciality, this.profilePicture,this.dateTime});



  @override
  Widget build(BuildContext context){
    double _fontSize = MediaQuery.of(context).size.width*0.04;
    return  GestureDetector(

      onTap: ()=>MyPageRoute().fadeTransitionRouting(context,ClinicDetailsPage(patientID,clinicID)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // image ***
          Padding(
            padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.02),
            child: profilePicture != '--' ? ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: MyCustomImage(
                image: "${imageLoc}doctorImages/$profilePicture",
                width: MediaQuery.of(context).size.width*0.2,
                height: MediaQuery.of(context).size.width*0.2,
              ),
            ): Container(),
          ) ,
          // column ***
          SizedBox(
            width: MediaQuery.of(context).size.width*0.57,
            child: Padding(
              padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.01),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(clinicName == '--' ? "Dr. $firstName $lastName" : clinicName,
                    style: TextStyle(fontWeight: FontWeight.w500,fontSize: _fontSize),),
                  clinicName == '--' ? Container() : Text("Dr. $firstName $lastName",),
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
                  Text(clinicPhone),
                  Text(speciality,style: TextStyle(color: Colors.blue[900],fontSize: _fontSize),),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
