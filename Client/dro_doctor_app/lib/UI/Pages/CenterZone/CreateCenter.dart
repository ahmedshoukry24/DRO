
import 'dart:math';
import 'package:dro_doctor_app/APIs/AllAboutCenter/createCenterAPI.dart';
import 'package:dro_doctor_app/APIs/doctorInfoAPI.dart';
import 'package:dro_doctor_app/APIs/uploadImage/uploadImage.dart';
import 'package:dro_doctor_app/Model/CenterModel.dart';
import 'package:dro_doctor_app/Model/doctor.dart';
import 'package:dro_doctor_app/UI/Custom/MyPageRoute.dart';
import 'package:dro_doctor_app/UI/Pages/CenterZone/adminView/AdminHomePage.dart';

import 'package:dro_doctor_app/UI/Pages/Common/Schedule/SchedulePage.dart';
import 'package:dro_doctor_app/UI/Pages/Common/Schedule/setSchedulePage.dart';

import '../Home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'adminView/CenterSettingsPage.dart';


class CreateCenter extends StatefulWidget {
  final String doctorID;

  CreateCenter(this.doctorID);

  @override
  _CreateCenterState createState() => _CreateCenterState();
}

class _CreateCenterState extends State<CreateCenter> {

  TextEditingController _nameController;
  TextEditingController _phoneController;
  TextEditingController _addressController;
  TextEditingController _feeController;

  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();



  TextStyle textStyle = TextStyle(color: Colors.grey);
  TextStyle textStyle2 = TextStyle(color: Colors.blue);



  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _phoneController = TextEditingController();
    _addressController = TextEditingController();
    _feeController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(title: Text('Create your center'),),
      body: body(),
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
            validator: (value)=> value.length < 3 ? '': null,
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
                hintText: 'FEE',
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
                onPressed: ()=>_createBtn(),
              ),
              FlatButton(
                child: Text('Cancel'),
                onPressed: (){
                  Navigator.pushAndRemoveUntil(context,
                      CupertinoPageRoute(builder: (context)=>Home(widget.doctorID, 0,)),
                          (Route<dynamic>route)=>false);
                },
              ),
            ],
          )
        ],
      ),
    );
  }

  _createBtn()async{
    if(formKey.currentState.validate()){
      formKey.currentState.save();

      DoctorModel doctorModel;

      doctorModel = await DoctorInfoAPI().getDoctorInfo(widget.doctorID);

      Random random = Random();

      String key = '${doctorModel.id}${_nameController.text.length}${random.nextInt(1000)}${_addressController.text.length}'
          '${random.nextInt(1000)}';

      if(doctorModel.id == widget.doctorID){
        CenterModel centerModel = await CreateCenterAPI().createCenterAPI(
          doctorModel.id,
          doctorModel.specialty,
          _nameController.text,
          _phoneController.text,
          _addressController.text,
          _feeController.text,
          key,
        );
        if(centerModel.centerKey != '0'){
          Navigator.pop(context);
          MyPageRoute().routeNow(context, AdminHomePage(widget.doctorID,centerModel.centerID,doctorModel.id));

         MyPageRoute().routeNow(context, CenterSettings(
             doctorModel.id,
             centerModel.centerID,
             widget.doctorID
         ));
          MyPageRoute().routeNow(context, SchedulePage('-1',widget.doctorID,centerModel.centerID));
          MyPageRoute().routeNow(context, SetSchedulePage('-1',widget.doctorID,centerModel.centerID));

        }else{
          print('There\'s something wrong');
        }
      }else{
        print('There\'s something wrong');
      }
    }
  }



}