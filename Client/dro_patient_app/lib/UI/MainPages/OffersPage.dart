import 'package:dro_patient_app/APIs/URL/mainURL.dart';
import 'package:dro_patient_app/Model/OffersModel.dart';
import 'package:dro_patient_app/UI/Parts/Custom/MyCustomImage.dart';
import 'package:dro_patient_app/UI/Style/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class Offers extends StatelessWidget{

  final List<OffersModel> offers;
  Offers(this.offers);


  @override
  Widget build(BuildContext context){
    Style _style = Style();

    return Scaffold(
      appBar: AppBar(title: Text('Offers'),automaticallyImplyLeading: false,),
      body: ListView.builder(
        itemCount: offers.length,
        itemBuilder: (context,position){
          return Card(
            color: Colors.grey[200],
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('${offers[position].content}'),
                ),
                MyCustomImage(
                  image: "${imageLoc}Offers/${offers[position].figureName}",
                  height: _style.getWidthSize(context)*0.5,
                  width: _style.getWidthSize(context),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('${offers[position].centerAddress != '-1' ? offers[position].centerAddress : offers[position].clinicAddress}',
                    textAlign: TextAlign.center,),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}