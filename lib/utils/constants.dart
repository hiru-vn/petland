import 'package:flutter/material.dart';

double deviceWidth(BuildContext context) => MediaQuery.of(context).size.width;
double deviceHeight(BuildContext context) => MediaQuery.of(context).size.height;

String loadingGif = 'https://firebasestorage.googleapis.com/v0/b/petland-39227.appspot.com/o/root%2Floading.gif?alt=media&token=e31c2128-918b-47e1-9801-ca40c5d6b75f';