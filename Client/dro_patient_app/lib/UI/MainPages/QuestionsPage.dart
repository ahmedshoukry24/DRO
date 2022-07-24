import 'dart:ui';
import 'package:dro_patient_app/APIs/URL/mainURL.dart';
import 'package:dro_patient_app/UI/Parts/Custom/MyCustomImage.dart';
import 'package:dro_patient_app/UI/Style/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import '../../APIs/Questions/QuestionAPIs.dart';
import '../../APIs/Questions/getAnswers.dart';
import '../../Model/StaticLists.dart';
import '../Parts/Loader.dart';

class QuestionsPage extends StatefulWidget {
  final String _patientID;
  QuestionsPage(this._patientID);

  @override
  _QuestionsPageState createState() => _QuestionsPageState();
}

class _QuestionsPageState extends State<QuestionsPage> {
  List<String> _specialties = StaticLists().getCategoriesList();


  // asking
  String _toShowInAskingForm = 'Specialty';
  String _valueSendToDB = '--';

  TextEditingController _question;

  // dropDown button
  String dropDownBtnValue;

  String _searchSpecialty = 'General';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _question = TextEditingController();
    if(_specialties.first != 'General'){
      _specialties.insert(0, 'General');
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: <Widget>[
            Icon(Icons.question_answer),
            SizedBox(width: 10,),
            Text('Questions'),
          ],
        ),

      ),
      body: ListView(
        children: <Widget>[
          _myDropDownSearch(),


          _writeQuestion(),

          // show questions section
          FutureBuilder(
            future: QuestionsAPI().getQuestions(_searchSpecialty),
            builder: (context, ss) {
              if (ss.hasError) {
                print('Error');
              }
              if (ss.hasData) {
                List myData = ss.data;
                return ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: myData.length,
                    itemBuilder: (context, position) {
                      return _showQuestionForm(myData[position]);
                    });
              } else {
                return Loader();
              }
            },
          )
        ],
      ),
    );
  }

  Widget _writeQuestion() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Column(
          children: <Widget>[
            // header
            TextField(
              controller: _question,
              enableInteractiveSelection: true,
              focusNode: FocusNode(),
              style: TextStyle(color: Colors.black),
              minLines: 2,
              maxLines: 4,
              textInputAction: TextInputAction.newline,
              toolbarOptions: ToolbarOptions(copy: true,cut: true,selectAll: true),
              decoration: InputDecoration(
                isDense: true,
                hintText: 'Write your question!',
                border: OutlineInputBorder(
                  borderSide: BorderSide.none
                )
              ),
            ),

            Divider(
              height: 0,
            ),

            // footer
            Row(
              children: <Widget>[
                Expanded(
                  child: FlatButton(
                    child: Text(
                      '$_toShowInAskingForm',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontStyle: FontStyle.italic, color: Colors.grey[700]),
                    ),
                    textColor: Colors.grey[700],
                    onPressed: () => _selectSpecialty(),
                  ),
                ),
                Text(
                  '|',
                  style: TextStyle(color: Colors.grey),
                ),
                Expanded(
                  child: FlatButton(
                      child: Text(
                        'Post',
                        textAlign: TextAlign.center,
                      ),
                      textColor: Colors.grey[700],
                      onPressed: () => _postBtn(
                          patientID: widget._patientID,
                          specialty: _valueSendToDB,
                          question: _question.text)),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  _postBtn({String patientID, String specialty, String question}) async {
    print(_question.text.length);
    if (_question.text.length < 5) {
      showDialog(
          context: context,
          builder: (context) => Dialog(
                elevation: 0,
                insetAnimationCurve: Curves.slowMiddle,
                insetAnimationDuration: Duration(seconds: 5),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Sorry you can\'t ask this question',
                    textAlign: TextAlign.center,
                  ),
                ),
                shape: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none),
              ));
    } else {
      bool res = await QuestionsAPI().postQuestion(
          patientID: patientID, specialty: specialty, question: question);
      if (res) {
        _question.clear();
        setState(() {});
      }
    }
  }

  _selectSpecialty() {
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            elevation: 1,
            backgroundColor: Colors.transparent,
            shape: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50),
              borderSide: BorderSide.none,
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  Text(
                    'Select specialty you asking about!',
                    style: TextStyle(color: Colors.white70),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Expanded(
                    child: ListView.builder(
                        itemCount: _specialties.length,
                        itemBuilder: (context, position) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                              setState(() {
                                _valueSendToDB = _specialties[position];
                                _toShowInAskingForm = _specialties[position];
                              });
                            },
                            child: Chip(
                              label: Text('${_specialties[position]}'),
                            ),
                          );
                        }),
                  ),
                ],
              ),
            ),
          );
        });
  }

  Widget _myDropDownSearch() {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0, right: 15.0),
      child: DropdownButton(
        underline: SizedBox(),
        items: _specialties.map((item) {
          return DropdownMenuItem(
            child: Text(item),
            value: item,
          );
        }).toList(),
        onChanged: (value) {
          setState(() {
            dropDownBtnValue = value;
            _searchSpecialty = value;
          });
        },
        hint: Text('Specialty',),
        value: dropDownBtnValue,
        isExpanded: true,
      ),
    );
  }

  Widget _showQuestionForm(Map myMap) {
    DateTime myDate = DateFormat("yyy-M-d H:m:s").parse("${myMap['DATE']}");
    String date = DateFormat('MMMEd').format(myDate);
    String time = TimeOfDay.fromDateTime(myDate).format(context);

    return Card(
      elevation: 0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Chip(label: myMap['SPECIALITY'] != '--' ?Text('${myMap['SPECIALITY']}',
            style: TextStyle(fontSize: 10,fontWeight: FontWeight.w500),) : Text('General'),backgroundColor: Colors.grey[200],),
          Divider(height: 0,indent: 20,endIndent: 20,),
          Wrap(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 8.0,top: 8.0,bottom: 8.0),
                child: CircleAvatar(
                  backgroundImage: myMap['PROFILE_PICTURE']!='--'
                      ? NetworkImage("${imageLoc}patientImages/${myMap['PROFILE_PICTURE']}")
                      : ExactAssetImage('image/1.jpg'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Text('${myMap['FIRST_NAME']} ${myMap['LAST_NAME']}'),
                    SizedBox(height: 3,),
                    Text('$date . $time',style: TextStyle(color: Colors.grey,
                        fontSize: MediaQuery.of(context).size.width/30)),
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('${myMap['QUESTION']}'),
          ),
          Divider(),
          FlatButton(
            child: Text('Answers'),
            textColor: Colors.grey[700],
            onPressed: (){
              showGeneralDialog(
                  barrierLabel: "Label",
                  barrierDismissible: true,
                  barrierColor: Colors.black54,
                  context: context,
                  pageBuilder: (context,anim1,anim2){
                    return Align(
                      alignment: Alignment.bottomCenter,
                      child: Card(
                        color: Colors.grey[200],
                        shape: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(10)
                        ),
                        child: SizedBox(
                            height: MediaQuery.of(context).size.height*0.95,
                            width: MediaQuery.of(context).size.width *0.95,
                            child: FutureBuilder(
                              future: AnswerAPI().getAnswer(myMap['QUESTION_NUM']),
                              builder: (context,ss){
                                if(ss.hasError){
                                  print('Error');
                                }
                                if(ss.hasData){
                                  List answers = ss.data;
                                  if(answers.length != 0){
                                    return ListView.builder(
                                      itemCount: answers.length,
                                      itemBuilder: (context,position){
                                        return _answerCard(answers[position]);
                                      },
                                    );
                                  }else{
                                    return Center(child: Text('No answers yet!'),);
                                  }
                                }else return Loader();
                              },
                            )
                        ),
                      ),
                    );
                  },
                  transitionBuilder: (context,anim1,anim2,child){
                    return SlideTransition(
                      position: Tween(begin: Offset(0, 1), end: Offset(0, 0)).animate(anim1),
                      child: child,
                    );
                  },
                transitionDuration: Duration(milliseconds: 150),
              );
            },
          ),
        ],
      ),
    );
  }


  Widget _answerCard(Map answersMap) {
    print(answersMap);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        color: Colors.white,
        shape: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Wrap(
                children: <Widget>[
                SizedBox(
                  height: Style().getWidthSize(context)*0.1,
                  width: Style().getWidthSize(context)*0.1,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: MyCustomImage(
                      height: Style().getWidthSize(context)*0.1,
                      width: Style().getWidthSize(context)*0.1,
                      image: "${imageLoc}doctorImages/${answersMap['PROFILE_PICTURE']}",
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('${answersMap['FIRST_NAME']} ${answersMap['LAST_NAME']} (${answersMap['TITLE']})'),
                ),
              ],),
            ),
            Card(elevation: 0,color: Colors.grey[200],shape: OutlineInputBorder(borderRadius: BorderRadius.circular(10),borderSide: BorderSide.none),child:Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('${answersMap['ANSWER']}',textAlign: TextAlign.left,),
            ))
          ],
        ),
      ),
    );
  }
}
