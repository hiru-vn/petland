import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';

import 'package:petland/utils/constants.dart';

showGoogleMap(BuildContext context, {double height}) {
  if (height == null) height = deviceHeight(context) - kToolbarHeight;
  showDialog(
      context: context,
      useRootNavigator: true,
      builder: (context) {
        return SizedBox(
            width: deviceWidth(context),
            height: height,
            child: GoogleMapWidget());
      });
}

class GoogleMapWidget extends StatefulWidget {
  @override
  _GoogleMapWidgetState createState() => _GoogleMapWidgetState();
}

class _GoogleMapWidgetState extends State<GoogleMapWidget> {
  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  static final CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
        fit: StackFit.expand,
        children: [
          GoogleMap(
            mapType: MapType.normal,
            initialCameraPosition: _kGooglePlex,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
          ),
          Positioned(
            top: 20,
            right: 12,
            child: InkWell(
              onTap: () => Navigator.of(context).maybePop(),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.black38,
                    borderRadius: BorderRadius.circular(20)),
                width: 40,
                height: 40,
                child: Icon(
                  Icons.close,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
