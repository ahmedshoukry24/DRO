import 'package:dro_patient_app/APIs/URL/mainURL.dart';
import 'package:dro_patient_app/UI/Style/style.dart';
import 'package:fleva_icons/fleva_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'Custom/MyCustomImage.dart';
import 'FavoriteIcon.dart';
import '../OtherPages/ClinicDetailsPage.dart';
import 'TotalRate.dart';
import 'Custom/MyPageRoute.dart';

/*
a
  clinicInfo['CLINIC_ID']
  clinicInfo['CLINIC_NAME']
  clinicInfo['FIRST_NAME'] * Dr
  clinicInfo['LAST_NAME']  * Dr
  clinicInfo['SPECIALITY'] *Dr
  clinicInfo['ADDRESS']
  clinicInfo['CLINIC_PHONE']
  clinicInfo['FEE']
  clinicInfo['BIO']
  clinicInfo['RATE']
*
*
 */

class ClinicCard extends StatefulWidget {
  final String _patientID;
  final Map _clinicInfo;

  ClinicCard(this._patientID,this._clinicInfo);

  @override
  _ClinicCardState createState() => _ClinicCardState();
}

class _ClinicCardState extends State<ClinicCard> with SingleTickerProviderStateMixin {

  AnimationController controller;
  Animation animation;

  Style _style;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _style = Style();
    controller = AnimationController(vsync: this, duration: Duration(milliseconds: 750));
    animation = Tween(begin: 0.0,end: 1.0).animate(controller);

    controller.forward();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return widget._clinicInfo['CLINIC_ID'] == '-1' ? Container():FadeTransition(
      opacity: animation,
      child: GestureDetector(
        onTap: (){
          MyPageRoute().fadeTransitionRouting(context, ClinicDetailsPage(widget._patientID,widget._clinicInfo['CLINIC_ID']));
        },
        child: Stack(
          children: <Widget>[
            Card(
              shape: OutlineInputBorder(
                borderRadius: BorderRadius.circular(7.0),borderSide: BorderSide.none
              ),
              elevation: 10.0,
              color: Colors.white.withOpacity(0.8),
              child: Column(
                children: <Widget>[
                  _body(context),
                  Divider(height: 0, endIndent: MediaQuery.of(context).size.width / 4,indent: MediaQuery.of(context).size.width / 4,),
                 _footer(),
                ],
              ),
            ),
            Positioned(
              right: 0,
              child: FavoriteIcon(widget._patientID,widget._clinicInfo['CLINIC_ID'],'-1'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _body(BuildContext context) {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
    widget._clinicInfo['PROFILE_PICTURE']!='--'?MyCustomImage(
          image: '${imageLoc}doctorImages/${widget._clinicInfo['PROFILE_PICTURE']}',
          height: _style.getWidthSize(context)*0.5,
          width: _style.getWidthSize(context),
        ):Icon(Icons.image,size: _style.getWidthSize(context)*0.3, color: _style.getBrokImgColor(),),
        Padding(
          padding: EdgeInsets.all(_style.getWidthSize(context)*0.02),
          child: Text('${widget._clinicInfo['TITLE']}. ${widget._clinicInfo['FIRST_NAME']} ${widget._clinicInfo['LAST_NAME']}',
            style: TextStyle(fontWeight: FontWeight.w500),),
        ),
        TotalRate(widget._clinicInfo['CLINIC_ID'],MediaQuery.of(context).size.width / 20,'-1'),
        Padding(
          padding: EdgeInsets.all(_style.getWidthSize(context)*0.02),
          child: Text("${widget._clinicInfo['BIO']}",maxLines: 3,overflow: TextOverflow.ellipsis,style: TextStyle(color: _style.getSubTextColor()),),
        ),

        widget._clinicInfo['CLINIC_NAME'] != '--' ? Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.local_hospital,size: _style.getWidthSize(context)*0.04,),
            SizedBox(width: 10,),
            Text('${widget._clinicInfo['CLINIC_NAME']}',
              style: TextStyle(fontWeight: FontWeight.w600,letterSpacing: 1,fontSize: _style.getWidthSize(context)*0.04,color: Colors.blue[900]),),
          ],
        ) : Container(),

        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(_style.getWidthSize(context)*0.02),
              child: Wrap(
                children: <Widget>[
                  Icon(FlevaIcons.pin_outline,size: _style.getWidthSize(context)*0.04,),
                  SizedBox(width: 10,),
                  Text('${widget._clinicInfo['ADDRESS']}',style: TextStyle(fontSize: _style.getWidthSize(context)*0.04),),

                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(_style.getWidthSize(context)*0.02),
              child: Wrap(
                children: <Widget>[
                  Icon(Icons.monetization_on,size: _style.getWidthSize(context)*0.04),
                  SizedBox(width: 10,),
                  Text('${widget._clinicInfo['FEE']} \$',style: TextStyle(fontSize: _style.getWidthSize(context)*0.04),)
                ],
              ),
            )
          ],
        )
      ],
    );
  }

  Widget _footer() {
    return  Chip(
      label: Text('${widget._clinicInfo['SPECIALITY']}',style: TextStyle(fontSize: _style.getWidthSize(context)*0.03),),
    );
  }


}