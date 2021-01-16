import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

Center kLoadingSpinner = Center(
  child: SpinKitCircle(
    color: Colors.greenAccent,
    size: 50.0,
  ),
);
Function kLoadingBuilder =
    (BuildContext context, Widget child, ImageChunkEvent loadingProgress) =>
        loadingProgress != null ? kLoadingSpinner : child;

Function imageNetworkErrorBuilder = (_, __, ___) => SizedBox.shrink();
