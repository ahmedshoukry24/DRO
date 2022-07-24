import 'package:fleva_icons/fleva_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../APIs/Favorite_section/FavoriteAPI.dart';

class FavoriteIcon extends StatefulWidget {

  final String _patientID,_clinicID,_centerID;
  FavoriteIcon(this._patientID,this._clinicID,this._centerID);

  @override
  _FavoriteIconState createState() => _FavoriteIconState();
}

class _FavoriteIconState extends State<FavoriteIcon> {

  FavoriteAPI favorite = FavoriteAPI();


  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: favorite.isFavorite(patientID: widget._patientID,clinicID: widget._clinicID,centerID: widget._centerID),
      builder: (context,ss){
        if(ss.hasError){
          print('Error');
        }
        if(ss.hasData){
          return ss.data ? IconButton(
            color: Colors.red[900],
            icon: Icon(Icons.bookmark,size: MediaQuery.of(context).size.width/12,),
            onPressed: (){
              favorite.removeFromFavorite(clinicID: widget._clinicID,patientID: widget._patientID,centerID: widget._centerID); // patient & clinic id
              setState(() {

              });
            },
          ) : IconButton(
            icon: Icon(Icons.bookmark_border,size: MediaQuery.of(context).size.width/12,),
            onPressed: (){
              favorite.addToFavorite(patientID: widget._patientID,clinicID: widget._clinicID,centerID: widget._centerID); // patient & clinic id
              setState(() {
              });
            },
          );
        }else{
          return IconButton(
            icon: Icon(Icons.bookmark_border),
            onPressed: null,
          );
        }
      },
    );
  }

}
