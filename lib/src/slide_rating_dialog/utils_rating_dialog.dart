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

String getMessage(int a) {
  switch (a) {
    case 1:
      return 'Worst';
    case 2:
      return 'Not good';
    case 3:
      return 'Good';
    case 4:
      return 'Excellent';
    case 5:
      return 'Outstanding';
  }
  return 'Outstanding';
}
