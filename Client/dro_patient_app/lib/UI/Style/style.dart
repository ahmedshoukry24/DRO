import 'package:flutter/material.dart';

class Style{


  getWidthSize(context){
    return MediaQuery.of(context).size.width;
  }

  getMainColor(){
    return Colors.blue[900];
  }



  getBrokImgColor(){
    return Colors.grey[300];
  }

  getSubTextColor(){
    return Colors.grey[600];
  }

}