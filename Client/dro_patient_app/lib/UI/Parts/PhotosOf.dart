import 'package:dro_patient_app/APIs/URL/mainURL.dart';
import 'package:dro_patient_app/APIs/common/PhotosOfAPI.dart';
import 'package:dro_patient_app/UI/Style/style.dart';
import 'package:flutter/material.dart';
import 'Custom/MyCustomImage.dart';
import 'Loader.dart';

class PhotosOf extends StatelessWidget {

  final String clinicID,centerID;

  const PhotosOf({this.clinicID, this.centerID});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: PhotosOfAPI().getClinicPhotos(centerID: centerID,clinicID:clinicID),
      builder: (BuildContext context, AsyncSnapshot ss){
        if(ss.hasError){
          print('Error');
        }
        if(ss.hasData){
          List photos = ss.data;
          return GridView.builder(
            itemCount: photos.length,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 1,
                crossAxisSpacing: 4.0,
                mainAxisSpacing: 4.0
            ),
            itemBuilder: (context,position){
              return ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: MyCustomImage(
                  image: "${imageLoc}PhotosOf/${photos[position]['PHOTO_NAME']}",
                  height: Style().getWidthSize(context)*0.2,
                  width: Style().getWidthSize(context)*0.2,
                ),
              );
            },);
        }else{
          return Loader();
        }
      },
    );
  }
}
