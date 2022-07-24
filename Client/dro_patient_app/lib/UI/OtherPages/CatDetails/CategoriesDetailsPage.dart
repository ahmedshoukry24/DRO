import 'package:dro_patient_app/UI/Style/style.dart';
import 'package:flutter/material.dart';

import 'CatCentersPage.dart';
import 'CatClinicsPage.dart';

class CatDetailsPage extends StatefulWidget {
  final String patientID, category;

  CatDetailsPage(this.patientID,this.category);

  @override
  _CatDetailsPageState createState() => _CatDetailsPageState();
}

class _CatDetailsPageState extends State<CatDetailsPage> {

  Widget currentState ;

  @override
  void initState() {
    super.initState();
    currentState = CatClinicsPage(widget.patientID,widget.category);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text('${widget.category}',),
          actions: <Widget>[
            _popUpMenu()
          ],
        ),
        body: currentState,
      ),
    );
  }

  Widget _popUpMenu(){
    return PopupMenuButton<String>(
      itemBuilder: (context){
        return [
          PopupMenuItem<String>(
            child: Text('Clinic'),
            value: 'Clinic',
          ),
          PopupMenuItem<String>(
            child: Text('Center'),
            value: 'Center',
          ),
        ];
      },
      onSelected: (value){
        switch (value){
          case 'Clinic':
            setState(() {
              currentState = CatClinicsPage(widget.patientID,widget.category);
            });
            break;
          case 'Center':
            setState(() {
              currentState = CatCentersPage(widget.patientID,widget.category);
            });
            break;
        }
      },
    );
  }

}
