import 'package:dro_patient_app/APIs/ClinicsAPI.dart';
import 'package:dro_patient_app/UI/Parts/ClinicCard.dart';
import 'package:dro_patient_app/UI/Parts/Loader.dart';
import 'package:flutter/material.dart';

class CatClinicsPage extends StatelessWidget {

  final String patientID, category;
  CatClinicsPage(this.patientID,this.category);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: ClinicsAPI().getClinics('$category'),
      builder: (context,ss){
        if(ss.hasError){
          print('Error');
        }
        if(ss.hasData){
          List resClinics = ss.data;
          return ListView.builder(
            itemCount:resClinics.length ,
              itemBuilder: (context,position){
            return ClinicCard(
              patientID,
              resClinics[position]
            );
          });
        }else{
          return Loader();
        }
      },
    );
  }
}
