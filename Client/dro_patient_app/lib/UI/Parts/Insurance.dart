import 'package:dro_patient_app/APIs/InsuranceAPI.dart';
import 'package:dro_patient_app/UI/Parts/Loader.dart';
import 'package:flutter/material.dart';

class InsuranceSection extends StatelessWidget{


  final InsuranceAPI insuranceAPI = InsuranceAPI();
  final String clinicID,centerID;

  InsuranceSection({Key key, this.clinicID, this.centerID}) : super(key: key);

  Widget build(BuildContext context) {
   return FutureBuilder(
     future: insuranceAPI.getInsurance(clinicID: clinicID,centerID: centerID),
     builder: (context,AsyncSnapshot ss){
       if(ss.hasError){
         print('Error');
       }
       if(ss.hasData){
         return insurance(ss.data,context);
       }else{
         return Loader();
       }
     },
   );
  }

  Widget insurance(List insuranceList,context){
    return Card(
      color: Colors.white.withOpacity(0.8),
      child: ExpansionTile(
        title: Text('Insurance'),
        subtitle: Text('${centerID == '-1' ? 'Insurance companies that the doctor deals with' : 'Insurance companies that the center deals with'}',style: TextStyle(color: Colors.grey),),
        children: [
          GridView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 5.0,
                  crossAxisSpacing: 0,
                  mainAxisSpacing: 0),
              itemCount: insuranceList.length,
              itemBuilder: (context,position){
                return Chip(label: Text('${insuranceList[position]['INSUR_NAME']}'),);
              }),
        ],
      ),
    );
  }

}