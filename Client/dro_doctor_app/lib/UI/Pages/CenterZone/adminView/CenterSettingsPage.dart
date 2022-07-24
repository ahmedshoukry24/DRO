import 'dart:io';

import 'package:dro_doctor_app/APIs/AllAboutCenter/Settings.dart';
import 'package:dro_doctor_app/APIs/mainURL/mainURL.dart';
import 'package:dro_doctor_app/APIs/uploadImage/uploadImage.dart';
import 'package:dro_doctor_app/UI/Custom/CustomDialog.dart';
import 'package:dro_doctor_app/UI/Custom/MyCustomImage.dart';
import 'package:dro_doctor_app/UI/Custom/MyPageRoute.dart';
import 'package:dro_doctor_app/UI/Custom/SharedDialog.dart';
import 'package:dro_doctor_app/UI/Pages/Common/PhotosOf.dart';
import 'package:dro_doctor_app/UI/Pages/Common/Schedule/SchedulePage.dart';
import 'package:dro_doctor_app/UI/Style/StyleFile.dart';
import 'package:fleva_icons/fleva_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CenterSettings extends StatefulWidget {

  final String centerID,doctorID,docAdmin;

  CenterSettings(this.doctorID,this.centerID,this.docAdmin);

  @override
  _CenterSettingsState createState() => _CenterSettingsState();
}

class _CenterSettingsState extends State<CenterSettings> {


  // Style
  Style style;

  UploadImage _uploadImage;
  CenterSettingsAPI centerSettingsAPI;
  File _image;
  bool show = false;
  TextEditingController nameController;
  TextEditingController centerPhoneController;
  final formKey = GlobalKey<FormState>();
  final formKey2 = GlobalKey<FormState>();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _uploadImage = UploadImage();
    centerSettingsAPI = CenterSettingsAPI();
    style = Style();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Center Settings'),
      ),
      body: ListView(
        shrinkWrap: true,
        children: [
          FutureBuilder(
            future: centerSettingsAPI.getCenterInfo(centerID: widget.centerID),
            builder: (context,ss){
              if(ss.hasError){
                print('Error');
              }
              if(ss.hasData){
                Map myData = ss.data;
                return ListView(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  children: <Widget>[
                    _imageWidget(myData['CENTER_PHOTO']),
                    ListTile(
                      title: Text('Name'),
                      subtitle: Text('${myData['NAME']}'),
                      leading: Icon(Icons.home,color: style.iconColor,),
                      trailing: IconButton(
                        icon: Icon(FlevaIcons.edit_2_outline),
                        onPressed: ()=>_changeName(myData['NAME']),
                      ),
                    ),
                    ListTile(
                      title: Text('Phone'),
                      subtitle: Text('${myData['CENTER_PHONE']}'),
                      leading: Icon(Icons.phone,color: style.iconColor),
                      trailing: IconButton(
                        icon: Icon(FlevaIcons.edit_2_outline),
                        onPressed: ()=>_changeCenterPhone(myData['CENTER_PHONE']),
                      ),
                    ),
                  ],
                );
              }
              else{
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircularProgressIndicator(),
                  ],
                );
              }
            },
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Text('Center schedule'),
                subtitle: Text('See & Edit Center Schedule.'),
                onTap: ()=>MyPageRoute().routeNow(context, SchedulePage('-1',widget.doctorID,widget.centerID)),
                leading: Icon(FlevaIcons.calendar_outline,color: style.iconColor),
              ),
              Text('Photos of center'),
              PhotosOf('-1',widget.centerID)
            ],
          ),
        ],
      ),
    ) ;
  }



  void _changeName(String name) {
    nameController = TextEditingController(text: name);
    showDialog(context: context,builder: (context){
      return  MyCustomDialog(
        title: Text('Change name'),
        content: Form(
          key: formKey,
          child: TextFormField(
            controller: nameController,
            validator: (value)=>value.length > 2 ? null : 'Enter a valid name',
            onSaved: (value)=>nameController.text = value,
          ),
        ),
        actions: [
          FlatButton(
            child: Text('Save'),
            onPressed: ()async{
              if(formKey.currentState.validate()){
                formKey.currentState.save();
                await centerSettingsAPI.updateName(centerID: widget.centerID,centerName: nameController.text).then((value){
                  if(value){
                    Navigator.pop(context);
                    setState(() {

                    });
                  }
                });

              }
            },
          )
        ],
      );
    });
  }

  Widget _imageWidget(String image) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: GestureDetector(
              child: _image==null? MyCustomImage(
                image: "${imageLoc}PhotosOf/$image",
                height: MediaQuery.of(context).size.width*0.3,
                width: MediaQuery.of(context).size.width*0.3,
                secImg: '',
              ) : Image(
                image: FileImage(_image),
                height: MediaQuery.of(context).size.width*0.3,
                width: MediaQuery.of(context).size.width*0.3,
                fit: BoxFit.cover,
              ),
              onTap: ()async{
                showDialog(context: context,builder: (context){return SharedLoadingDialog().loading(context);});
                _image = await _uploadImage.getImage('G').whenComplete((){
                  Navigator.of(context).pop();
                  setState(() {
                    show = true;
                  });
                });
              },
            ),
          ),
        ),
        show?FlatButton(
          child: Text('Save'),
          onPressed: ()async{
            showDialog(context: context,builder: (context){return SharedLoadingDialog().loading(context);});
            await _uploadImage.upload(_image, "OF").then((value)async{
              if(value){
                await centerSettingsAPI.updateCenterImage(centerID: widget.centerID,image: _uploadImage.imageName).then((value){
                  Navigator.pop(context);
                  setState(() {
                    show = false;
                  });
                });
              }else{
                Navigator.pop(context);
                showDialog(context: context,builder: (context){return SharedLoadingDialog().loading(context);});
              }
            });
          },
        ) :Container()
      ],
    );
  }

  _changeCenterPhone(String centerPhone) {
    centerPhoneController= TextEditingController(text: centerPhone);
    showDialog(context: context,builder: (context){
      return MyCustomDialog(
        title: Text('Change Phone'),
        content: Form(
          key: formKey2,
          child: TextFormField(
            controller: centerPhoneController,
            validator: (value) => value.length == 11 &&
                ((value.startsWith('010')) ||
                    value.startsWith('011') ||
                    value.startsWith('012'))
                ? null
                : 'phone number should start with 010,011, or 012\n and contains 11 numbers',
            onSaved: (value)=>centerPhoneController.text = value,
          ),
        ),
        actions: [
          FlatButton(
            child: Text('Save'),
            onPressed: ()async{
              if(formKey2.currentState.validate()){
                formKey2.currentState.save();
                await centerSettingsAPI.updateCenterPhone(centerID: widget.centerID,centerPhone: centerPhoneController.text).then((value){
                  if(value){
                    Navigator.pop(context);
                    setState(() {

                    });
                  }
                });

              }
            },
          )
        ],
      );
    });


  }

}
