import 'package:fleva_icons/fleva_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'MainPages/QuestionsPage.dart';
import '../OfflineDatabase/helper.dart';
import 'LoginPage.dart';
import 'MainPages/appointments.dart';
import 'MainPages/medical_history.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'MainPages/reminder.dart';
import 'MainPages/favorite.dart';
import 'MainPages/homePage.dart';
import 'parts/Custom/MyPageRoute.dart';
import 'MainPages/settings.dart';
import 'MainPages/search.dart';

class StartPage extends StatefulWidget {

  final String _patientID;
  StartPage(this._patientID);
  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> with TickerProviderStateMixin{

  TabController tabController;
  AnimationController buttonController;


  @override
  void initState() {
    super.initState();
    tabController = TabController(vsync: this,initialIndex: 0,length: 6);
    buttonController = AnimationController(vsync: this,duration: Duration(milliseconds: 500));
  }

  @override
  void dispose() {
    super.dispose();
    buttonController?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      // ignore: missing_return
      onWillPop: (){
        if(tabController.index != 0){
          setState(() {
            tabController.index = 0;
          });
        }else{
          return _onWillPop();
        }
      },
      child: Scaffold(
        body: TabBarView(
          controller: tabController,
          children: <Widget>[
            HomePage(widget._patientID,),
            FavoritePage(widget._patientID),
            MedicalHistory(widget._patientID,),
            Appointments(widget._patientID),
            Reminder(widget._patientID,),
            QuestionsPage(widget._patientID),

          ],
        ),
        bottomNavigationBar: BottomAppBar(
          shape: CircularNotchedRectangle(),
          child: TabBar(
            unselectedLabelColor: Colors.grey,
            labelColor: Colors.blue[800],
            controller: tabController,
            tabs: <Widget>[
              Tab(icon: Icon(Icons.home)),
              Tab(icon: Icon(Icons.bookmark),),
              Tab(icon: Icon(Icons.history)),
              Tab(icon: Icon(Icons.av_timer)),
              Tab(icon: Icon(Icons.alarm)),
              Tab(icon: Icon(Icons.question_answer),)
            ],
          ),
        ),
        floatingActionButton:SpeedDial(
          child: AnimatedIcon(icon: AnimatedIcons.menu_close,progress: buttonController,),
          onOpen: (){
            buttonController.forward();
          },
          onClose: (){
            buttonController.reverse();
          },
          children: [
            SpeedDialChild(
              child: Icon(Icons.priority_high),
              label: 'About',
            ),
            SpeedDialChild(
              child: Icon(Icons.search),
              label: 'Search',
              onTap: ()=>MyPageRoute().slideTransitionRouting(context, SearchForDoctor(widget._patientID))
            ),
            SpeedDialChild(
              child: Icon(Icons.settings),
              label: 'Settings',
              onTap: ()=>MyPageRoute().slideTransitionRouting(context, Settings(widget._patientID,)),
            ),
            SpeedDialChild(
              child: Icon(FlevaIcons.log_out),
              label: 'Logout',
              onTap: ()=>_logout(),
            ),
          ],
        ),
      ),
    );
  }

  Future<bool> _onWillPop() async {
    return (await showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        shape: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(10)
        ),
        title: new Text('Are you sure?'),
        content: new Text('Do you want to exit'),
        actions: <Widget>[
          FlatButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: new Text('Yes'),
          ),
          FlatButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: new Text('No'),
          ),
        ],
      ),
    )) ?? false;
  }

  _logout(){
    return showDialog(
      context: context,
      builder: (context){
        return AlertDialog(
          shape: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none
          ),
          title: Text('Are you sure you want to logout?'),
          actions: <Widget>[
            FlatButton(
              child: Text('Ok'),
              onPressed: ()async{
                Navigator.pushAndRemoveUntil(context, CupertinoPageRoute(builder: (context)=>LoginPage()),(Route<dynamic>route)=>false);
                await DatabaseHelper().deleteUser('1');
              },
            ),
            FlatButton(
              child: Text('Cancel'),
              onPressed: ()async{
                Navigator.pop(context);
              },
            ),

          ],
        );
      }
    );
  }

}
