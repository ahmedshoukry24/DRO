
import 'package:dro_patient_app/UI/Parts/Loader.dart';

import '../OfflineDatabase/helper.dart';
import '../OfflineDatabase/model.dart';

import '../APIs/loginAPI.dart';
import '../Model/patient.dart';
import 'package:flutter/material.dart';

import 'MainPages/homePage.dart';
import 'SignUpPage.dart';
import 'StartPage.dart';

class LoginPage extends StatefulWidget {
  @override
  State createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  bool visibility= true;

  Color iconColor = Colors.grey;

  LoginAPI loginAPI = LoginAPI();
  Patient patient;

  //** offline database
  DatabaseHelper db = DatabaseHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('login',style: TextStyle(fontWeight: FontWeight.w600),),
        elevation: 0,
      ),
      body: Form(
          key: formKey,
          child: ListView(
            children: <Widget>[
              _logo(),
              _body(),
              _footer(),
            ],
          )),
    );
  }

  Widget _logo() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 30),
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

  Widget _body() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[

          // *** email ***
          TextFormField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              icon: Icon(Icons.email,color: iconColor,),
              hintText: 'e-mail',
            ),
            validator: (value) =>
            value.length >= 14 &&
                (value.toLowerCase().contains('@yahoo.com') || value.toLowerCase().contains('@gmail.com') ||value.toLowerCase().contains('@hotmail.com')) &&
                !value.contains(' ') ? null : 'Enter a valid email',
            onSaved: (value) => _emailController.text = value,
          ),
          SizedBox(
            height: 10.0,
          ),

          // *** password ***
          TextFormField(
            controller: _passwordController,
            decoration: InputDecoration(
              icon: Icon(
                Icons.lock_outline,
                color: iconColor,
              ),
              suffixIcon: InkWell(
                  onTap: () {
                    _onChangedVisibility();
                  },
                  child: visibility == true ?Icon(Icons.visibility_off,color:iconColor,) : Icon(Icons.remove_red_eye,color:iconColor,)),
              hintText: 'Password',
            ),
            obscureText: visibility,
            validator: (value) =>
            value.length >= 5 ? null : 'Enter a valid password',
            onSaved: (value) => _passwordController.text = value,
          ),
        ],
      ),
    );
  }

  Widget _footer(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 30, bottom: 10.0,right: 20.0,left: 20.0),
          child: RaisedButton(
            elevation: 0.9,
            onPressed: () => validationValues(),
            child: Text('Login'),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Don\'t have an account? '),
            InkWell(
              onTap:(){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUpPage()));
              },
              child: Text('Sign Up',style: TextStyle(color: Colors.blue[800]),),)
          ],
        ),
      ],
    );
  }

  validationValues()async{
    var key = formKey.currentState;
    if (key.validate()) {
      key.save();
      showDialog(context: context,
          barrierDismissible: false,
          builder: (context){
        return AlertDialog(
          content: SizedBox(
            height: MediaQuery.of(context).size.width*0.1,
              child: Loader()),
        );
      });
      patient = await loginAPI.login(_emailController.text, _passwordController.text);
      if(patient.email == '0'){
        Navigator.pop(context);
        return showDialog(
          context: context,
          builder: (context){
            return AlertDialog(
              title: Text('Invalid email or password'),
              actions: <Widget>[
                FlatButton(
                  onPressed: ()=>Navigator.pop(context),
                  child: Text('Ok'),
                ),
              ],
            );
          }
        );
      }else{
        Navigator.pop(context);
        _save(patient);
        Navigator.pushAndRemoveUntil(context,
            MaterialPageRoute(builder: (context)=>StartPage(patient.id)),(Route<dynamic>route)=>false);
      }

    }
  }

  _save(Patient patient)async{
    await db.saveUser(OfflinePatient(email: patient.email,status: '1',id: patient.id,fName: patient.fName,lName: patient.lName));
    //** to make sure that everything is ok
    List users = await db.getAllUsers();
    print(users);
    //**
  }



  void _onChangedVisibility() {
    setState(() {
      visibility = !visibility;
    });
  }
}
