import 'package:flutter/material.dart';


// ignore: must_be_immutable
class DropdownTitle extends StatefulWidget {

  List<String> _titles = ['Professor', 'Lecturer', 'Consultant', 'Specialist'];
  String result;

  @override
  _DropdownTitleState createState() => _DropdownTitleState();
}

class _DropdownTitleState extends State<DropdownTitle> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: DropdownButton(items: widget._titles.map((item){
        return DropdownMenuItem(child: Text(item,style: TextStyle(color: Colors.blue[800],fontSize: 13),),value: item,);
      }).toList(),
          onChanged: (value){
        setState(() {
          widget.result = value;
        });
          },
        value: widget.result,
        hint: Text('Title',style: TextStyle(color: Colors.blue[800],),),
        isExpanded: true,
          ),
    );
  }
}
