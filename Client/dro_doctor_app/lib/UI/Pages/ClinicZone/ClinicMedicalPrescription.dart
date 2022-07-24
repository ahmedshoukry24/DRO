import 'package:dro_doctor_app/APIs/AlarmAPI/SetAlarm.dart';
import 'package:dro_doctor_app/APIs/prescriptionAPI.dart';
import 'package:dro_doctor_app/APIs/uploadImage/uploadImage.dart';
import 'package:dro_doctor_app/UI/Custom/CustomDialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ClinicMedicalPrescription extends StatefulWidget {

  final String patientID,doctorID,clinicID;

  ClinicMedicalPrescription(this.patientID,this.doctorID,this.clinicID);

  @override
  _ClinicMedicalPrescriptionState createState() => _ClinicMedicalPrescriptionState();
}

class _ClinicMedicalPrescriptionState extends State<ClinicMedicalPrescription> {

  TextEditingController noteController = TextEditingController();
  var image;
  UploadImage uploadImage = UploadImage();
  PrescriptionAPI prescriptionAPI = PrescriptionAPI();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Prescription'),automaticallyImplyLeading: false,),
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
                    // ********
                    showDialog(context: context,
                        barrierDismissible: false,
                        builder: (context){
                      return MyCustomDialog(
                        content: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CircularProgressIndicator(),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('Loading...'),
                            )
                          ],
                        ),
                      );
                    });
                    // ***********
                    image = await uploadImage.getImage('C').whenComplete(() => Navigator.pop(context));
                  },
                ),
              ],
            ),
          ),
          FlatButton(
            child: Text('Save'),
            onPressed: ()async{
              // ********
              showDialog(context: context,
                  barrierDismissible: false,
                  builder: (context){
                return MyCustomDialog(
                  content: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CircularProgressIndicator(),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Loading...'),
                      )
                    ],
                  ),
                );
              });
              // ***********
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
                    Navigator.pop(context);
                    showDialog(context: context,builder: (context)=>MyCustomDialog(title: Text('Done'),));
                    SetAlarmAPI().setAlarm(patientID: widget.patientID,
                        title: 'Medical Prescription',
                        body: 'You just receive a medical prescription, please check it');
                  }
                }

              }
            },
          ),

        ],
      ),
    );
  }

}
