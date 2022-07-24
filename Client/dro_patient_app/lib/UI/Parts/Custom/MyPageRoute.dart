import 'package:flutter/material.dart';

class MyPageRoute{

  void slideTransitionRouting(BuildContext context, Widget direction){
    Navigator.push(context,
        PageRouteBuilder(
          opaque: false,
            pageBuilder: (context,a1,a2)=>direction,
            transitionsBuilder: (context,a1, a2, child){
              return SlideTransition(
                position: Tween(begin: Offset(1,0),end: Offset(0,0)).animate(a1),
                child: child,
              );
            },
            transitionDuration: Duration(
                milliseconds: 200
            )
        ));
  }

  void fadeTransitionRouting(BuildContext context, Widget direction){
    Navigator.push(context, PageRouteBuilder(
      pageBuilder: (a1, a2, child){
        return direction;
      },
      opaque: false,
      transitionsBuilder: (context,a1, a2, child){
        return FadeTransition(
          opacity: a1,
          child: child,
        );
      },
      transitionDuration: Duration(milliseconds: 200)
    ));
  }

}