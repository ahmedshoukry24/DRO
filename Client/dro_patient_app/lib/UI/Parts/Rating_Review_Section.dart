import 'package:dro_patient_app/APIs/Reviews_Rating/TextAnalyzer.dart';
import 'package:dro_patient_app/APIs/URL/mainURL.dart';
import 'package:dro_patient_app/Model/Review.dart';
import 'package:dro_patient_app/UI/Parts/Custom/CustomDialog.dart';
import 'package:dro_patient_app/UI/Parts/Custom/MyCustomImage.dart';
import 'package:fleva_icons/fleva_icons.dart';
import 'package:flutter/material.dart';
import '../../APIs/Reviews_Rating/ReviewsAPI.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

import 'Loader.dart';

class RatingReview extends StatefulWidget {
  final String _patientID, _clinicID,_centerID;

  RatingReview(this._patientID, this._clinicID,this._centerID);

  @override
  _RatingReviewState createState() => _RatingReviewState();
}

class _RatingReviewState extends State<RatingReview> {
  TextEditingController _commentController = TextEditingController();
  double myRate = 0.0;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        FutureBuilder(
          future: ReviewsAPI().getReview(clinicID: widget._clinicID,centerID: widget._centerID),
          builder: (context, AsyncSnapshot ss) {
            if (ss.hasError) {
              print('Error');
            }
            if (ss.hasData) {
              List<ReviewModel> result = ss.data;
              List<ReviewModel> myReviews = [];
              result.forEach((i) {
                if (i.patientID == widget._patientID) {
                  myReviews.add(i);
                }
              });

              return Container(
                height: result.length == 0
                    ? 0
                    : MediaQuery.of(context).size.width / 2,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    myReviews.length != 0 && myReviews[0].rate == '0'
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Column(
                                children: <Widget>[
                                  Text(
                                    'RATE THE DOCTOR',
                                    style: TextStyle(
                                      color: Colors.blue[800],
                                      fontWeight: FontWeight.w600,
                                      fontSize: 20,
                                    ),
                                  ),
                                  SmoothStarRating(
                                    color: Colors.amber,
                                    borderColor: Colors.amber,
                                    starCount: 5,
                                    rating: myRate,
                                    defaultIconData: Icons.star_border,
                                    filledIconData: Icons.star,
                                    allowHalfRating: false,
                                    onRatingChanged: (value) async {
                                      if (value > 0) {
                                        myRate = value;
                                        await ReviewsAPI()
                                            .setRate(
                                                clinicID: widget._clinicID,
                                                patientID: widget._patientID,
                                                centerID: widget._centerID,
                                                rate: myRate.toInt())
                                            .whenComplete(
                                                () => setState(() {}));
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ],
                          )
                        : Container(),
                    Expanded(
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: result.length,
                          itemBuilder: (context, position) {
                            return _parentCard(result[position]);
                          }),
                    ),
                  ],
                ),
              );
            } else {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Loader(),
                  FlatButton(
                    child: Icon(Icons.refresh),
                    onPressed: () => setState(() {}),
                    color: Colors.blue[800].withOpacity(0.03),
                    shape: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(0.0),
                        borderSide: BorderSide.none),
                  )
                ],
              );
            }
          },
        ),
        _writeComment(clinicID: widget._clinicID, patientID: widget._patientID,centerID: widget._centerID),
      ],
    );
  }

  Widget _parentCard(ReviewModel reviewModel) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.8,
      child: Card(
        shape: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none),
        child: Column(
          children: <Widget>[
            // *** Header & Body
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  // ** Header (Name and picture)
                  Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(7),
                          child: MyCustomImage(
                            height: MediaQuery.of(context).size.width / 10,
                            width: MediaQuery.of(context).size.width / 10,
                            image:
                                "${imageLoc}patientImages/${reviewModel.profilePicture}",
                          ),
                        ),
                      ),
                      Text('${reviewModel.firstName} ${reviewModel.lastName}'),
                      Spacer(),
                      Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: reviewModel.status == '-1'
                              ? Icon(
                                  Icons.sentiment_dissatisfied,
                                  color: Colors.red[800],
                                )
                              : reviewModel.status == '1'
                                  ? Icon(
                                      Icons.sentiment_satisfied,
                                      color: Colors.blue[800],
                                    )
                                  : Icon(Icons.sentiment_neutral)),
                    ],
                  ),

                  // ** text body
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.blueGrey[50],
                            borderRadius: BorderRadius.circular(10)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                              width: MediaQuery.of(context).size.width / 1.5,
                              child: SingleChildScrollView(
                                child: Text('${reviewModel.review}'),
                              )),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // ** Stars
            _starsSection(double.parse(reviewModel.rate)),
          ],
        ),
      ),
    );
  }

  Widget _starsSection(double rate) {
    return Padding(
      padding: const EdgeInsets.only(top: 3),
      child: SmoothStarRating(
        allowHalfRating: false,
        starCount: 5,
        rating: rate,
        size: MediaQuery.of(context).size.width / 15,
        filledIconData: Icons.star,
        halfFilledIconData: Icons.star_half,
        borderColor: Colors.grey,
      ),
    );
  }

  Widget _writeComment({String patientID, String clinicID,String centerID}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        color: Colors.grey[300],
        shape: OutlineInputBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(0),
              topRight: Radius.circular(100),
              bottomRight: Radius.circular(100),
              bottomLeft: Radius.circular(40)),
          borderSide: BorderSide.none,
        ),
        child: Row(
          children: <Widget>[
            Expanded(
              child: TextField(
                controller: _commentController,
                decoration: InputDecoration(
                  hintText: 'comment',
                  isDense: true,
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            IconButton(
              icon: Icon(
                FlevaIcons.arrow_circle_right,
                color: Colors.white,
              ),
              onPressed: () async {
                showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (BuildContext context) {
                      return MyCustomDialog(
                        title: Loader(),
                        content: Text('Loading ...',textAlign: TextAlign.center,),
                      );
                    });
                await TextAnalyzer()
                    .getAnalyzedText(_commentController.text)
                    .then((value) async {
                  await ReviewsAPI()
                      .setReview(
                    patientID: patientID,
                    clinicId: clinicID,
                    centerID: centerID,
                    status: value['happy'] > value['sad']
                        ? '1'
                        : value['sad'] > value['happy'] ? '-1' : '0',
                    review: '''${_commentController.text}''',
                  ).then((value) {
                    if (value) {
                      setState(() {
                        _commentController.clear();
                        Navigator.pop(context);
                      });
                    }
                  });
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
