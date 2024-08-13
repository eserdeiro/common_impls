import 'package:flutter/cupertino.dart';

double getWidth(BuildContext context, int a) {
  switch (a) {
    case 1:
      return MediaQuery.of(context).size.width * 0.14;
    case 2:
      return MediaQuery.of(context).size.width * 0.3;
    case 3:
      return MediaQuery.of(context).size.width * 0.46;
    case 4:
      return MediaQuery.of(context).size.width * 0.62;
    case 5:
      return MediaQuery.of(context).size.width * 0.8;
  }
  return 70;
}

String getMessage(int a,
    {String? oneStar,
    String? twoStar,
    String? threeStar,
    String? fourStar,
    String? fiveStar}) {
  switch (a) {
    case 1:
      return oneStar ?? 'Worst';
    case 2:
      return twoStar ?? 'Not good';
    case 3:
      return threeStar ?? 'Good';
    case 4:
      return fourStar ?? 'Excellent';
    case 5:
      return fiveStar ?? 'Outstanding';
    default:
      return fiveStar ?? 'Outstanding';
  }
}
