import 'package:dro_patient_app/UI/Parts/ClinicCard.dart';
import 'package:dro_patient_app/UI/Parts/Loader.dart';
import 'package:flutter/material.dart';
import 'package:dro_patient_app/APIs/SearchAPI/SearchAPI.dart';


class SearchResultPage extends StatelessWidget {

  final String _patientID,_query;
  SearchResultPage(this._patientID,this._query);

  // API
  static SearchAPI _searchAPI = SearchAPI();

  @override
  Widget build(BuildContext context) {
    print(".... $_query");
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Result'),
      ),
      body: FutureBuilder(
        future: _searchAPI.getSearchResult(_query),
        builder: (context,ss){
          if(ss.hasError){
            print('Error');
          }
          if(ss.hasData){
            List res = ss.data;
            print(res);
            return res.length > 0 ? ListView.builder(
              itemCount: res.length,
                itemBuilder: (context,position){
                print(res[position]);
              return ClinicCard(_patientID,res[position]);
            }): Center(child: Text('No Results'),);
          }else{
            return Loader();
          }
        },
      ),
    );
  }
}
