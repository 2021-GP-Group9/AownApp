import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({Key? key}) : super(key: key);

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // body: GoogleMap(
      //   initialCameraPosition: CameraPosition(
      //       target: LatLng( 24.774265 , 46.738586
      //        )),
      //  // child: Text('Location Screen'),
      // ),
    );
  }
}