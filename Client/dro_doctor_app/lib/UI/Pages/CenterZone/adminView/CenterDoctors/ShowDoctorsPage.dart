import 'package:dro_doctor_app/APIs/AllAboutCenter/centerDoctorsAPI.dart';
import 'package:dro_doctor_app/APIs/mainURL/mainURL.dart';
import 'package:dro_doctor_app/Model/doctor.dart';
import 'package:dro_doctor_app/UI/Custom/MyCustomImage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
class ShowDoctorsPage extends StatelessWidget {
  final String doctorID,docAdmin,centerID;
  ShowDoctorsPage(this.centerID,this.doctorID,this.docAdmin);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Center\'s doctors'),
        ),
        body: FutureBuilder(
          future:
          CenterDoctorsAPI().getCenterDoctors(centerID: centerID),
          builder: (context, ss) {
            if (ss.hasError) {
              print('Error');
            }
            if (ss.hasData) {
              List<DoctorModel> myData = ss.data;
              return ListView.builder(
                itemCount: myData.length,
                itemBuilder: (context, position) {
                  return _doctorCard(myData[position],docAdmin,context);
                },
              );
            } else {
              return SpinKitRipple(
                color: Colors.blue[800],
              );
            }
          },
        ));
  }


  Widget _doctorCard(DoctorModel myData,String docAdmin,BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Container(
        color: Colors.white70,
        child: Wrap(
          crossAxisAlignment: WrapCrossAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: MyCustomImage(
                  image: '${imageLoc}doctorImages/${myData.profilePicture}',
                  height: MediaQuery.of(context).size.width*0.15,
                  width: MediaQuery.of(context).size.width*0.15,
                ),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width*0.75,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Wrap(
                    children: <Widget>[
                      Text('Dr. ${myData.fName} ${myData.lName}',
                        style: TextStyle(fontWeight: FontWeight.w600),),
                      myData.id == docAdmin ? Text(' (admin)',style: TextStyle(color: Colors.grey),) : Text('')
                    ],
                  ),
                  Text('${myData.email}'),
                  Text('${myData.phone}'),
                  Text(
                    '${myData.specialty}',
                    style: TextStyle(color: Colors.blue[800]),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

}
