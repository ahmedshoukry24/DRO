import 'package:dro_patient_app/APIs/CentersAPI.dart';
import 'package:dro_patient_app/UI/Parts/CenterCard.dart';
import 'package:dro_patient_app/UI/Parts/Loader.dart';
import 'package:flutter/material.dart';

class CatCentersPage extends StatelessWidget {
  final String patientID, category;
  CatCentersPage(this.patientID,this.category);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: CentersAPI().getCenter('$category'),
      builder: (context,ss){
        if(ss.hasError){
          print('Error');
        }
        if(ss.hasData){
          List resCenters = ss.data;
          return ListView.builder(
              itemCount:resCenters.length,
              itemBuilder: (context,position){
                return CenterCard(patientID,resCenters[position]);
              });
        }else{
          return Loader();
        }
      },
    );
  }
}
