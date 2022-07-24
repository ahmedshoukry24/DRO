import 'package:dro_patient_app/UI/Parts/Custom/MyCustomImage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_networkimage/zoomable.dart';

class ImageView extends StatelessWidget {
  final String image;
  final int tag;
  ImageView(this.image,this.tag);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Hero(
          tag: tag,
          child: ZoomableWidget(
              minScale: 1.0,
              maxScale: 2.0,
              resetDuration: Duration(milliseconds: 500),
              // default factor is 1.0, use 0.0 to disable boundary
              panLimit: 0.8,
              zoomSteps: 2,
              child: MyCustomImage(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                image: image,
              )
          )
      ),
    );
  }

}
