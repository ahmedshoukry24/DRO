import 'OfflineDatabase/helper.dart';
import 'OfflineDatabase/model.dart';
import 'UI/Pages/Home.dart';
import 'package:flutter/material.dart';
import 'UI/LoginPage.dart';

void main()async{
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  static DatabaseHelper db = DatabaseHelper();


/*
Platform.isAndroid
Platform.isFuchsia
Platform.isIOS
Platform.isLinux
Platform.isMacOS
Platform.isWindows
 */
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DRO for doctor',
      color: Colors.white,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Domine',

        primaryIconTheme: IconThemeData(
            color: Colors.blue[800]
        ),
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        primaryColor: Colors.blue[800],
        accentColor: Colors.blue[800],
        appBarTheme: AppBarTheme(
          color: Colors.white,
          elevation: 0.8,
          textTheme: TextTheme(
            title: TextStyle(color: Colors.blue[800],fontSize: 20,fontFamily: 'Domine'),
          ),
          iconTheme: IconThemeData(
            color: Colors.blue[800],
          ),
        ),
        buttonTheme: ButtonThemeData(
            splashColor: Colors.transparent,
            buttonColor: Colors.white,
            textTheme: ButtonTextTheme.accent,
        ),
      ),
      home: FutureBuilder(
        future: db.getUser(),
        builder: (context,ss){
          if(ss.hasError){
            print('Error-------');
          }if(ss.hasData){
            OfflineUser user;
            user = ss.data;
            if(user.status != '1'){
              return LoginPage();
            }else if(user.status == '1'){
              return Home(user.id, 0);
            }else{
              return Text('Not 1 or null');
            }

          }else{
            return Material(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text('DRO',style: TextStyle(fontSize: 50,fontWeight: FontWeight.w800)),
                      Text('Doctor Reservation Online.',style: TextStyle(fontSize: 20),),
                      Text('Doctor version.')
                    ],
                  ),
                ));
          }
        },
      )
    );
  }

}

