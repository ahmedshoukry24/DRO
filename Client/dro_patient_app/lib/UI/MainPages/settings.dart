import 'dart:io';
import 'package:dro_patient_app/UI/Parts/Custom/CustomDialog.dart';
import 'package:dro_patient_app/UI/Parts/Custom/MyCustomImage.dart';
import 'package:dro_patient_app/UI/Parts/Custom/SharedLoadingDialog.dart';
import 'package:dro_patient_app/UI/Style/style.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../../APIs/URL/mainURL.dart';
import '../../APIs/uploadImage/uploadImage.dart';
import '../../APIs/patientInfo.dart';
import '../../APIs/settingsAPI.dart';
import '../../Model/patient.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Settings extends StatefulWidget {

  final String _patientID;
  Settings(this._patientID);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {

  Style _style;


  SettingsAPI settingsAPI;
  PatientInfo patientInfo;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  // **** editing first and last name
  final formKey = new GlobalKey<FormState>();
  TextEditingController fNameController;
  TextEditingController lNameController;

  // **** editing password
  final formKey2 = GlobalKey<FormState>();
  TextEditingController pController;

  // **** editing phone
  final formKey3 = GlobalKey<FormState>();
  TextEditingController phoneController;

  UploadImage uploadImage;
  File image;
  bool show= false;
  @override
  void initState() {
    super.initState();
    settingsAPI = SettingsAPI();
    patientInfo = PatientInfo();
    uploadImage = UploadImage();
    _style = Style();
  }


  @override
  Widget build(BuildContext context){
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body:FutureBuilder(
        future: patientInfo.getPatientInfo(widget._patientID),
        builder: (context,ss){
          if(ss.hasError){
            print('Settings Page :::: Done ::: has error');
          }
          if(ss.hasData){
            return body(ss.data);
          }else{
            print('Settings Page :::: Done ::: else (ss.hasData)');
            return SpinKitRipple(color: Colors.blue[800],);
          }
        },
      ),
    );
  }
  Widget body(Patient patient){
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          GestureDetector(
            onTap: ()async{
              showDialog(context: context,builder: (context){
                return SharedLoadingDialog().loading(context);
              },barrierDismissible: false);
              image = await uploadImage.getImage(widget._patientID);
              if(image != null){
                Navigator.pop(context);
               setState(() {
                 show = true;
               });
              }else{
                Navigator.pop(context);
              }
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: _style.getWidthSize(context)*0.5,
                height: _style.getWidthSize(context)*0.5,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(25),
                  child: image ==null ? MyCustomImage(
                    width: _style.getWidthSize(context)*0.5,
                    height: _style.getWidthSize(context)*0.5,
                    image: '${imageLoc}patientImages/${patient.profilePicture}',
                  ) : Image.file(image,fit: BoxFit.cover,)
                ),
              ),
            ),
          ),
          show ? FlatButton(
            child: Text('Save'),
            onPressed: ()async{
              showDialog(context: context,builder: (context){
                return SharedLoadingDialog().loading(context);
              },
                barrierDismissible: false
              );
              bool isUploaded = await uploadImage.upload(image);
              if(isUploaded){
                bool result = await settingsAPI.updateImage(patientID: widget._patientID, imageName: uploadImage.imageName);
                if(result){
                  Navigator.pop(context);
                  setState(() {
                    show = false;
                  });
                }
              }
            },
          ):Container(),

          ListTile(
            title: Text('Email Address'),
            subtitle: Text('${patient.email}'),
          ),
          Divider(indent: 50,endIndent: 50,height: 0.0,),
          ListTile(
            title: Text('Name'),
            subtitle: Text('${patient.fName} ${patient.lName}'),
            trailing: Icon(Icons.edit),
            onTap: ()=>editingName(patient),
          ),
          Divider(indent: 50,endIndent: 50,height: 0.0,),
          ListTile(
            title: Text('Password'),
            trailing: Icon(Icons.edit),
            onTap: ()=>editPassword(patient),
          ),
          Divider(indent: 50,endIndent: 50,height: 0.0,),
          ListTile(
            title: Text('Phone'),
            subtitle:Text('${patient.phone}'),
            trailing: Icon(Icons.edit),
            onTap: ()=>editPhone(patient),
          ),
          Divider(indent: 50,endIndent: 50,height: 0.0,),
          ListTile(
            title: Text('Birth date'),
            subtitle:Text('${patient.date}'),
          ),
        ],
      ),
    );
  }

  editingName(Patient patient) {
    fNameController = TextEditingController(text: patient.fName);
    lNameController = TextEditingController(text: patient.lName);
    showDialog(context: context,builder: (context){
      return MyCustomDialog(
        title: Text('Change Name',style: TextStyle(color: Colors.blue[800]),),
        content: Form(
          key: formKey,
          child: Row(
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller:fNameController,
                    validator: (value)=>value.isEmpty ? '' : null,
                    onSaved: (value)=>fNameController.text = value,
                    keyboardType: TextInputType.text,
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: lNameController,
                    validator: (value)=>value.isEmpty ? '' : null,
                    onSaved: (value)=>lNameController.text = value,
                    keyboardType: TextInputType.text,
                  ),
                ),
              ),
            ],
          ),
        ),
        actions: [
          FlatButton(
            child: Text('Cancel'),
            onPressed: ()=>Navigator.pop(context),
          ),
          FlatButton(
            child: Text('Save'),
            onPressed: ()async{
              if(formKey.currentState.validate()){
                formKey.currentState.save();
                int result = await settingsAPI.editName(
                  newFName:fNameController.text,
                  newLName:lNameController.text,
                  email: patient.email,
                  id: patient.id,
                );
                if(result == 1){
                  Navigator.pop(context);
                  setState(() {

                  });
                }
              }
            },
          ),
        ],
      );
    });
  }

  editPassword(Patient patient) {
    pController = TextEditingController(text: patient.password);
    showDialog(context: context,builder: (context){
      return MyCustomDialog(
        title: Text('Change Password',style: TextStyle(color: Colors.blue[800]),),
        content: Form(
          key: formKey2,
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: TextFormField(
              controller: pController,
              validator: (value)=>(value.isEmpty || value.length<6) ? '' : null,
              onSaved: (value)=>pController.text = value,
              keyboardType: TextInputType.text,
            ),
          ),
        ),
        actions: [
          FlatButton(
            child: Text('Cancel'),
            onPressed: ()=>Navigator.pop(context),
          ),
          FlatButton(
            child: Text('Save'),
            onPressed: ()async{
              if(formKey2.currentState.validate()){
                formKey2.currentState.save();
                int result = await settingsAPI.editPassword(newPassword: pController.text,email: patient.email,id: patient.id);
                if(result == 1){
                  Navigator.pop(context);
                  setState(() {

                  });
                }
              }
            },
          ),
        ],
      );
    });
  }

  editPhone(Patient patient) {
    phoneController = TextEditingController(text: patient.phone);
    showDialog(context: context,builder: (context){
      return MyCustomDialog(
        title:Text('Change Phone',style: TextStyle(color: Colors.blue[800]),),
      content: Form(
        key: formKey3,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            controller: phoneController,
            textInputAction: TextInputAction.next,
            validator: (value) => value.length == 11 &&
                ((value.startsWith('010')) ||
                    value.startsWith('011') ||
                    value.startsWith('012'))
                ? null
                : '',
            onSaved: (value) => phoneController.text = value,
            keyboardType: TextInputType.phone,
          ),
        ),
      ),
        actions: [
          FlatButton(
            child: Text('Cancel'),
            onPressed: ()=>Navigator.pop(context),
          ),
          FlatButton(
            child: Text('Save'),
            onPressed: ()async{
              if(formKey3.currentState.validate()){
                formKey3.currentState.save();
                int result = await settingsAPI.editPhone(newPhone: phoneController.text,email:  patient.email,id: patient.id);
                if(result == 1){
                  Navigator.pop(context);
                  setState(() {

                  });
                }
              }
            },
          )
        ],
      );
    });

  }



}
