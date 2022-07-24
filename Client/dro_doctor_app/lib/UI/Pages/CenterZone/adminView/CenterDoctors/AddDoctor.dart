import 'package:dro_doctor_app/APIs/AllAboutCenter/centerDoctorsAPI.dart';
import 'package:dro_doctor_app/APIs/mainURL/mainURL.dart';
import 'package:dro_doctor_app/Model/doctor.dart';
import 'package:dro_doctor_app/UI/Custom/CustomDialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class AddDoctor extends StatefulWidget {
  final String centerID,doctorID,docAdmin;

  AddDoctor(this.centerID,this.doctorID,this.docAdmin);
  @override
  _AddDoctorState createState() => _AddDoctorState();
}

class _AddDoctorState extends State<AddDoctor> {

  List<DoctorModel> myResult;
  TextEditingController searchController ;
  GlobalKey<ScaffoldState> key = GlobalKey<ScaffoldState>();
  bool closeKeyboard = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    myResult = List<DoctorModel>();
    searchController= TextEditingController();
  }


  @override
  Widget build(BuildContext context) {
    List<DoctorModel> myData = List<DoctorModel>();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Material(
          color: Colors.grey[100],
          child: TextField(
            readOnly: closeKeyboard,
            onTap: (){
              setState(() {
                closeKeyboard = false;
              });
            },
            controller: searchController,
            decoration: InputDecoration(
              hintText: 'Email',
              isDense: true,
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(50),
              ),
            ),
            onChanged: (text) {
              text = text.toLowerCase();
              setState(() {
                if(searchController.text.length !=0){
                  myResult = myData.where((element) {
                    String x = element.email.toLowerCase();
                    return x.contains(text);
                  }).toList();
                }else{
                  myResult = [];
                }
              });

            },
          ),
        ),
        actions: <Widget>[
          Icon(
            Icons.search,
            color: Colors.black,
          ),
        ],
      ),
        key: key,
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: <Widget>[
              FutureBuilder(
                future: CenterDoctorsAPI().getDoctors(centerID: widget.centerID),
                builder: (context, ss) {
                  if (ss.hasError) {
                    print('error');
                  }
                  if (ss.hasData) {
                    myData = ss.data;
                    return ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: myResult.length,
                        itemBuilder: (context, position) {
                          return  _doctorCard(myResult[position]);
                        });
                  } else {
                    return SpinKitRipple(
                      color: Colors.blue[800],
                    );
                  }
                },
              )
            ],
          ),
        ));
  }



  Widget _doctorCard(DoctorModel doctor) {
    return doctor.id == widget.docAdmin ? Container():Card(
      child: ListTile(
        onTap: () {
          setState(() {
            _onTapBtn(doctor);
          });
        },
        title: Text('${doctor.fName} ${doctor.lName}'),
        subtitle: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('${doctor.phone}'),
            Text(
              '${doctor.specialty}',
            ),
          ],
        ),
        leading: GestureDetector(
          child: CircleAvatar(
            backgroundColor: Colors.transparent,
            radius: MediaQuery.of(context).size.width / 13,
            backgroundImage: doctor.profilePicture != '--'
                ? NetworkImage(
                '${imageLoc}doctorImages/${doctor.profilePicture}')
                : ExactAssetImage('image/1.jpg'),
          ),
          onTap: () {
            setState(() {
              closeKeyboard = true;
            });
            showDialog(
                context: context,
                builder: (context) {
                  return Dialog(
                    backgroundColor: Colors.transparent,
                    child: ListView(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      children: <Widget>[
                        Image(
                          image: doctor.profilePicture != '--'
                              ? NetworkImage(
                              '${imageLoc}doctorImages/${doctor.profilePicture}')
                              : ExactAssetImage('image/1.jpg'),
                          fit: BoxFit.cover,
                          width: MediaQuery.of(context).size.width / 2,
                          height: MediaQuery.of(context).size.width / 2,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            '${doctor.bio}',
                            style: TextStyle(color: Colors.white),
                          ),
                        )
                      ],
                    ),
                  );
                });
          },
        ),
      ),
    );
  }

  _onTapBtn(DoctorModel doctor) {
    setState(() {
      closeKeyboard = true;
    });
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return MyCustomDialog(
            title: Text(
              'Are you sure you want to add Dr. ${doctor.fName}',
              style:
              TextStyle(fontSize: MediaQuery.of(context).size.width / 20),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Yes'),
                onPressed: () async {
                  if(doctor.id == widget.docAdmin){
                    Navigator.pop(context);
                    key.currentState.showSnackBar(SnackBar(
                      backgroundColor: Colors.red,
                      content: Text('''He's the admin of the center'''),
                    ));
                  }else{
                    bool res = await CenterDoctorsAPI().addDoctorToCenter(
                        centerID: widget.centerID, doctorID: doctor.id);
                    Navigator.pop(context);
                    if (res) {
                      key.currentState.showSnackBar(SnackBar(
                        duration: Duration(milliseconds: 1000),
                        content: Text(
                            '''You added Dr.${doctor.fName} ${doctor.lName} successfully'''),
                      ));
                    } else {
                      key.currentState.showSnackBar(SnackBar(
                        duration: Duration(milliseconds: 1000),
                        backgroundColor: Colors.red,
                        content: Text('''He's already in the center '''),
                      ));
                    }
                  }
                },
              ),
              FlatButton(
                child: Text('No'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }

}
