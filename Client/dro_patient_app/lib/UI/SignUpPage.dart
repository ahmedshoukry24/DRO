import 'package:intl/intl.dart';
import 'StartPage.dart';
import 'package:table_calendar/table_calendar.dart';
import '../OfflineDatabase/helper.dart';
import '../OfflineDatabase/model.dart';
import '../APIs/signUpAPI.dart';
import '../Model/patient.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SignUpPage extends StatefulWidget {
  State createState() => SignUpPageState();
}

class SignUpPageState extends State<SignUpPage> {

  TextEditingController emailController = TextEditingController();
  TextEditingController fNameController = TextEditingController();
  TextEditingController lNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController dayController = TextEditingController();
  TextEditingController monthController = TextEditingController();
  TextEditingController yearController= TextEditingController();

  final formKey = GlobalKey<FormState>();

  // birthDate
  CalendarController calenderController = CalendarController();



  int dayValue;
  int monthValue;
  int yearValue;

  Color iconColor ;

  String genderValue;
  Color genderColor;

  SignUpAPI signUp;
  Patient patient;

  DatabaseHelper db ;

  void initState() {
    super.initState();
    iconColor= Colors.grey;
    genderColor = Colors.grey;
    signUp = SignUpAPI();
    db = DatabaseHelper();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up',style: TextStyle(fontWeight: FontWeight.w600),),
        elevation: 0,
      ),
      body: Form(
          key: formKey,
          child: ListView(
            children: <Widget>[
              logo(),

              // *** name ***
              nameWidget(),

              // *** phone ***
              Padding(
                padding: const EdgeInsets.only(
                    left: 20.0, right: 20.0, bottom: 10.0),
                child: TextFormField(
                  controller: phoneController,
                  textInputAction: TextInputAction.next,
                  validator: (value) => value.length == 11 &&
                          ((value.startsWith('010')) ||
                              value.startsWith('011') ||
                              value.startsWith('012'))
                      ? null
                      : 'phone number should start with 010,011, or 012\n and contains 11 numbers',
                  onSaved: (value) => phoneController.text = value,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    hintText: 'Phone number',
                    icon: Icon(
                      Icons.phone,
                      color: iconColor,
                    ),
                  ),
                ),
              ),

              // *** e-mail ***
              Padding(
                padding: const EdgeInsets.only(
                    left: 20.0, right: 20.0, bottom: 10.0),
                child: TextFormField(
                  controller: emailController,
                  textInputAction: TextInputAction.next,
                  validator: (value) => value.length >= 14 &&
                          (value.toLowerCase().contains('@yahoo.com') ||
                              value.toLowerCase().contains('@gmail.com') ||
                              value.toLowerCase().contains('@hotmail.com')) &&
                          !value.contains(' ')
                      ? null
                      : 'Enter a valid email',
                  onSaved: (value) => emailController.text = value,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: 'E-mail',
                    icon: Icon(Icons.email, color: iconColor),
                  ),
                ),
              ),

              // *** password ***
              Padding(
                padding: const EdgeInsets.only(
                    left: 20.0, right: 20.0, bottom: 10.0),
                child: TextFormField(
                  controller: passwordController,
                  textInputAction: TextInputAction.next,
                  obscureText: true,
                  validator: (value) => value.length >= 5
                      ? null
                      : 'password should be at least 5 character',
                  onSaved: (value) => passwordController.text = value,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    icon: Icon(Icons.lock_open, color: iconColor),
                  ),
                ),
              ),

              // *** birth date ***
              Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FlatButton(
                    child: Text('BitrhDate'),
                    onPressed: (){
                      showDatePicker(context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1960),
                          lastDate: DateTime.now(),
                        builder: (BuildContext context, Widget child) {
                        return Theme(
                          data: ThemeData.light().copyWith(
                            colorScheme: ColorScheme.light(primary: Colors.blue[800]),
                            buttonTheme: ButtonThemeData(
                                textTheme: ButtonTextTheme.primary
                            ),
                          ),
                          child: child,
                        );
                      },
                      ).then((value) {
                        if(value!=null){
                          setState(() {
                            dayValue = value.day;
                            monthValue = value.month;
                            yearValue = value.year;
                          });
                        }
                      });
                    },
                  ),
                  yearValue != null ? Padding(
                    padding: const EdgeInsets.fromLTRB(8.0,0,8.0,8.0),
                    child: Text('${DateFormat("yMMMMd").format(DateFormat("yyy-M-d").parse("$yearValue-$monthValue-$dayValue"))}'),
                  ) : Container()
                ],
              ),
              // *** gender ***
              genderWidget(),

              // *** sign up button ***
              _footer(),

            ],
          )),
    );
  }

  Widget logo() {
    return Padding(
      padding: const EdgeInsets.only(
          top: 20.0, left: 20.0, right: 20.0, bottom: 30.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          CircleAvatar(
            radius: 50,
            backgroundColor: Colors.transparent,
            backgroundImage: ExactAssetImage('image/DRO.jpg'),
          ),
        ],
      ),
    );
  }

  // *** body ***
  Widget nameWidget() {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          // *** first name ***
          Flexible(
            child: TextFormField(
              controller: fNameController,
              textInputAction: TextInputAction.next,
              validator: (value) =>
                  value.length < 2 ? 'Enter a valid name' : null,
              onSaved: (value) => fNameController.text = value,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                  hintText: 'First name',
                  icon: Icon(Icons.person, color: iconColor)),
            ),
          ),
          SizedBox(
            width: 10.0,
          ),

          // *** last name ***
          Flexible(
            child: TextFormField(
              controller: lNameController,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.text,
              validator: (value) =>
                  value.length < 2 ? 'Enter a valid name' : null,
              onSaved: (value) => lNameController.text = value,
              decoration: InputDecoration(
                hintText: 'Last name',
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget genderWidget() {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 10.0),
      child: Column(
        children: <Widget>[
         Padding(
           padding: const EdgeInsets.fromLTRB(8.0,0,8.0,8.0),
           child: Row(
             mainAxisAlignment: MainAxisAlignment.center,
             children: [
               Row(
                 children: <Widget>[
                   Radio(value: "Male",groupValue: genderValue,onChanged: (e)=>something(e),activeColor: Colors.black,
                     materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,),
                   Text('Male'),
                 ],
               ),
               SizedBox(width: 20.0,),
               Row(
                 children: <Widget>[
                   Radio(value: "Female",groupValue: genderValue,onChanged: (e)=>something(e),activeColor: Colors.black,
                     materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,),
                   Text('Female'),
                 ],
               ),
             ],
           ),
         )
        ],
      ),
    );
  }

  // *** footer ***
  Widget _footer() {
    return Padding(
      padding: const EdgeInsets.only(right: 20.0, left: 20.0, bottom: 10.0),
      child: RaisedButton(
        elevation: 0.9,
        onPressed: () => validationValues(),
        child: Text('Sign Up'),
      ),
    );
  }

  something(value){
    setState(() {
      genderValue = value;
    });
  }

  _ackAlert(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Not completed data'),
          content: const Text('You must fill all fields'),
          actions: <Widget>[
            FlatButton(
              child: Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
            ),
          ],
        );
      },
    );
  }


  void validationValues()async{
    final key = formKey.currentState;
    if (key.validate() && genderValue != null) {
        key.save();
        String date = '$yearValue-$monthValue-$dayValue';

        patient = await signUp.signUp(fNameController.text, lNameController.text, phoneController.text, emailController.text,
            passwordController.text, date, genderValue);
        if(patient.email == '0'){
          return showDialog(
            context: context,
            builder: (context){
              return AlertDialog(
                content: Text('This email is used'),
                actions: <Widget>[
                  FlatButton(
                    child: Text('OK'),
                    onPressed: ()=> Navigator.pop(context),
                  )
                ],
              );
            }
          );
        }else{
          Navigator.pushAndRemoveUntil(context,
              MaterialPageRoute(builder: (context)=>StartPage(patient.id,)), (Route<dynamic>route)=>false);
          _save(patient);
        }

    }else{
      return _ackAlert(context);
    }
  }
  _save(Patient patient)async{
    await db.saveUser(OfflinePatient(email: patient.email,status: '1',id: patient.id,fName: patient.fName,lName: patient.lName));
    //** to make sure that everything is ok
    List users = await db.getAllUsers();
    print(users);
    //**

  }

}
