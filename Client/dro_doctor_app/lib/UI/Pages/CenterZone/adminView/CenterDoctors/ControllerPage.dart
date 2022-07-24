import 'AddDoctor.dart';
import 'ShowDoctorsPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CenterDoctorsPage extends StatefulWidget {
  final String centerID, doctorID, docAdmin;

  CenterDoctorsPage(this.doctorID, this.centerID, this.docAdmin);

  @override
  _CenterDoctorsPageState createState() => _CenterDoctorsPageState();
}

class _CenterDoctorsPageState extends State<CenterDoctorsPage> {

  int _currentIndex = 0;
  Widget currentState;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    currentState = ShowDoctorsPage(widget.centerID,widget.doctorID,widget.docAdmin);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: currentState,
      bottomNavigationBar: BottomNavigationBar(

        currentIndex: _currentIndex,

        onTap: (state) {
          if(_currentIndex != state){
            setState(() {
              _currentIndex = state;
            });
          }
          switch (state) {
            case 0:
              setState(() {
                currentState = ShowDoctorsPage(widget.centerID,widget.doctorID,widget.docAdmin);
              });
              break;
            case 1:
              setState(() {
                currentState = AddDoctor(widget.centerID,widget.doctorID,widget.docAdmin);
              });
          }
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.group_work),
            title: Text('Center\'s Doctors'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            title: Text('Add Doctors'),
          ),
        ],
      ),
    );
  }
}
