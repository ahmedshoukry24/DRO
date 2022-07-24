import 'package:flutter/material.dart';
import '../../APIs/Reviews_Rating/ReviewsAPI.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';


class TotalRate extends StatefulWidget {

  final String _clinicID,_centerID;
  final double _size;

  TotalRate(this._clinicID,this._size,this._centerID);

  @override
  _TotalRateState createState() => _TotalRateState();
}

class _TotalRateState extends State<TotalRate> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: ReviewsAPI().getTotalRate(widget._clinicID,widget._centerID),
      builder: (context,ss){
        if(ss.hasError){
          print('Error');
        }
        if(ss.hasData){
          List rates = ss.data;
          if(rates.length != 0){
            double sum = 0;
            for(int i =0;i<rates.length;i++){
              sum += int.parse(rates[i]['rate']);
            }
            double res = sum/rates.length;
            return Center(
              child: SmoothStarRating(
                allowHalfRating: true,
                starCount: 5,
                rating: res,
                size: widget._size,
                filledIconData: Icons.star,
                halfFilledIconData: Icons.star_half,
                borderColor: Colors.amber,
                color: Colors.amber,
              ),
            );
          }else{
            return Center(
              child: SmoothStarRating(
                allowHalfRating: true,
                starCount: 5,
                rating: 0,
                size: widget._size,
                filledIconData: Icons.star,
                halfFilledIconData: Icons.star_half,
                borderColor: Colors.amber,
                color: Colors.amber,
              ),
            );
          }
        }else {
          return Center(
            child: SmoothStarRating(
              allowHalfRating: true,
              starCount: 5,
              rating: 0,
              size: widget._size,
              filledIconData: Icons.star,
              halfFilledIconData: Icons.star_half,
              borderColor: Colors.amber,
              color: Colors.amber,
            ),
          );
        }
      },
    );
  }
}
