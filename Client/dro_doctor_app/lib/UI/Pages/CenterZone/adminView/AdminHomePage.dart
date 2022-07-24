import 'package:dro_doctor_app/UI/Custom/MyPageRoute.dart';
import 'package:dro_doctor_app/UI/Pages/Common/AddInsurancePage.dart';
import 'package:dro_doctor_app/UI/Pages/Common/OffersPage.dart';
import 'package:dro_doctor_app/UI/Pages/Common/ReservationsPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'CenterDoctors/ControllerPage.dart';
import 'CenterSettingsPage.dart';

class AdminHomePage extends StatelessWidget {

  final String doctorID,centerID,docAdmin;

  AdminHomePage(this.doctorID,this.centerID,this.docAdmin);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home'),automaticallyImplyLeading: false,),
      body: StaggeredGridView.countBuilder(
        crossAxisCount: 4,
        itemCount: 5,
        itemBuilder: (BuildContext context, int index) =>  Card(
            elevation: 2,
            margin: EdgeInsets.all(2),
            color: index.isEven ? Colors.blue[200] : Colors.blue[50],
            child: new Center(
                child: index == 0 ? ListTile(
                  onTap:() {
                    MyPageRoute().routeNow(context, CenterDoctorsPage(doctorID,centerID,docAdmin));
                  },
                  title: Text('Doctors'),
                  leading: Icon(Icons.perm_identity),
                )
                    : index == 1 ?  ListTile(
                  title: Text('Reservations'),
                  leading: Icon(Icons.calendar_today),
                  onTap: ()=>MyPageRoute().routeNow(context,ReservationPage('-1',doctorID,centerID,0)),
                )
                    : index == 2 ? ListTile(
                  onTap: ()=>MyPageRoute().routeNow(context, CenterSettings(doctorID,centerID,docAdmin)),
                  title: Text('Settings'),
                  leading: Icon(Icons.settings),
                )
                    : index == 3 ? ListTile(
                  title: Text('Offers'),
                  leading: Icon(Icons.local_offer),
                  onTap: ()=>MyPageRoute().routeNow(context, OffersPage(doctorID,'-1',centerID)),
                )
                    : index == 4 ? ListTile(
                  onTap: ()=>MyPageRoute().routeNow(context, InsurancePage('-1',centerID)),
                  title: Text('Insurance'),
                  leading: Icon(Icons.local_hospital),
                )
                    : Text('')
            )),
        staggeredTileBuilder: (int index) =>
        new StaggeredTile.count(2, index.isEven ? 1:2),
        mainAxisSpacing: 4.0,
        crossAxisSpacing: 4.0,
      ),
    );
  }
}
