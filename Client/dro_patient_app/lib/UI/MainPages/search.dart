import 'package:dro_patient_app/UI/OtherPages/Search/SearchBytName.dart';
import 'package:dro_patient_app/UI/OtherPages/Search/SearchResultPage.dart';
import 'package:dro_patient_app/UI/Parts/Custom/MyPageRoute.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../Model/StaticLists.dart';

class SearchForDoctor extends StatefulWidget {

  final String _patientID;
  SearchForDoctor(this._patientID);

  @override
  _SearchForDoctorState createState() => _SearchForDoctorState();
}


enum RadioButtonValue { male, female }


class _SearchForDoctorState extends State<SearchForDoctor> {


  StaticLists _staticLists = StaticLists();

  // general
  Color _cardColor ;
  Color _containerColor;

  // fee Widget
  var selectedRange;

  // Gender Widget
  RadioButtonValue _character;

  // address Widget
  static List<String> _addresses;
  String _selectedAddress;

  // insurance widget
  static List<String> _insuranceList;
  String _selectedInsurance;

  // Category widget
  static List<String> _categoriesList;
  String _selectedCategory;

  // title widget
  static List<String> _titlesList;
  String _selectedTitle;





  initState(){
    super.initState();
    selectedRange= RangeValues(0.0,1000.0);
    _character= RadioButtonValue.male;
    _cardColor = Colors.white.withOpacity(0.9);
    _containerColor = Colors.grey[200];
    _addresses = _staticLists.getCities()..insert(0,"All");
    _selectedAddress = _addresses[0];
    _insuranceList =_staticLists.getInsuranceList()..insert(0,'All');
    _selectedInsurance = _insuranceList[0];
    _categoriesList = _staticLists.getCategoriesList()..insert(0,'All');
    _selectedCategory = _categoriesList[0];
    _titlesList = _staticLists.getTitles()..insert(0, 'All');
    _selectedTitle = _titlesList[0];

  }

  @override
  void dispose() {
    super.dispose();
  }

  String handlingQuery({ double startFee,double endFee, String selectedCategory,
    String selectedAddress,String selectedInsurance,String selectedTitle, RadioButtonValue selectedGender}){

    String address   = selectedAddress == "All" ? "IS NOT NULL" : "= '$selectedAddress'" ;
    String title = selectedTitle == "All" ? "IS NOT NULL" : "= '$selectedTitle'";
    String speciality = selectedCategory == "All" ? "IS NOT NULL" : "= '$selectedCategory'";
    String gender = selectedGender == RadioButtonValue.male ? "='Male'" : "='Female'";

    String insurance;
    String insuranceTable;
    String insuranceConstraint;

    if(selectedInsurance == "All"){
      insurance = '';
      insuranceTable ='';
      insuranceConstraint ='';
    }else{
      insurance = "AND insurance.INSUR_NAME = '$selectedInsurance'";
      insuranceTable = ',insurance';
      insuranceConstraint = 'AND insurance.CLINIC_ID = clinic.CLINIC_ID';
    }


    String theQuery = 'SELECT * FROM doctor,clinic$insuranceTable WHERE'
        ' doctor.DOCTOR_ID = clinic.DOCTOR_ID $insuranceConstraint'
        ' AND clinic.FEE >= $startFee AND clinic.FEE <= $endFee AND clinic.ADDRESS $address $insurance'
        ' AND doctor.TITLE $title AND doctor.SPECIALITY $speciality AND doctor.GENDER $gender';

    return theQuery;
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search for doctor'),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(icon: Icon(Icons.search),onPressed: (){
            MyPageRoute().fadeTransitionRouting(context, SearchByName(widget._patientID));
          },)
        ],
      ),
      body: ListView(
        children: [
          _category(),
          _address(),
          _insurance(),
          _feeRange(),
          _title(),
          _gender(),
          RaisedButton(
            child: Text('Search'),
            onPressed: (){
              String resQuery = handlingQuery(
                startFee: selectedRange.start,
                endFee: selectedRange.end,
                selectedCategory: _selectedCategory,
                selectedAddress: _selectedAddress,
                selectedInsurance: _selectedInsurance,
                selectedTitle: _selectedTitle,
                selectedGender: _character,
              );
              MyPageRoute().slideTransitionRouting(context, SearchResultPage(widget._patientID,resQuery));
            },
          )

        ],
      ),
    );
  }

  Widget _category(){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: _containerColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Category'),
              ),
              margin: EdgeInsets.zero,
              color: _cardColor,
            ),
            DropdownButton(
              isExpanded: true,
              onChanged: (value){
                setState(()=>_selectedCategory = value);
              },
              items: _categoriesList.map((item){
                return DropdownMenuItem(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(item),
                  ),
                  value: item,
                );
              }).toList(),
              value: _selectedCategory,
              underline: Container(),
            )
          ],
        ),
      ),
    );
  }
  Widget _address() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
            color: _containerColor,
            borderRadius: BorderRadius.circular(10)
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              color: _cardColor,
              margin: EdgeInsets.zero,
              child:Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('City'),
              ),
            ),
            DropdownButton<String>(
              isExpanded: true,
              underline: Container(),
              onChanged: (value){
                setState(() {
                  _selectedAddress = value;
                });
              },
              value: _selectedAddress,
              items: _addresses.map<DropdownMenuItem<String>>((e){
                return DropdownMenuItem<String>(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('$e'),
                  ),
                  value: e,
                );
              }).toList(),
            )
          ],
        ),
      ),
    );
  }
  Widget _insurance(){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: _containerColor
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              margin: EdgeInsets.zero,
              color: _cardColor,
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('Insurance'),
              ),
            ),
            DropdownButton(
              underline: Container(),
              isExpanded: true,
              value: _selectedInsurance,
              onChanged: (value){
                setState(() {
                  _selectedInsurance = value;
                });
              },
              items: _insuranceList.map((item){
                return DropdownMenuItem(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(item),
                  ),
                  value: item,
                );
              }).toList(),
            )
          ],
        ),
      ),
    );
  }
  Widget _feeRange() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
            color: _containerColor,
            borderRadius: BorderRadius.circular(10)
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              color: _cardColor,
              margin: EdgeInsets.zero,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: RichText(
                  text: TextSpan(
                      children: [
                        TextSpan(text: "fee: ",style: TextStyle(color: Colors.black)),
                        TextSpan(text: '${selectedRange.start.toInt()}',
                            style: TextStyle(color: Colors.blue[800]),
                            children: [
                              TextSpan(text: ' L.E',style: TextStyle(color: Colors.black,fontSize: 10))
                            ]),
                        TextSpan(text: ' - ',style: TextStyle(color: Colors.black)),
                        TextSpan(text: '${selectedRange.end.toInt()}',style: TextStyle(color: Colors.blue[800]),
                            children: [
                              TextSpan(text: ' L.E',style: TextStyle(color: Colors.black,fontSize: 10))
                            ]),
                      ]
                  ),
                ),
              ),
            ),
            RangeSlider(
              values: selectedRange,
              inactiveColor: Colors.white,
              onChanged: (RangeValues newRange){
                setState(() {
                  selectedRange = newRange;
                });
              },
              divisions: 20,
              labels: RangeLabels(
                  '${selectedRange.start}',
                  '${selectedRange.end}'
              ),
              max: 1000.0,
              min: 0.0,
              activeColor: Colors.blue[800],
            ),
          ],
        ),
      ),
    );

  }
  Widget _title(){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: _containerColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              margin: EdgeInsets.zero,
              color: _cardColor,
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('Title'),
              ),
            ),
            DropdownButton(
              isExpanded: true,
              underline: Container(),
              value: _selectedTitle,
              onChanged: (value){
                setState(() {
                  _selectedTitle = value;
                });
              },
              items: _titlesList.map((item){
                return DropdownMenuItem(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(item),
                  ),
                  value: item,
                );
              }).toList(),
            )
          ],
        ),
      ),
    );
  }
  Widget _gender() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: _containerColor,
          borderRadius: BorderRadius.circular(10)
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              margin: EdgeInsets.zero,
                color: _cardColor,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('Gender'),
                )
            ),
           Row(
             children: [
               Expanded(
                 child: RadioListTile(
                   value: RadioButtonValue.male,
                   groupValue: _character,
                   title: Text('Male'),
                   onChanged: (value){
                     setState(() {
                       _character = value;
                     });
                   },
                 )
               ),
             Expanded(
               child: RadioListTile(
                 groupValue: _character,
                 value: RadioButtonValue.female,
                 title: Text('Female'),
                 onChanged: (value){
                   setState(() {
                     _character = value;
                   });
                 },
               ),
             )
             ],
           )
          ],
        ),
      ),
    );
  }




}

