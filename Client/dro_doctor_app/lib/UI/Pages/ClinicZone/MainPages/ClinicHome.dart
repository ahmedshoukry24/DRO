import 'package:dro_doctor_app/UI/Custom/MyPageRoute.dart';
import 'package:dro_doctor_app/UI/Pages/Common/AddInsurancePage.dart';
import 'package:dro_doctor_app/UI/Pages/Common/OffersPage.dart';
import 'package:flutter/cupertino.dart';
import '../../../../APIs/AllAboutClinic/clinicInfoAPI.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../../Common/ReservationsPage.dart';
import 'ClinicSettingsPage.dart';

class ClinicHome extends StatefulWidget {

  final String clinicID;
  final String doctorID;
  ClinicHome(this.clinicID,this.doctorID);

  @override
  _ClinicHomeState createState() => _ClinicHomeState();
}

class _ClinicHomeState extends State<ClinicHome> with SingleTickerProviderStateMixin{

  // API class
  ClinicInfoAPI clinicInfo = ClinicInfoAPI();


  List<Widget> cardName(int index){
    return [
      customCard('Reservations', Icons.calendar_today, ()=>ReservationPage(widget.clinicID,widget.doctorID,'-1',0),index: index),
      customCard('Settings', Icons.settings, ()=>ClinicSettingsPage(widget.clinicID,widget.doctorID,),index: index),
      customCard('Offers', Icons.local_offer, ()=>OffersPage(widget.doctorID,widget.clinicID,'-1'),index: index),
      customCard('Insurance', Icons.local_hospital, ()=>InsurancePage(widget.clinicID,'-1'),index: index),
    ];
  }

  Widget customCard(String name,IconData icon,Function direction,{int index}){
    return Card(
      color: index.isEven ? Colors.blue[200] : Colors.blue[50],
      margin: EdgeInsets.all(5),
      elevation: 1,
      child: Center(
        child: ListTile(
          title: Text('$name',style: TextStyle(fontSize: 15),),
          leading: Icon(icon),
          onTap: ()=>MyPageRoute().routeNow(context, direction()),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: FutureBuilder(
          future: clinicInfo.getClinicInfo(widget.clinicID),
          builder: (context,ss){
            if(ss.hasError){
              print('Error ::: Clinic Home ::: snapShot hasError');
            }
            if(ss.hasData){
              List myClinic = ss.data;
              return myClinic[0]['CLINIC_NAME'] != '--' ? Text('${myClinic[0]['CLINIC_NAME']}',) :
              Text('Dr. ${myClinic[0]['FIRST_NAME']} ${myClinic[0]['LAST_NAME']}');
            }else{
              return Material(child: Center(child: Text('Loading...')));
            }
          },
        ),
      ),
      body: StaggeredGridView.countBuilder(
        crossAxisCount: 4,
        itemCount: 4,
        itemBuilder: (context,index){
          return cardName(index)[index];
        },
        staggeredTileBuilder: (index)=> StaggeredTile.count(2, index.isEven?1:2),
        mainAxisSpacing: 2.0,
        crossAxisSpacing: 2.0,
      ),
    );
  }
}