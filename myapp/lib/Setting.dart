import 'package:flutter/material.dart';
import 'package:carp_background_location/carp_background_location.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import './MarkerForm.dart';

class Setting extends StatefulWidget {
  const Setting({Key? key, required this.curposition}) : super(key: key);
  final LocationDto curposition;

  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  late GoogleMapController mapController;
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

Future _addMarkerLongPressed(LatLng latlang) async {
  setState(() {
    final MarkerId markerId = MarkerId("RANDOM_ID");
    Marker marker = Marker(
      markerId: markerId,
      draggable: true,
      position: latlang, //With this parameter you automatically obtain latitude and longitude
      infoWindow: InfoWindow(
        title: "Marker here",
        snippet: 'This looks good',
      ),
      icon: BitmapDescriptor.defaultMarker,
    );
    markers[markerId] = marker;
  });
  }

  @override
  Widget build(BuildContext context) {
    print(widget.curposition.latitude);
    print(widget.curposition.longitude);
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
          initialCameraPosition: CameraPosition(
            target: _center,
            zoom: 16.0,
          ),
          onMapCreated: _onMapCreated,
          compassEnabled: true,
          tiltGesturesEnabled: false,
          onLongPress: (latlang) {
            _addMarkerLongPressed(latlang); //we will call this function when pressed on the map
            Navigator.push(
            context, MaterialPageRoute(
            builder: (context) => MarkerForm(latlang: latlang)));
            },
            markers: Set<Marker>.of(markers.values), //all markers are here
        ),
      ),
    );
  }
}