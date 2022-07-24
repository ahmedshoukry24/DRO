import '../Model/doctor.dart';
import '../OfflineDatabase/helper.dart';
import '../OfflineDatabase/model.dart';
import '../UI/Pages/Home.dart';
import '../APIs/loginAPI.dart';
import '../Logo/logo.dart';
import 'package:flutter/material.dart';
import 'SignUpPage.dart';

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

  //** offline database
  DatabaseHelper db = DatabaseHelper();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('login'),
      ),
      body: Form(
          key: formKey,
          child: ListView(
            children: <Widget>[
              Logo(),
              _body(),
              _footer(),
            ],
          )),
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
                (value.toLowerCase().contains('@yahoo.com')
                    || value.toLowerCase().contains('@gmail.com')
                    ||value.toLowerCase().contains('@hotmail.com')) &&
                !value.contains(' ') ? null : 'Enter a valid email',
            onSaved: (value) => _emailController.text = value,
          ),
          SizedBox(
            height: 10.0,
          ),
          // *** password ***
          TextFormField(
            controller: _passwordController,
            keyboardType: TextInputType.text,
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
            shape: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(15),
            ),
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


  void validationValues() async{
    var key = formKey.currentState;
    if (key.validate()) {
      key.save();
      DoctorModel doctor = await loginAPI.login(_emailController.text, _passwordController.text);
      if(doctor.email == '0'){
        _alarm(context,'Check your email and password');
      }else{

        Navigator.pushAndRemoveUntil(context,
            MaterialPageRoute(builder: (context)=>Home(doctor.id, 0,)),
                (Route<dynamic>route)=>false);
        _save(doctor);
      }
    }
  }

  _save(DoctorModel doctor)async{
    await db.saveUser(OfflineUser(email: doctor.email,status: '1',id: doctor.id,fName: doctor.fName,lName: doctor.lName));
    List users = await db.getAllUsers();
    print("All user in offline database::: $users");
  }

  void _onChangedVisibility() {
    setState(() {
      visibility = !visibility;
    });
  }

  _alarm(context,String title){
    return showDialog(
        context: context,
        builder: (context){
          return AlertDialog(
            title: Text('$title'),
            actions: <Widget>[
              FlatButton(onPressed: ()=>Navigator.pop(context), child: Text('Ok')),
            ],
          );
        }
    );
  }
}


