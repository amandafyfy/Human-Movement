import 'package:flutter/material.dart';
import 'package:carp_background_location/carp_background_location.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Setting extends StatefulWidget {
  const Setting({Key? key, required this.curposition}) : super(key: key);
  final LocationDto curposition;


  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  late GoogleMapController mapController;

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    double lat = widget.curposition.latitude.toDouble();
    double long = widget.curposition.longitude.toDouble();
    final LatLng _center = new LatLng(lat, long);
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Map seeting'),
          backgroundColor: Colors.green[700],
        ),
        body: GoogleMap(
          zoomGesturesEnabled: true,
          onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(
            target: _center,
            zoom: 16.0,
          ),
        ),
      ),
    );
  }
}