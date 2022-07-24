import 'package:dro_patient_app/APIs/URL/mainURL.dart';
import 'package:dro_patient_app/UI/OtherPages/CenterDetailsPage.dart';
import 'package:dro_patient_app/UI/Parts/Custom/MyCustomImage.dart';
import 'package:dro_patient_app/UI/Style/style.dart';
import 'package:fleva_icons/fleva_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'FavoriteIcon.dart';
import 'TotalRate.dart';

class CenterCard extends StatefulWidget {

  final String _patientID;
  final Map _centerInfo;

  CenterCard(this._patientID,this._centerInfo);

  @override
  _CenterCardState createState() => _CenterCardState();
}

class _CenterCardState extends State<CenterCard> {

  Style _style;

  @override
  void initState() {
    super.initState();
    _style = Style();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print(widget._centerInfo);
    return GestureDetector(
      child: Stack(
        children: [
          Card(
            child: Column(
              children: [
                widget._centerInfo['CENTER_PHOTO']!='--'?MyCustomImage(
                  width: _style.getWidthSize(context),
                  height: _style.getWidthSize(context)*0.5,
                  image: '$imageLoc/PhotosOf/${widget._centerInfo['CENTER_PHOTO']}',
                ):Icon(Icons.image,
                  size: _style.getWidthSize(context)*0.3,
                  color: _style.getBrokImgColor(),),
                Wrap(
                  children: [
                    Icon(Icons.local_hospital,size: _style.getWidthSize(context)*0.04,),
                    SizedBox(width: 10,),
                    Text('${widget._centerInfo['NAME']}',
                      style: TextStyle(fontWeight: FontWeight.w500),),
                  ],
                ),
                TotalRate('-1',MediaQuery.of(context).size.width / 20,widget._centerInfo['CENTER_ID']),
                Text("${widget._centerInfo['ABOUT_CENTER']}",maxLines: 3,overflow: TextOverflow.ellipsis,style: TextStyle(color: _style.getSubTextColor())),
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
                          Text('${widget._centerInfo['ADDRESS']}',style: TextStyle(fontSize: _style.getWidthSize(context)*0.04),),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(_style.getWidthSize(context)*0.02),
                      child: Wrap(
                        children: <Widget>[
                          Icon(Icons.monetization_on,size: _style.getWidthSize(context)*0.04),
                          SizedBox(width: 10,),
                          Text('${widget._centerInfo['FEE']} \$',style: TextStyle(fontSize: _style.getWidthSize(context)*0.04),)
                        ],
                      ),
                    )
                  ],
                ),
                Divider(height: 0, endIndent: _style.getWidthSize(context)*0.2,indent: _style.getWidthSize(context)*0.2,),
                Chip(
                  backgroundColor: Colors.blue[900].withOpacity(0.4),
                  label: Text('${widget._centerInfo['SPECIALITY']}',
                    style: TextStyle(fontSize: _style.getWidthSize(context)*0.03),),
                )
              ],
            )
          ),
          Positioned(
            right: 0,
            child: FavoriteIcon(widget._patientID,'-1',widget._centerInfo['CENTER_ID']),
          ),
        ],
      ),

      onTap: ()=>Navigator.push(context,
        PageRouteBuilder(
          pageBuilder: (context, animation1, animation2)=> CenterDetailsPage(
              widget._patientID,
              widget._centerInfo),
          transitionsBuilder: (context, animation1, animation2, child) {
            return FadeTransition(
              opacity: animation1,
              child: child,
            );
          },
          transitionDuration: Duration(milliseconds: 250),
        ),
      ),
    );
  }
}
/*
Card(
        // Text('${widget._centerInfo['CENTER_PHOTO']}'),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[

            Text('${widget._centerInfo['CENTER_PHONE']}'),
            Text('${widget._centerInfo['SPECIALITY']}'),
            FavoriteIcon(widget._patientID,'-1',widget._centerInfo['CENTER_ID']),
          ],
        )
      ),
 */