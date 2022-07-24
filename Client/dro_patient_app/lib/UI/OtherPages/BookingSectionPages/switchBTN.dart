import 'package:flutter/material.dart';

class SwitchBTN extends StatefulWidget {

  bool switchValue = false;

  @override
  _SwitchBTNState createState() => _SwitchBTNState();
}

class _SwitchBTNState extends State<SwitchBTN> {

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      title: Text('Video call session'),
      value: widget.switchValue,
      onChanged: (value){
        setState(() {
          widget.switchValue = value;
        });
      },
    );
  }
}
