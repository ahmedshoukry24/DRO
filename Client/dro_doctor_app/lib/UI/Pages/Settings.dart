import 'dart:io';
import 'package:dro_doctor_app/APIs/mainURL/mainURL.dart';
import 'package:dro_doctor_app/APIs/uploadImage/uploadImage.dart';
import 'package:dro_doctor_app/UI/Custom/CustomDialog.dart';
import 'package:dro_doctor_app/UI/Custom/MyCustomImage.dart';
import 'package:dro_doctor_app/UI/Custom/SharedDialog.dart';
import '../../APIs/doctorInfoAPI.dart';
import '../../APIs/settingsAPI.dart';
import '../../Model/doctor.dart';
import '../../OfflineDatabase/helper.dart';
import '../../UI/LoginPage.dart';
import 'package:flutter/material.dart';


class Settings extends StatefulWidget {

  final String doctorID;

  Settings(this.doctorID);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {

  final scaffoldKey = GlobalKey<ScaffoldState>();
  DoctorInfoAPI _doctorInfo =DoctorInfoAPI();
  SettingsAPIs settingsAPIs = SettingsAPIs();

  File image;
  bool show = false;

  // ** editing first and last name
  final formKey = GlobalKey<FormState>();
  TextEditingController fNC ;
  TextEditingController lNC ;

  // ** editing phone number
  final formKey2 = GlobalKey<FormState>();
  TextEditingController pC;

  // ** editing password
  final formKey3 = GlobalKey<FormState>();
  TextEditingController passwordController;

  DatabaseHelper db = DatabaseHelper();
  UploadImage uploadImage = UploadImage();

  @override
  Widget build(BuildContext context){
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Row(
          children: <Widget>[
            Icon(Icons.settings,color: Colors.blue[800],),
            SizedBox(width: 10,),
            Text('Settings'),
          ],
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: ()=>_alert(context),
          ),
        ],
      ),
      body: FutureBuilder(
        future: _doctorInfo.getDoctorInfo(widget.doctorID),
        builder: (context,ss){
          if(ss.hasError){
            print('Error settings has error');
          }
          if(ss.hasData){
            DoctorModel doctor = ss.data;

            return ListView(
              children: <Widget>[
                // *** account settings
                Card(
                  elevation: 5.0,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Account Settings',style: TextStyle(fontSize: 20,color: Colors.blue[900]),),
                  ),
                ),
                _editProfilePicture(doctor.profilePicture),
                ListTile(title: Text('About'),subtitle:Text('${doctor.bio}',overflow: TextOverflow.ellipsis,maxLines: 2,),trailing: Icon(Icons.edit), onTap: ()=>_editAbout(doctor)),
                ListTile(title: Text('Email Address'), subtitle: Text('${doctor.email}'),),
                Divider(endIndent: 20.0,indent: 20.0,height: 0.0),
                ListTile(title: Text('Specialty'), subtitle: Text('${doctor.specialty}'),),
                Divider(endIndent: 20.0,indent: 20.0,height: 0.0),
                ListTile(title: Text('Title'), subtitle: Text('${doctor.title}'),),
                Divider(endIndent: 20.0,indent: 20.0,height: 0.0),
                ListTile(title: Text('Gender'), subtitle: Text('${doctor.gender}'),),
                Divider(endIndent: 20.0,indent: 20.0,height: 0.0),
                ListTile(title: Text('Birth Date'), subtitle: Text('${doctor.date}'),),
                Divider(endIndent: 20.0,indent: 20.0,height: 0.0),
                ListTile(
                  title: Text('Name'),
                  subtitle: Text('${doctor.fName} ${doctor.lName}'),
                  trailing: Icon(Icons.edit),
                  onTap: ()=>editName(doctor),
                ),
                Divider(endIndent: 20.0,indent: 20.0,height: 0.0),
                ListTile(
                  title: Text('Phone'),
                  subtitle: Text('${doctor.phone}'),
                  trailing: Icon(Icons.edit),
                  onTap: ()=>editPhone(doctor),
                ),
                Divider(endIndent: 20.0,indent: 20.0,height: 0.0),
                ListTile(
                  title: Text('Password'),
                  subtitle: Text('*******'),
                  trailing: Icon(Icons.edit),
                  onTap: ()=>editPassword(doctor),
                ),
              ],
            );
          }else{
            return Center(child: Text('Loading...'));
          }
        },
      ),
    );
  }

  // ** edit name, phone, and password **
  editName(DoctorModel doctor){
    fNC = TextEditingController(text:doctor.fName);
    lNC = TextEditingController(text:doctor.lName);
    showDialog(context: context,builder: (context){
      return MyCustomDialog(
        title: Text('Change Name',style: TextStyle(color: Colors.blue[800]),),
        content: Form(
          key: formKey,
          child: Row(
            children: <Widget>[
              Expanded(
                child: TextFormField(
                  controller: fNC,
                  validator: (value) =>
                  value.length < 2 ? '' : null,
                  onSaved: (value) => fNC.text = value,
                  keyboardType: TextInputType.text,
                ),
              ),
              SizedBox(width: 10,),
              Expanded(
                child: TextFormField(
                  controller: lNC,
                  validator: (value) =>
                  value.length < 2 ? '' : null,
                  onSaved: (value) => lNC.text = value,
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
                  showDialog(context: context,barrierDismissible: false,builder: (context){
                    return  SharedLoadingDialog().loading(context);
                  });
                  formKey.currentState.save();
                  int result = await settingsAPIs.editName(email:doctor.email,newFName:fNC.text,newLName:lNC.text,id: doctor.id);
                  if(result==1){
                    Navigator.pop(context);
                    Navigator.pop(context);
                    setState(() {

                    });
                  }else print('Something error in editing name');
                }
              }
          ),
        ],

      );
    });
  }
  editPhone(DoctorModel doctor){
    pC = TextEditingController(text:doctor.phone);
    showDialog(context: context,builder: (context){
      return MyCustomDialog(
        title: Text('Change Phone',style: TextStyle(color: Colors.blue[800]),),
        content: Form(
          key: formKey2,
          child: TextFormField(
            controller: pC,
            validator: (value) => value.length == 11 &&
                ((value.startsWith('010')) ||
                    value.startsWith('011') ||
                    value.startsWith('012'))
                ? null
                : '',
            onSaved: (value) => pC.text = value,
            keyboardType: TextInputType.phone,
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
                  showDialog(context: context,barrierDismissible: false,builder: (context){
                    return  SharedLoadingDialog().loading(context);
                  });
                  formKey2.currentState.save();
                  int result = await settingsAPIs.editPhone(email: doctor.email,newPhone: pC.text,id: doctor.id);
                  if(result==1){
                    Navigator.pop(context);
                    Navigator.pop(context);
                    setState(() {

                    });
                  }else print('Something error in changing phone');
                }
              }
          ),
        ],
      );
    });
  }
  editPassword(DoctorModel doctor){
    passwordController = TextEditingController(text:doctor.password);
   showDialog(
     context: context,
     builder: (context){
       return MyCustomDialog(
         title: Text('Change Password',style: TextStyle(color: Colors.blue[800]),),
         content: Form(
           key: formKey3,
           child: Padding(
             padding: const EdgeInsets.all(8.0),
             child: TextFormField(
               controller: passwordController,
               validator: (value) => value.length >= 5
                   ? null
                   : '',
               onSaved: (value) => passwordController.text = value,
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
                   showDialog(context: context,barrierDismissible: false,builder: (context){
                     return  SharedLoadingDialog().loading(context);
                   });
                   formKey3.currentState.save();
                   int result = await settingsAPIs.editPassword(email:doctor.email,newPassword:passwordController.text,id:doctor.id);
                   if(result==1){
                     Navigator.pop(context);
                     Navigator.pop(context);
                     setState(() {

                     });
                   }else print('Something error in changing password ');
                 }
               }
           ),
         ],
       );
     }
   );
  }
  _editProfilePicture(String pp) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: GestureDetector(
                  onTap: ()async{
                    showDialog(context: context,builder: (context){return SharedLoadingDialog().loading(context);});
                    image = await uploadImage.getImage('G').whenComplete((){
                      Navigator.of(context).pop();
                      setState(() {
                        show = true;
                      });
                    });
                  },
                  child: image ==null? MyCustomImage(
                    image: '${imageLoc}doctorImages/$pp',
                    width: MediaQuery.of(context).size.width/2,
                    height: MediaQuery.of(context).size.width/2,
                  ):Image(
                    width: MediaQuery.of(context).size.width/2,
                    height: MediaQuery.of(context).size.width/2,
                    image: FileImage(image),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
        ),
        show ? FlatButton(
          child: Text('Save'),
          onPressed: ()async{
            showDialog(context: context,builder: (context){return SharedLoadingDialog().loading(context);});
            await uploadImage.upload(image,'D').then((value)async{
              if(value){
                await settingsAPIs.updateImage(doctorID: widget.doctorID,
                    imageName: uploadImage.imageName).then((value){
                  if(value){
                    Navigator.pop(context);
                    setState(() {
                      show = false;
                    });
                  }
                });
              }else{
                showDialog(context: context,builder: (context){return SharedLoadingDialog().loading(context);});
              }
            });
          },
        ) : Container()
      ],
    );
  }

  _alert(context){
    return showDialog(
      context: context,
      builder: (context){
        return MyCustomDialog(
          title: Text('Are you sure you want to logout!',style: TextStyle(fontWeight: FontWeight.bold),),
          actions: [
            Padding(
              padding: const EdgeInsets.all(3.0),
              child: RaisedButton(
                color: Colors.blue[800],
                textColor: Colors.white,
                shape: OutlineInputBorder(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(25),
                        topLeft: Radius.circular(25)
                    ),
                  borderSide: BorderSide.none
                ),
                child: Text('Yes'),
                onPressed: (){
                  db.deleteUser('1');
                  Navigator.pushAndRemoveUntil(context,
                      MaterialPageRoute(builder: (context)=>LoginPage()),
                          (Route<dynamic>route)=>false
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(3.0),
              child: RaisedButton(
                shape: OutlineInputBorder(
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(25),
                      topRight: Radius.circular(25)
                  ),
                    borderSide: BorderSide.none

                ),
                child: Text('No'),
                onPressed: ()=>Navigator.pop(context),
              ),
            ),
          ],
        );
      }
    );
  }




  _editAbout(DoctorModel doctor){
    TextEditingController aboutController = TextEditingController(text: doctor.bio);
    showDialog(context: context,builder: (context){
      return MyCustomDialog(
        title: Text('About'),
        content: TextField(
          maxLines: 3,
          minLines: 1,
          controller: aboutController,
        ),
        actions: [
          FlatButton(
              child: Text('Cancel'),
              onPressed: ()=>Navigator.pop(context)
          ),
          FlatButton(
            child: Text('Save'),
            onPressed: ()async{
             showDialog(context: context,barrierDismissible: false,builder: (context){
               return  SharedLoadingDialog().loading(context);
             });
              await settingsAPIs.editBio(doctorID: widget.doctorID,bio: aboutController.text).then((value){
                if(value){
                  Navigator.pop(context);
                  Navigator.pop(context);
                  setState(() {

                  });
                }
              });
            },
          ),

        ],
      );
    });
  }

}

