import 'package:dro_patient_app/APIs/SearchAPI/SearchAPI.dart';
import 'package:dro_patient_app/UI/Parts/ClinicCard.dart';
import 'package:dro_patient_app/UI/Style/style.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';

class SearchByName extends StatefulWidget {

  final String patientID;

  SearchByName(this.patientID);

  @override
  _SearchByNameState createState() => _SearchByNameState();
}

class _SearchByNameState extends State<SearchByName>{

  List result=[];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 8.0,
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: IconButton(icon: Icon(Icons.close),onPressed: ()=>Navigator.pop(context),),
        title: SizedBox(
          height: Style().getWidthSize(context)*0.09,
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Enter doctor name',
              contentPadding: EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
              filled: true,
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(50)
              )
            ),
            onChanged: (txt)async{
              await SearchAPI().getDoctorByName(txt).then((value){
                setState(() {
                  result = value;
                });
              });
            },
          ),
        ),
        ),
      body: ListView.builder(
      shrinkWrap: true,
      itemCount: result.length,
      itemBuilder: (context,position){
        return ClinicCard(
          widget.patientID,
          result[position]
        );
      }),
    );
  }
}
