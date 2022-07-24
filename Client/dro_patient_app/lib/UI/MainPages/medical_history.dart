import 'dart:math';
import 'package:dro_patient_app/APIs/MedicalRecordAPI.dart';
import 'package:dro_patient_app/APIs/URL/mainURL.dart';
import 'package:dro_patient_app/UI/Parts/Custom/MyCustomImage.dart';
import 'package:dro_patient_app/UI/Parts/Custom/MyPageRoute.dart';
import 'package:dro_patient_app/UI/Parts/imagePage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';


class MedicalHistory extends StatelessWidget{
  final String _patientID;
  MedicalHistory(this._patientID);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: <Widget>[
            Icon(Icons.history),
            SizedBox(width: 10,),
            Text('Medical History'),
          ],
        ),
      ),
      body: FutureBuilder(
        future: MedicalRecordAPI().getMedicalRecord(_patientID),
        builder: (context,AsyncSnapshot ss){
          if(ss.hasError){
            print('Error medical history');
          }
          if(ss.hasData){
            List myData = ss.data;
            return ListView.builder(
              itemCount: myData.length,
                itemBuilder: (context,position){
              return medicalCard(myData[position],context);
            });
          }else{
            return SpinKitRipple(color: Colors.blue[800],);
          }
        },
      ),
    );
  }

  Widget medicalCard(Map item,context){
    DateTime dateTime = DateFormat("yyyy-M-d H:m:s").parse(item['DATE_TIME']);
    int tag = Random().nextInt(100000);

    return Card(
      elevation: 5,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // item['DATE_TIME']
          Padding(
            padding: const EdgeInsets.only(top: 5.0,left: 5.0,right: 5.0),
            child: Text('${item['FIRST_NAME']} ${item['LAST_NAME']}',style: TextStyle(fontWeight: FontWeight.w500),),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 5.0,left: 5.0,right: 5.0),
            child: Text('${DateFormat('yMMMd').format(dateTime)} . ${DateFormat('jm').format(dateTime)}',style: TextStyle(color: Colors.grey[700]),),
          ),
          Container(
            color: Colors.grey[100],
              child: item['DESCRIPTION'] != '--'?Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('${item['DESCRIPTION']}'),
              ): Container()) ,
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: GestureDetector(
              child: Hero(
                tag: tag,
                child: item['IMAGE'] != '--' ? MyCustomImage(image: '${imageLoc}prescriptionImage/${item['IMAGE']}',
                  height: MediaQuery.of(context).size.width/2,
                  width: MediaQuery.of(context).size.width/3,) : Container(),
              ),
              onTap: ()=>MyPageRoute().fadeTransitionRouting(context,
                  ImageView('${imageLoc}prescriptionImage/${item['IMAGE']}',tag)),
            ),
          )

        ],
      ),
    );
  }

}