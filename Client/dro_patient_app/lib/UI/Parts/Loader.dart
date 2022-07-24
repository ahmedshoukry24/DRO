import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loader extends StatefulWidget{
  @override
  _LoaderState createState() => _LoaderState();
}

class _LoaderState extends State<Loader>  with TickerProviderStateMixin{

  /*
  List loaders = [
    SpinKitRipple(color: Colors.blue[900],),
  SpinKitPumpingHeart(color: Colors.blue[900]),
    SpinKitHourGlass(color: Colors.blue[900]),
  ];
  Random random = Random();
   */
  //loaders[random.nextInt(loaders.length)];
  @override
  Widget build(BuildContext context) {
    return SpinKitRipple(
      color: Colors.blue[900],
      duration: Duration(seconds: 5),
      borderWidth: 4,
    );
  }
}
/*
Material(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SpinKitRipple(
      controller: AnimationController(vsync: this,duration: Duration(seconds: 3)),
      color: Colors.blue[900],
    ),
                  SizedBox(height: 10,),
                  Text('loading...')
                ],
              ),
            );
 */
