import 'package:flutter/material.dart';

class About extends StatefulWidget {

  String _patientID;
  About(this._patientID);
  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About'),
      ),
    );
  }
}
