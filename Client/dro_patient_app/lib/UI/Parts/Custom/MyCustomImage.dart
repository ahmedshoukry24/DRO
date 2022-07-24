import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';

class MyCustomImage extends StatelessWidget {
  final String image;
  final double width,height;

  MyCustomImage({@required this.image,@required this.width,@required this.height});
  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: "$image",
      placeholder: (context, url) => SpinKitRipple(color: Colors.blue[800]),
      errorWidget: (context, url, error) => Icon(Icons.image),
      fit: BoxFit.cover,
      height: height,
      width: width,
    );
  }
}

