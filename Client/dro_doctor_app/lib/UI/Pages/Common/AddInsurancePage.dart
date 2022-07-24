import 'package:dro_doctor_app/APIs/InsuranceAPI/InsuranceAPI.dart';
import 'package:flutter/material.dart';

class InsurancePage extends StatefulWidget {
  final clinicId, centerID;
  InsurancePage(this.clinicId, this.centerID);

  @override
  _InsurancePageState createState() => _InsurancePageState();
}

class _InsurancePageState extends State<InsurancePage> {
  List<String> insurance = [
    'Aristocrat Insurance',
    'Caprock Insurance'
        'I-nsumed',
    'Grey Leaf Coverage',
    'Cope Health Solutions',
    'Medical ValuSurance',
    'LongSage Insurance',
    'Intriq Medical Insurance',
    'Solid Life Insurance',
    'Magnolia Management',
    'Aegis Insurance',
    'Rock stone Security',
    'Gain Security and Trust',
    'Elder Assurance',
    'Evolve Insurance',
    'Medieval Insurance',
    'EnsureMania',
    'Time of your Life Insurance',
  ];

  List<String> showList = [];
  var key = GlobalKey<ScaffoldState>();

  TextEditingController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = TextEditingController();
    showList = insurance;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: key,
      appBar: AppBar(
        title: Text('Insurance'),
        automaticallyImplyLeading: false,
      ),
      body: ListView(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.1,
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                        fillColor: Colors.grey[100],
                        filled: true,
                        contentPadding: EdgeInsets.all(10),
                        isDense: true,
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(30),
                        )),
                    onChanged: (value) {
                      value = value.toLowerCase();
                      setState(() {
                        showList = insurance.where((element) {
                          String x = element.toLowerCase();
                          return x.startsWith(value);
                        }).toList();
                      });

                    },
                  ),
                ),
                Icon(Icons.search)
              ],
            ),
          ),
          Divider(
            indent: MediaQuery.of(context).size.width / 4,
            endIndent: MediaQuery.of(context).size.width / 4,
            height: 0,
            color: Colors.grey[700],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height* 0.8,
            child: NotificationListener<OverscrollIndicatorNotification>(
              // ignore: missing_return
              onNotification: (OverscrollIndicatorNotification onOverScroll){
                onOverScroll.disallowGlow();
              },
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: showList.length,
                  itemBuilder: (context, position) {
                    return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                          title: Text(
                            '${showList[position]}',
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                          onTap: () async {
                            bool res = await InsuranceAPI().setInsurance(
                                centerID: widget.centerID,
                                clinicID: widget.clinicId,
                                insurance: showList[position]);
                            if (res) {
                              key.currentState.showSnackBar(SnackBar(
                                backgroundColor: Colors.blue[800],
                                content: Text('Insurance added'),
                              ));
                            } else {
                              key.currentState.showSnackBar(SnackBar(
                                backgroundColor: Colors.red,
                                content: Text('Already selected'),
                              ));
                            }
                          },
                        ));
                  }),
            ),
          ),
        ],
      ),
    );
  }
}
