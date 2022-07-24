import '../OfflineDatabase/helper.dart';
import '../OfflineDatabase/model.dart';
import 'Pages/Home.dart';

import '../Model/doctor.dart';

import '../APIs/signUpAPI.dart';
import '../Logo/logo.dart';
import '../Model/specialties/dropdown.dart';
import '../Model/specialties/title.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SignUpPage extends StatefulWidget {
  State createState() => SignUpPageState();
}

class SignUpPageState extends State<SignUpPage> {

  final formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController fNameController = TextEditingController();
  TextEditingController mNameController = TextEditingController();
  TextEditingController lNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  List<int> days = List<int>();
  List<int> months = List<int>();
  List<int> years = List<int>();

  int dayValue;
  int monthValue;
  int yearValue;
  String date;
  String genderValue;

  Color iconColor = Colors.grey; // email, password, phone, name.

  DropdownSpecialties dropdownSpecialties;
  DropdownTitle dropdownTitle;

  SignUpAPI signUpAPI = SignUpAPI();

  DatabaseHelper db = DatabaseHelper();


  @override
  void initState() {
    super.initState();
    for(int i=1; i<=31;i++){
      days.add(i);
    }
    for(int i=1; i<=12;i++){
      months.add(i);
    }
    for(int i=1920;i<=2015;i++){
      years.add(i);
    }
    dropdownSpecialties = DropdownSpecialties();
    dropdownTitle = DropdownTitle();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
      ),
      body: Form(
          key: formKey,
          child: ListView(
            children: <Widget>[

              Logo(),
              // *** name ***
              nameWidget(),
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
              // *** specialty ***
              specialty(),
              // *** title ***
              title(),
              // *** birth date ***
              birthDateWidget(),
              // *** gender ***
              genderWidget(),
              // *** sign up button ***
              _footer(),
            ],
          )),
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
  Widget specialty(){
    return Padding(
      padding: const EdgeInsets.only(left: 20.0,right: 20.0,top: 20.0),
      child: Column(
        children: <Widget>[
          sharedRow('Specialty'),
          dropdownSpecialties
        ],
      ),
    );
  }
  Widget title(){
    return Padding(
      padding: const EdgeInsets.only(left: 20.0,right: 20.0,top: 20.0),
      child: Column(
        children: <Widget>[
          sharedRow('title'),
          dropdownTitle,
        ],
      ),
    );
  }
  Widget birthDateWidget() {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: sharedRow('Birth Date'),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 5.0,right: 5.0),
                  child: DropdownButton(
                    items: days.map((item){
                    return DropdownMenuItem(child: Text('$item'),value: item,);
                  }).toList(),
                    onChanged: (value){
                      setState(() {
                        dayValue = value;
                      });
                    },
                    value: dayValue,
                    hint: Text('Day'),
                    isExpanded: true,
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 5.0),
                  child: DropdownButton(
                    items: months.map((item){
                    return DropdownMenuItem(child: Text('$item'),value: item,);
                  }).toList(),
                    onChanged: (value){
                      setState(() {
                        monthValue = value;
                      });
                    },
                    value: monthValue,
                    hint: Text('Month'),
                    isExpanded: true,
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 5.0),
                  child: DropdownButton(
                      items: years.map((item){
                    return DropdownMenuItem(child: Text('$item'),value: item,);
                  }).toList(),
                      onChanged: (value){
                        setState(() {
                          yearValue = value;
                        });
                      },
                    value: yearValue,
                    hint: Text('Year'),
                    isExpanded: true,
                  ),
                ),
              )

            ],
          ),
        ],
      ),
    );
  }
  Widget genderWidget() {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0,bottom: 20.0),
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: sharedRow('Gender'),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0,right: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
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
                )

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
        shape: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }


  // *** shared row ***
  Widget sharedRow(String name){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Flexible(
            child: Divider(
              color: Colors.grey,
              indent: 50.0,
            )),
        Flexible(
            child: Text(
              '  $name  ',
              style: TextStyle(color: Colors.grey),
            )),
        Flexible(
            child: Divider(
              color: Colors.grey,
              endIndent: 50.0,
            )),
      ],
    );
  }

  something(value){
    setState(() {
      genderValue = value;
    });
  }


  void validationValues() async{
    final key = formKey.currentState;
    if (key.validate() && genderValue != null && dropdownSpecialties.result != null && dropdownTitle.result != null &&
        dayValue != null && monthValue !=null && yearValue != null) {
        key.save();
        date = '$yearValue-$monthValue-$dayValue';
        DoctorModel doctor = await signUpAPI.signUpAPI(
          fN: fNameController.text,
          lN:lNameController.text,
          phone: phoneController.text,
          password:passwordController.text,
          email: emailController.text,
          date: date,
          gender: genderValue,
          specialty: dropdownSpecialties.result,
          title: dropdownTitle.result,);

        if(doctor.email == '0'){
          _ackAlert(context,'This email used','Someone use ${emailController.text}');
        }else{
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>Home(doctor.id, 2,)),
              (Route<dynamic>route)=>false);
          _save(doctor);
        }
    }else{
      return _ackAlert(context,'Not completed data','You must fill all fields');
    }
  }

  _save(DoctorModel doctor)async{
    await db.saveUser(OfflineUser(email: doctor.email,id: doctor.id,fName: doctor.fName,lName: doctor.lName,status: '1'));
    List users = await db.getAllUsers();
    print("All user in offline database::: $users");
  }

  _ackAlert(BuildContext context,String title,String content) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('$title'),
          content: Text('$content'),
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
}




