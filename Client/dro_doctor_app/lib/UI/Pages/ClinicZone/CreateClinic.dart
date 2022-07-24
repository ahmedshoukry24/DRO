import 'dart:math';

import 'package:dro_doctor_app/Model/ClinicModel.dart';
import 'package:dro_doctor_app/UI/Custom/CustomDialog.dart';
import 'package:dro_doctor_app/UI/Pages/Common/Schedule/SchedulePage.dart';
import 'package:dro_doctor_app/UI/Pages/Common/Schedule/setSchedulePage.dart';
import '../../../APIs/AllAboutClinic/createClinicAPI.dart';
import '../Home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'MainPages/ClinicHome.dart';


class CreateClinic extends StatefulWidget {
  final String doctorID;

  CreateClinic(this.doctorID);

  @override
  _CreateClinicState createState() => _CreateClinicState();
}

class _CreateClinicState extends State<CreateClinic> {

  TextEditingController _nameController;
  TextEditingController _phoneController;
  TextEditingController _addressController;
  TextEditingController _feeController;

  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  // ** API class
  CreateClinicAPI createClinicAPI = CreateClinicAPI();


  TextStyle textStyle = TextStyle(color: Colors.grey);
  TextStyle textStyle2 = TextStyle(color: Colors.blue);


  @override
  void initState() {
    super.initState();
    showAlertDialog();
    _nameController = TextEditingController();
    _phoneController = TextEditingController();
    _addressController = TextEditingController();
    _feeController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(title: Text('Create your clinic'),),
      body: body(),
    );
  }

  void showAlertDialog()async{
    await Future.delayed(Duration(milliseconds: 500));
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (context){
        return MyCustomDialog(
          title: Text('Alert',style: TextStyle(fontWeight: FontWeight.bold),),
          content: Text('If you leave the clinic name empty, it will take your name'),
          actions: <Widget>[
            FlatButton(
              child: Text('Ok'),
              onPressed: ()=>Navigator.pop(context),
            ),
          ],
        );
      },
    );
  }


  Widget body(){
    return Form(
      key: formKey,
      child: ListView(
        padding: EdgeInsets.all(20.0),
        children: <Widget>[
          TextFormField(
            controller: _nameController,
            decoration: InputDecoration(
              hintText: 'Clinic\'s Name',
              labelText: 'Name',
            ),
            keyboardType: TextInputType.text,
            validator: (value)=>null,
            onSaved: (value)=>_nameController.text = value,
          ),
          TextFormField(
            controller: _phoneController,
            decoration: InputDecoration(
                hintText: 'Clinic\'s Phone',
                labelText: 'Phone'
            ),
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.phone,
            validator: (value) => value.length == 11 &&
                ((value.startsWith('010')) ||
                    value.startsWith('011') ||
                    value.startsWith('012'))
                ? null
                : 'phone number should start with 010,011, or 012\n and contains 11 numbers',
            onSaved: (value)=>_phoneController.text = value,

          ),
          TextFormField(
            controller: _addressController,
            decoration: InputDecoration(
                hintText: 'Clinic\'s Address',
                labelText: 'Address'
            ),
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.done,
            validator: (value)=> value.isEmpty ? '' : null,
            onSaved: (value)=>_addressController.text = value,
          ),
          TextFormField(
            controller: _feeController,
            decoration: InputDecoration(
                hintText: 'Clinic\'s FEE',
                labelText: 'FEE'
            ),
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.done,
            validator: (value)=> value.isEmpty ? '' : null,
            onSaved: (value)=>_feeController.text = value,
          ),

          SizedBox(height: 20.0,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              RaisedButton(
                child: Text('Create'),
                onPressed: ()=>_createClinic(),
              ),
              FlatButton(
                child: Text('Cancel'),
                onPressed: (){
                  Navigator.pushAndRemoveUntil(context,
                      CupertinoPageRoute(builder: (context)=>Home(widget.doctorID,0,)),
                          (Route<dynamic>route)=>false);
                },
              ),
            ],
          )
        ],
      ),
    );
  }

  _createClinic()async{
    if(formKey.currentState.validate()){
      formKey.currentState.save();
      ClinicModel clinicModel;

      Random random = Random();

      String key = '${widget.doctorID}${_nameController.text.length}${random.nextInt(1000)}${_addressController.text.length}'
          '${random.nextInt(1000)}';

      clinicModel = await createClinicAPI.createClinic(
        doctorID: widget.doctorID,
        clinicName: _nameController.text.length < 1 ? '--' : _nameController.text,
        address: _addressController.text,
        phone: _phoneController.text,
        fee: _feeController.text,
        clinicKey: key,
      );
      Navigator.pop(context);
      Navigator.push(context,
          MaterialPageRoute(builder: (context)=>ClinicHome(clinicModel.clinicID,widget.doctorID)));
      Navigator.push(context, MaterialPageRoute(builder: (context)=>SchedulePage(clinicModel.clinicID,widget.doctorID,'-1')));
      Navigator.push(context,
          MaterialPageRoute(builder: (context)=>SetSchedulePage(clinicModel.clinicID,widget.doctorID,'-1',)));

    }
  }

}