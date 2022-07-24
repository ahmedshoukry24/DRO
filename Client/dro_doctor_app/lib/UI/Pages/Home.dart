import 'package:fleva_icons/fleva_icons.dart';
import 'package:flutter/cupertino.dart';

import 'Common/ClinicCenterHomePage.dart';
import 'Profile.dart';
import 'Settings.dart';
import 'package:flutter/material.dart';
class Home extends StatefulWidget {

  final String doctorID;
  final int currentIndexSent;
  Home(this.doctorID,this.currentIndexSent);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  int _currentIndex;

  Widget currentPage;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.currentIndexSent;
    switch (_currentIndex){
      case 0:
        currentPage = Profile(widget.doctorID,);
        break;
      case 1:
        currentPage = ClinicCenterHomePage(widget.doctorID,);
        break;
      case 2:
        currentPage = Settings(widget.doctorID,);
        break;
      default:
        currentPage = Profile(widget.doctorID,);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()=>_willPop(),
      child: NotificationListener<OverscrollIndicatorNotification>(
        // ignore: missing_return
        onNotification: (OverscrollIndicatorNotification overScroll){
          overScroll.disallowGlow();
        },
        child: Scaffold(
          body: currentPage,

          bottomNavigationBar: BottomNavigationBar(
            onTap: (value){
              if(_currentIndex != value){
                setState(() {
                  _currentIndex = value;
                });
                switch(_currentIndex){
                  case 0:
                    setState(() {
                      currentPage = Profile(widget.doctorID,);
                    });
                    break;
                  case 1:
                    setState(() {
                      currentPage = ClinicCenterHomePage(widget.doctorID,);
                    });
                    break;
                  case 2:
                    setState(() {
                      currentPage = Settings(widget.doctorID,);
                    });
                    break;
                }
              }
            },
            currentIndex: _currentIndex,
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.person_outline),
                title: Text('Profile'),
              ),
              BottomNavigationBarItem(
                icon: Icon(FlevaIcons.briefcase_outline),
                title: Text('Clinic & Center'),
              ),

              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                title: Text('Settings'),
              )
            ],
          ),

        ),
      ),
    );
  }

  Future<bool> _willPop()async{
    return ( await showDialog(
      context: context,
      builder: (context){
        return AlertDialog(
          shape: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none
          ),
          title: Text('Are You Sure You Want To Exit !'),
          actions: <Widget>[
            FlatButton(
              child: Text('Yes'),
              onPressed: ()=>Navigator.of(context).pop(true),
            ),
            FlatButton(
              child: Text('No'),
              onPressed: ()=>Navigator.of(context).pop(false),
            ),
          ],
        );
      }
    )) ?? false;
  }

}
