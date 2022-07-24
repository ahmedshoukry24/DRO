import 'dart:io';

import 'package:dro_doctor_app/APIs/Common/OffersAPI.dart';
import 'package:dro_doctor_app/APIs/uploadImage/uploadImage.dart';
import 'package:dro_doctor_app/UI/Custom/CustomDialog.dart';
import 'package:dro_doctor_app/UI/Custom/SharedDialog.dart';
import 'package:dro_doctor_app/UI/Style/StyleFile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OffersPage extends StatefulWidget {

  final String doctorID,clinicID,centerID;

  OffersPage(this.doctorID,this.clinicID,this.centerID);


  @override
  _OffersPageState createState() => _OffersPageState();
}

class _OffersPageState extends State<OffersPage> {
  Style _style;
  UploadImage _uploadImage;
  File _image;
  TextEditingController _contentController;

  @override
  void initState() {
    super.initState();
    _style = Style();
    _uploadImage = UploadImage();
    _contentController = TextEditingController();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Offers'),automaticallyImplyLeading: false,),
      body: Padding(
        padding: EdgeInsets.all(_style.getWidthSize(context)*0.02),
        child: ListView(
          children: [
            Row(
              children: [
                Padding(
                  padding:EdgeInsets.all(_style.getWidthSize(context)*0.01),
                  child: Text('Offer content:'),
                ),
                Expanded(
                  child: TextField(
                    controller: _contentController,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(left: _style.getWidthSize(context)*0.01,right: _style.getWidthSize(context)*0.01),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(_style.getWidthSize(context)*0.01)
                      )
                    ),
                    maxLines: 6,
                    minLines: 1,
                  ),
                )
              ],
            ),
            Row(
              children: [
                Padding(
                  padding:EdgeInsets.all(_style.getWidthSize(context)*0.01),
                  child: Text('Offer Photo:'),
                ),
                FlatButton(
                  child: Text('Select image'),
                  onPressed: ()async{
                    showDialog(context: context,builder: (context){
                      return SharedLoadingDialog().loading(context);
                    });
                    await _uploadImage.getImage('G').then((value)async{
                      if(value != null){
                       Navigator.pop(context);
                       _image = value;
                      }
                    });
                  },
                ),
              ],
            ),
            RaisedButton(
              shape: OutlineInputBorder(
                borderRadius: BorderRadius.circular(_style.getWidthSize(context)*0.04),
                borderSide: BorderSide(color: Colors.blue[900].withOpacity(0.4))
              ),
              child: Text('Submit'),
              onPressed: ()async{
                if(_image != null){
                  showDialog(context: context,barrierDismissible: false,builder: (context){
                    return SharedLoadingDialog().loading(context);
                  });
                  await _uploadImage.upload(_image, 'offer').then((value)async{
                    if(value){
                      await OffersAPI().postOffer(clinicID: widget.clinicID,centerID: widget.centerID,
                          content:_contentController.text,figureName: _uploadImage.imageName).then((value){
                        if(value){
                          Navigator.pop(context);
                          _contentController.clear();
                          _image = null;
                          showDialog(context: context,builder: (context){
                            return MyCustomDialog(content: Text('Offer posted successfully!'),actions: [
                              FlatButton(child: Text('Ok'),onPressed: ()=>Navigator.pop(context),)
                            ],);
                          });
                        }else{
                          showDialog(context: context,builder: (context){
                            return MyCustomDialog(content: Text('Failed'),);
                          });
                        }
                      });
                    }
                  });
                }
              },
            )

          ],
        ),
      ),
    );
  }
}
