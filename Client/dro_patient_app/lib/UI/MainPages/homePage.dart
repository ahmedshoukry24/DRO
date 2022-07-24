import 'package:dro_patient_app/APIs/OffersAPI.dart';
import 'package:dro_patient_app/APIs/URL/mainURL.dart';
import 'package:dro_patient_app/Model/OffersModel.dart';
import 'package:dro_patient_app/UI/MainPages/OffersPage.dart';
import 'package:dro_patient_app/UI/Parts/Custom/MyCustomImage.dart';
import 'package:dro_patient_app/UI/Parts/Custom/MyPageRoute.dart';
import 'package:dro_patient_app/UI/Style/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';
import '../../Model/StaticLists.dart';
import '../OtherPages/CatDetails/CategoriesDetailsPage.dart';
import '../Parts/Loader.dart';
import '../../APIs/ClinicsAPI.dart';
import '../../UI/Parts/ClinicCard.dart';

class HomePage extends StatefulWidget {
  final String _patientID;
  HomePage(this._patientID);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ClinicsAPI getClinicsAPI;
  Style _style;

  List<String> catName = StaticLists().getCategoriesList();

  @override
  void initState() {
    super.initState();
    getClinicsAPI = ClinicsAPI();
    _style = Style();
    if(catName.first == 'General'){
      catName.removeAt(0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Row(
            children: <Widget>[
              Icon(Icons.home),
              SizedBox(width: 10,),
              Text('Home'),
            ],
          ),
        ),
        body: ListView(
          children: <Widget>[

            _header(),
            Padding(
              padding: EdgeInsets.all(_style.getWidthSize(context)*0.03),
              child: Text('Categories',style: TextStyle(fontSize: _style.getWidthSize(context)*0.05,
                  fontWeight: FontWeight.bold,color: _style.getMainColor()),),
            ),
            _categories(),
//            _topClinicsArea(),
          ],
        ));
  }

  Widget _header() {
    return SizedBox(
      height: _style.getWidthSize(context)*0.6,
      child: FutureBuilder(
        future: OffersAPI().getOffers(),
        builder: (context, AsyncSnapshot ss){
          if(ss.hasError){
            print('Error');
          }
          if(ss.hasData){
            List<OffersModel> offers = ss.data;
            List<Stack> images = [];
            offers.forEach((element) {
              images.add(Stack(
                fit: StackFit.expand,
                children: [
                  MyCustomImage(image: "${imageLoc}Offers/${element.figureName}",),
                  Align(
                    alignment:Alignment.centerLeft,
                      child: SizedBox(
                        width: _style.getWidthSize(context)*0.4,
                          child: Card(
                            color: Colors.grey.withOpacity(0.2),
                              child: Text('${element.content}',
                                style: TextStyle(color: Colors.white),))))
                ],
              ));
            });

            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: _style.getWidthSize(context)*0.1,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: _style.getWidthSize(context)*0.03),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Offers',style: TextStyle(fontSize: _style.getWidthSize(context)*0.05,
                            fontWeight: FontWeight.bold,color: _style.getMainColor()),),
                        GestureDetector(onTap:(){
                          MyPageRoute().slideTransitionRouting(context, Offers(offers));
                        },child: Text('All',style: TextStyle(fontSize: _style.getWidthSize(context)*0.03,color: _style.getSubTextColor()),))
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: _style.getWidthSize(context)*0.5,
                  child: Carousel(
                    boxFit: BoxFit.cover,
                    autoplay: true,
                    images: images,
                    showIndicator: true,
                    indicatorBgPadding: 5.0,
                    dotSize: 5,
                    dotColor: Colors.blue[800],
                    dotIncreasedColor: Colors.amber,
                    dotBgColor: Colors.transparent,
                  ),
                ),
              ],
            );
          }else{
            return Container();
          }

        },
      ),
    );
  }
  Widget _categories() {
    return SizedBox(
      height: MediaQuery.of(context).size.width*0.6,
      child: GridView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: catName.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 4,
          crossAxisSpacing: 4,
          childAspectRatio: 1
        ),
        itemBuilder: (context,position){
          return  GestureDetector(
            onTap: ()=>MyPageRoute().fadeTransitionRouting(context, CatDetailsPage(widget._patientID,catName[position])),
            child: SizedBox(
              width: _style.getWidthSize(context)*0.5,
              child: Card(
                color: Colors.blue[700],
                margin: EdgeInsets.zero,
                shape: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(15),
                    topLeft: Radius.circular(3),
                  ),
              ),
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: _style.getWidthSize(context)*0.01),
                    child: Text('${catName[position]}',
                      style: TextStyle(color: Colors.white,
                          fontSize: _style.getWidthSize(context)*0.04,
                          fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
  Widget _topClinicsArea() {
    return FutureBuilder(
      // **** get all data from clinic table and doctor table
      future: getClinicsAPI.getClinics('0'),
      builder: (BuildContext context, AsyncSnapshot ss) {
        if (ss.hasError) {
          print('Error');
        }
        if (ss.hasData) {
          List clinics = ss.data;
          return ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: clinics.length,
            itemBuilder: (context, position) {
              return ClinicCard(
                // clinic by clinic with its doctor ==>> MAP
                // data from clinic and doctor tables
                widget._patientID,
                clinics[position],
              );
            },
          );
        } else {
          return Material(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Loader(),
                SizedBox(height: 10,),
                Text('loading...')
              ],
            ),
          );
        }
      },
    );
  }


}
