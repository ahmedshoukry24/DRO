import 'package:dro_doctor_app/APIs/AlarmAPI/SetAlarm.dart';
import 'package:dro_doctor_app/APIs/QuestionsAPI.dart';
import 'package:dro_doctor_app/APIs/mainURL/mainURL.dart';
import 'package:dro_doctor_app/UI/Custom/MyCustomImage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';

class QuestionsPage extends StatefulWidget {


  final String doctorID,specialty;

  QuestionsPage(this.doctorID,this.specialty);

  @override
  _QuestionsPageState createState() => _QuestionsPageState();
}

class _QuestionsPageState extends State<QuestionsPage> {

  TextEditingController _answerController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Questions'),
      ),
      body: FutureBuilder(
        future: QuestionsAPI().getQuestions(specialty: widget.specialty),
        builder: (BuildContext context,AsyncSnapshot ss){
          if(ss.hasError){
            print('Error');
          }
          if(ss.hasData){
            List myData = ss.data;
            print(myData);
            return ListView.builder(
              itemCount: myData.length,
              itemBuilder: (context,position){
                return _showQuestionForm(myData[position]);
              },
            );
          }else{
            return SpinKitRipple(color: Colors.blue[800],);
          }
        },
      ),
    );
  }

  Widget _showQuestionForm(Map myMap) {

    DateTime myDate = DateFormat("yyy-M-d H:m:s").parse("${myMap['DATE']}");
    String date = DateFormat('MMMEd').format(myDate);
    String time = TimeOfDay.fromDateTime(myDate).format(context);

    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Chip(label:Text('${myMap['SPECIALITY']}',
            style: TextStyle(fontSize: 10,fontWeight: FontWeight.w500),)),
          Divider(height: 0,indent: 20,endIndent: 20,),
          Wrap(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 8.0,top: 8.0,bottom: 8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: MyCustomImage(
                    width: MediaQuery.of(context).size.width/10,
                    height: MediaQuery.of(context).size.width/10,
                    image: '${imageLoc}patientImages/${myMap['PROFILE_PICTURE']}',
                  ),
                )
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Text('${myMap['FIRST_NAME']} ${myMap['LAST_NAME']}'),
                    SizedBox(height: 3,),
                    Text('$date . $time',style: TextStyle(color: Colors.grey)),
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
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: _answerController,
                    maxLines: 10,
                    minLines: 1,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey[300],
                      isDense: true,
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(15),
                      )
                    ),
                  ),
                ),
                IconButton(
                  onPressed: (){
                    if(_answerController.text.length > 5){
                      _postAnswer(questionNum: myMap['QUESTION_NUM'],doctorID: widget.doctorID,answer: _answerController.text);
                      SetAlarmAPI().setAlarm(
                        title: 'Question',
                        body: 'answer',
                        patientID: myMap['PATIENT_ID']
                      );
                    }
                  },
                  icon: Icon(Icons.send),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  _postAnswer({String questionNum,String doctorID,String answer}) async {
    bool res = await QuestionsAPI().postAnswer(doctorID: doctorID,questionNum: questionNum,answer: answer);

    if(res){
      setState(() {

      });
    }
  }

}
