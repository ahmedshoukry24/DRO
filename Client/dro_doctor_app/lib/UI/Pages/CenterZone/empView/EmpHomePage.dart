import 'package:dro_doctor_app/APIs/AllAboutCenter/centerDoctorsAPI.dart';
import 'package:dro_doctor_app/APIs/mainURL/mainURL.dart';
import 'package:dro_doctor_app/Model/doctor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';


class EmpHomePage extends StatelessWidget {

  final String doctorID,centerID,docAdmin;

  EmpHomePage(this.doctorID,this.centerID,this.docAdmin);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Center Doctors'),
        automaticallyImplyLeading: false,
      ),
      body: FutureBuilder(
        future: CenterDoctorsAPI().getCenterDoctors(centerID: centerID),
        builder: (context,ss){
          if(ss.hasError){
            print('Error in empView');
          }
          if(ss.hasData){
            List<DoctorModel> data = ss.data;
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context,position){
                return Padding(
                  padding: const EdgeInsets.only(top: 8.0,left: 8.0,right: 8.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white70,
                        borderRadius: BorderRadius.circular(8)
                    ),
                    child: Wrap(
                      children: <Widget>[
                        Container(
                          height: MediaQuery.of(context).size.width/5,
                          width: MediaQuery.of(context).size.width/5,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: data[position].profilePicture!= '--'
                                      ?NetworkImage('${imageLoc}doctorImages/${data[position].profilePicture}')
                                      : Icon(Icons.person)
                              )
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text('${data[position].fName} ${data[position].lName}'
                                  ' ${data[position].id == docAdmin ? '(admin)' : ''}'),
                              Text('${data[position].phone}'),
                              Text('${data[position].specialty}'),
//                      Text('${data[position]}')
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            );
          }else{
            return SpinKitRipple(color: Colors.blue[800],);
          }
        },
      ),
    );
  }
}
