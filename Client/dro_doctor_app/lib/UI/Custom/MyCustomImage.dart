import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';

class MyCustomImage extends StatelessWidget {
  final String image,secImg;
  final double width,height;

  MyCustomImage({this.image, this.width,this.height,this.secImg});
  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: "$image",
      placeholder: (context, url) => SpinKitRipple(color: Colors.blue[800]),
      errorWidget: (context, url, error) =>secImg==null? Icon(Icons.broken_image) : Icon(Icons.image,size: MediaQuery.of(context).size.width*0.3,),
      fit: BoxFit.cover,
      // **  width & height
      height: height,
      width: width,
    );
  }
}
