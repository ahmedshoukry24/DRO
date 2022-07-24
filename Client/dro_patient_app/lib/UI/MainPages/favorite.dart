import 'package:dro_patient_app/APIs/URL/mainURL.dart';

import 'package:dro_patient_app/UI/OtherPages/CenterDetailsPage.dart';
import 'package:dro_patient_app/UI/Parts/Custom/MyCustomImage.dart';
import 'package:dro_patient_app/UI/Style/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../Parts/Loader.dart';
import '../OtherPages/ClinicDetailsPage.dart';
import '../../APIs/Favorite_section/FavoriteAPI.dart';

class FavoritePage extends StatefulWidget {

  final String _patientID;
  FavoritePage(this._patientID);

  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {

  FavoriteAPI favoriteAPI ;
  Style _style;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _style = Style();
    favoriteAPI = FavoriteAPI();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            children: <Widget>[
              Icon(Icons.bookmark),
              SizedBox(width: 10,),
              Text('Favorite'),
            ],
          ),
        ),
        body: FutureBuilder(
          future: favoriteAPI.getMyFavoriteItems(widget._patientID),
          builder: (BuildContext context,AsyncSnapshot ss){
            if(ss.hasError){
              print('Error');
            }
            if(ss.hasData){
              List myData = ss.data;
              return ListView.builder(
                itemCount: myData.length,
                itemBuilder: (BuildContext context,int position){
                  return myData[position]['CLINIC_ID'] != null ? _clinicFavoriteCard(myData[position])
                  : _centerFavoriteCard(myData[position]);
                },
              );
            }else{
              return Material(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Loader(),
                    SizedBox(height: 10,),
                    Text('loading...')
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }

  Widget _centerFavoriteCard(Map data){
   return Card(
     margin: EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
     child: ListTile(
       title: Text('${data['NAME']}'),
       subtitle: Column(
         crossAxisAlignment: CrossAxisAlignment.stretch,
         children: <Widget>[
           Text('${data['ADDRESS']}'),
           Text('${data['CENTER_PHONE']}'),
           Text('${data['SPECIALITY']}'),
         ],
       ),
       trailing: GestureDetector(child: Icon(Icons.close),onTap: (){
         setState(() {
           FavoriteAPI().removeFromFavorite(centerID: data['CENTER_ID'],clinicID: '-1' , patientID: widget._patientID );
         });
       },),
       leading: data['CENTER_PHOTO'] == '--'?CircleAvatar(
         backgroundColor: Colors.red[900],
         radius: _style.getWidthSize(context)/40,
       ) : SizedBox(
         width: _style.getWidthSize(context)*0.15,
         height: _style.getWidthSize(context)*0.15,
         child: ClipRRect(
           borderRadius: BorderRadius.circular(5),
           child: MyCustomImage(
             image: "${imageLoc}PhotosOf/${data['CENTER_PHOTO']}",
             width: _style.getWidthSize(context)*0.15,
             height: _style.getWidthSize(context)*0.15,
           ),
         ),
       ),
       onTap: (){
         Navigator.push(context, PageRouteBuilder(
           pageBuilder: (context,animation1, animation2)=>CenterDetailsPage(widget._patientID,data),
           transitionsBuilder: (context,animation1,animation2,child){
             return FadeTransition(
               opacity: animation1,
               child: child,
             );
           },
           transitionDuration: Duration(milliseconds: 250)
         ));
       },
     ),
   );
  }

  Widget _clinicFavoriteCard(Map data){
    return Card(
      child: ListTile(
        title: Text(data['CLINIC_NAME'] != '--' ? '${data['CLINIC_NAME']}' : '${data['FIRST_NAME']} ${data['LAST_NAME']}'),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            data['CLINIC_NAME'] != '--' ? Text('${data['FIRST_NAME']} ${data['LAST_NAME']}') : Container(),
            Text('${data['CLINIC_PHONE']}'),
            Text('${data['ADDRESS']}'),
          ],
        ),
        trailing: GestureDetector(child: Icon(Icons.close),onTap: (){
          setState(() {
            FavoriteAPI().removeFromFavorite(centerID: '-1',clinicID: data['CLINIC_ID'] , patientID: widget._patientID );
          });
        },),
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: MyCustomImage(
            image: '${imageLoc}doctorImages/${data['PROFILE_PICTURE']}',
            width:_style.getWidthSize(context)*0.15,
            height: _style.getWidthSize(context)*0.15,
          ),
        ),
        onTap: ()=>Navigator.push(context, CupertinoPageRoute(builder: (context)=>ClinicDetailsPage(widget._patientID,data['CLINIC_ID']))),
      ),
    );
  }
}
