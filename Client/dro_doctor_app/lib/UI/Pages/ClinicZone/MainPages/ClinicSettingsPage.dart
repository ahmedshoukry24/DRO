import 'package:dro_doctor_app/APIs/AllAboutClinic/Settings.dart';
import 'package:dro_doctor_app/APIs/AllAboutClinic/clinicInfoAPI.dart';
import 'package:dro_doctor_app/UI/Custom/CustomDialog.dart';
import 'package:dro_doctor_app/UI/Pages/Common/PhotosOf.dart';
import 'package:dro_doctor_app/UI/Pages/Common/Schedule/SchedulePage.dart';
import 'package:dro_doctor_app/UI/Style/StyleFile.dart';
import 'package:fleva_icons/fleva_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class ClinicSettingsPage extends StatefulWidget {

  final String clinicID,doctorID;
  ClinicSettingsPage(this.clinicID,this.doctorID);

  @override
  _ClinicSettingsPageState createState() => _ClinicSettingsPageState();
}

class _ClinicSettingsPageState extends State<ClinicSettingsPage> {

  Style style ;
  ClinicSettingsAPI _clinicSettingsAPI ;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    style = Style();
    _clinicSettingsAPI = ClinicSettingsAPI();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Clinic Settings'),automaticallyImplyLeading: false,),
      body: ListView(
        children: <Widget>[
          FutureBuilder(
            future: ClinicInfoAPI().getClinicInfo(widget.clinicID),
            builder: (context,ss){
              if(ss.hasError){
                print('Error');
              }if(ss.hasData){
                Map myData = ss.data[0];
                return ListView(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  children: [
                    ListTile(
                      title: Text('Name Of Clinic'),
                      subtitle: Text('${myData['CLINIC_NAME'] == '--' ? 'Your name' : myData['CLINIC_NAME']}'),
                      leading: Icon(Icons.home,color: style.iconColor,),
                      trailing: IconButton(
                        icon: Icon(FlevaIcons.edit_2_outline),
                        onPressed: ()=>_changeName(myData['CLINIC_NAME'],"${myData['FIRST_NAME']} ${myData['LAST_NAME']}"),

                      ),
                    ),
                    ListTile(
                      title: Text('Phone'),
                      subtitle: Text('${myData['CLINIC_PHONE']}'),
                      leading: Icon(Icons.phone,color: style.iconColor),
                      trailing: IconButton(
                        icon: Icon(FlevaIcons.edit_2_outline),
                        onPressed: ()=>_changePHone(myData['CLINIC_PHONE']),
                      ),
                    ),
                    ListTile(
                      title:Text('FEE'),
                      subtitle:Text('${myData['FEE']}'),
                      leading: Icon(Icons.attach_money,color: style.iconColor,),
                      trailing: IconButton(
                        icon: Icon(FlevaIcons.edit_2_outline),
                        onPressed: ()=>_changeFee(myData['FEE']),
                      ),
                    ),
                  ],
                );
              }else{
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ListTile(
                title:Text('Clinic Schedule'),
                subtitle: Text('See & Edit Clinic Schedule.'),
                leading: Icon(Icons.schedule,color: style.iconColor,),
                onTap: (){
                  Navigator.push(context,
                      CupertinoPageRoute(
                          builder: (context)=>SchedulePage(widget.clinicID,widget.doctorID,'-1')
                      ));
                },
              ),
              Text('Photos of clinic'),
              PhotosOf(widget.clinicID, '-1'),
            ],
          )

        ],
      ),
    );
  }

  void _changeName(String name,String drName) {

    TextEditingController nameController = TextEditingController(text: name == '--' ? "Dr. $drName" : name);
    final formKey = GlobalKey<FormState>();

    showDialog(context: context,builder: (context){
      return MyCustomDialog(
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
                await _clinicSettingsAPI.updateClinicName(clinicID: widget.clinicID,newName: nameController.text).then((value){
                  if(value){
                    Navigator.of(context).pop();
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

  void _changePHone(String phone) {

    TextEditingController phoneController = TextEditingController(text: phone);
    final formKey = GlobalKey<FormState>();

    showDialog(context: context,builder: (context){
      return MyCustomDialog(
        title: Text('Change name'),
        content: Form(
          key: formKey,
          child: TextFormField(
            controller: phoneController,
            validator: (value) => value.length == 11 &&
                ((value.startsWith('010')) ||
                    value.startsWith('011') ||
                    value.startsWith('012'))
                ? null
                : 'phone number should start with 010,011, or 012\n and contains 11 numbers',
            onSaved: (value)=>phoneController.text = value,
          ),
        ),
        actions: [
          FlatButton(
            child: Text('Save'),
            onPressed: ()async{
              if(formKey.currentState.validate()){
                formKey.currentState.save();
                await _clinicSettingsAPI.updateClinicPhone(clinicID: widget.clinicID,newPhone: phoneController.text).then((value){
                  if(value){
                    Navigator.of(context).pop();
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

  void _changeFee(String fee){

    TextEditingController feeController = TextEditingController(text:fee);
    final formKey = GlobalKey<FormState>();

    showDialog(context: context,builder: (context){
      return MyCustomDialog(
        title: Text('Change name'),
        content: Form(
          key: formKey,
          child: TextFormField(
            controller: feeController,
            onSaved: (value)=>feeController.text = value,
          ),
        ),
        actions: [
          FlatButton(
            child: Text('Save'),
            onPressed: ()async{
              if(formKey.currentState.validate()){
                formKey.currentState.save();
                await _clinicSettingsAPI.updateClinicFEE(clinicID: widget.clinicID,newFee: feeController.text).then((value){
                  if(value){
                    Navigator.of(context).pop();
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
