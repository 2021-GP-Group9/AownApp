import 'package:aownapp/bookAppointment/book_appointment_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:aownapp/constant.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationScreen extends StatefulWidget {

  final String appointmentId;
  final String donorId;
  const LocationScreen({Key? key,required this.appointmentId,required this.donorId}) : super(key: key);

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  GoogleMapController? _controller;
  Set<Marker> _markers=Set<Marker>();
  LatLng? latLng;
  @override
  void initState() {

    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: Get.height*0.9,
            child: GoogleMap(
              markers: _markers,
              initialCameraPosition: CameraPosition(
                  target: LatLng( 24.774265 , 46.738586
                  )),
              onMapCreated: (GoogleMapController controller) {
                _controller=controller;
              },
              onTap: _handleTap,
              // child: Text('Location Screen'),
            ),
          ),
          SizedBox(
            height: Get.height*0.1,
            width: Get.width,

            child: ElevatedButton(
              onPressed: ()async{
                if(latLng!=null){
                  //  List<Placemark> placemarks = await placemarkFromCoordinates(latLng?.latitude ?? 0.0, latLng?.longitude ?? 0.0);
                  // Placemark first=placemarks[0];
                  //print('${first.locality}, ${first.subLocality},${first.thoroughfare}, ${first.subThoroughfare}');
                  final response=await http.post(Uri.parse(constant.bookAppointmentUrl),body: {
                    'appointmentId':widget.appointmentId,
                    'donorId':widget.donorId,
                    'Latitude':latLng!.latitude.toString(),
                    'Longitude':latLng!.longitude.toString(),

                  });
                  Get.snackbar('تنبيه', 'تم حجز الموعد بنجاح');
                  Navigator.pop(context);
                  // Navigator.pop(context);
                }

              },
              child: Text('حجز موعد'),
            ),
          ),
        ],
      ),
    );
  }
  _handleTap(LatLng point) {
    setState(() {
      _markers.clear();
      latLng=point;
      _markers.add(Marker(
        markerId: MarkerId(point.toString()),
        position: point,
        infoWindow: InfoWindow(
          title: 'I am a marker',
        ),
        icon:
        BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueMagenta),
      ));
    });
  }
}