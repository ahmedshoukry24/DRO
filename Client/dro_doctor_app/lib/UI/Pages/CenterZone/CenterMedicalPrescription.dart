import 'package:dro_doctor_app/APIs/AlarmAPI/SetAlarm.dart';
import 'package:dro_doctor_app/APIs/AllAboutCenter/centerDoctorsAPI.dart';
import 'package:dro_doctor_app/APIs/mainURL/mainURL.dart';
import 'package:dro_doctor_app/APIs/prescriptionAPI.dart';
import 'package:dro_doctor_app/APIs/uploadImage/uploadImage.dart';
import 'package:dro_doctor_app/Model/doctor.dart';
import 'package:dro_doctor_app/UI/Custom/CustomDialog.dart';
import 'package:dro_doctor_app/UI/Custom/MyCustomImage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class CenterMedicalPrescription extends StatefulWidget {

  final String patientID,doctorID,centerID;
  CenterMedicalPrescription(this.patientID,this.doctorID,this.centerID);

  @override
  _CenterMedicalPrescriptionState createState() => _CenterMedicalPrescriptionState();
}

class _CenterMedicalPrescriptionState extends State<CenterMedicalPrescription> {

  String selectedDoctor;
  TextEditingController noteController = TextEditingController();
  var image;
  UploadImage uploadImage = UploadImage();
  PrescriptionAPI prescriptionAPI = PrescriptionAPI();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Medical History'),
      ),
      body: ListView(
        shrinkWrap: true,
        children: [
          TextFormField(
            maxLines: MediaQuery.of(context).size.width~/30,
            controller: noteController,
            decoration: InputDecoration(
              hintText: 'Write notes!',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
              fillColor: Colors.grey[200],
              filled: true,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                FlatButton(
                  textColor: Colors.grey[800],
                  child: Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.photo),
                        Text('Upload prescription'),
                      ],
                    ),
                  ),
                  onPressed: ()async{
                    image = await uploadImage.getImage('G');
                  },
                ),
                FlatButton(
                  textColor: Colors.grey[800],
                  child: Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.camera_alt),
                        Text('Capture prescription'),
                      ],
                    ),
                  ),
                  onPressed: ()async{
                    image = await uploadImage.getImage('C');
                  },
                ),
              ],
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.width*0.3,
            child: FutureBuilder(
              future: CenterDoctorsAPI().getCenterDoctors(centerID: widget.centerID),
              builder: (context,ss){
                if(ss.hasError){
                  print('Error');
                }
                if(ss.hasData){
                  List<DoctorModel> doctors = ss.data;
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: doctors.length,
                      itemBuilder: (context,position){
                    return doctorCard(doctors[position]);
                  });
                }else{
                  return SpinKitRipple(color: Colors.blue[800],);
                }
              },
            ),
          ),
          FlatButton(
            child: Text('Save'),
            onPressed: ()=>_saveButton(),
          ),

        ],
      )
    );
  }

  _saveButton()async{
    if(selectedDoctor != null){
      if(image==null && noteController.text.length<1){
        showDialog(context: context,builder: (context){
          return MyCustomDialog(
            title: Text('Write a note or send a photo'),
          );
        });
      }
      else{
        bool result =  image != null ? await uploadImage.upload(image, 'P') : true;
        if(result){
          bool res = await prescriptionAPI.setPrescription(
              patientID: widget.patientID,
              doctorID: widget.doctorID,
              description: noteController.text.length < 1? '--' : noteController.text,
              image: image == null ?'--' : uploadImage.imageName
          );
          if(res){
            noteController.clear();
            image = null;
            Navigator.pop(context);
            showDialog(context: context,builder: (context)=>MyCustomDialog(title: Text('Done'),));
            SetAlarmAPI().setAlarm(patientID: widget.patientID,
                title: 'Medical Prescription',
                body: 'You just receive a medical prescription, please check it');
          }
        }
      }
    }else{
      showDialog(context: context,builder: (context){
        return MyCustomDialog(
          title: Text('Please select doctor'),
        );
      });
    }
    }
  Widget doctorCard(DoctorModel doctor){
    return InkWell(
      onTap: ()=>setState(()=>selectedDoctor = doctor.id),
      child: Card(
        shape: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(10)
        ),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: MyCustomImage(
                image: '${imageLoc}doctorImages/${doctor.profilePicture}',
                height: MediaQuery.of(context).size.width*0.3,
                width: MediaQuery.of(context).size.width*0.3,
              ),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black45,
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10),bottomRight: Radius.circular(10))
                ),
                height: MediaQuery.of(context).size.width*0.1,
                width: MediaQuery.of(context).size.width*0.3,
                child: Center(child: Text('${doctor.fName} ${doctor.lName}',style: TextStyle(color: Colors.white),)),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: selectedDoctor == doctor.id ? Colors.black45 : Colors.transparent,
                borderRadius: BorderRadius.circular(10)
              ),
              height: MediaQuery.of(context).size.width*0.3,
              width: MediaQuery.of(context).size.width*0.3,
            )
          ],
        ),
      ),
    );
  }
}
