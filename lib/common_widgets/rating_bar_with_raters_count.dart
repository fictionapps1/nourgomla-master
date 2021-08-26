import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';


class RatingBarWithRatersCount extends StatelessWidget {
  final String rate;
  final int raters;
  final double vPadding;
  final bool isColumn;

  RatingBarWithRatersCount({
    @required this.rate,
    @required this.raters,
    this.vPadding, this.isColumn=false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: vPadding ?? 0),
      child: isColumn?Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          RatingBarIndicator(
            rating: double.parse(rate),
            itemBuilder: (context, index) => Icon(
              Icons.star,
              color: Colors.amber,
            ),
            itemCount: 5,
            itemSize: 17.0,
          ),
          SizedBox(height: 5),
          Text('( $raters )'),
        ],
      ):Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          RatingBarIndicator(
            rating: double.parse(rate),
            itemBuilder: (context, index) => Icon(
              Icons.star,
              color: Colors.amber,
            ),
            itemCount: 5,
            itemSize: 17.0,
          ),
          SizedBox(width: 10),
          Text('( $raters )'),
        ],
      ),
    );
  }
}
