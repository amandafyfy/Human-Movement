import 'package:flutter/material.dart';
import 'package:carp_background_location/carp_background_location.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import './MarkerForm.dart';
import './main.dart';
import 'package:csv/csv.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'dart:convert';

class Setting extends StatefulWidget {
  const Setting({Key? key, required this.thislocation}) : super(key: key);
  final location thislocation;

  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  late GoogleMapController mapController;
  //Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  Set<Marker> markers = new Set();
  int _markerIdCounter = 1;

  final List<List<dynamic>> fields = [];

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  void _readfile() async{
    markers = new Set();
    final directory = await getApplicationDocumentsDirectory();
    final path = directory.path+"/locations.csv";
    print("path:" + path);

    final input = new File(path).openRead();
    final fields = await input.transform(utf8.decoder).transform(new CsvToListConverter()).toList();
    //print(fields);

    for(int i =2; i<fields.length; i++){
      List<dynamic> element = [];
      element = fields[i];
      if(element.isNotEmpty) {
        print("new line:" + element.toString());
        print(element[0]);
        print(element[1]);
        //LatLng position = new LatLng(element[0], element[1]);
        setState(() {
          markers.add(Marker( //add first marker
            markerId: MarkerId(element[2].toString()),
            position: LatLng(element[1], element[0]), //position of marker
            infoWindow: InfoWindow( //popup info
              title: element[2],
              snippet: element[3],
            ),
            icon: BitmapDescriptor.defaultMarker, //Icon for Marker
          ));
        });

        print("finish add markers");
      }
    }
  }

  @override
  void initState() {
    _readfile();
  }


  /*Future _addMarkerLongPressed(LatLng latlang) async {
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
  }*/

  @override
  Widget build(BuildContext context) {
    print(widget.thislocation.latitude);
    print(widget.thislocation.longitude);
    double lat = widget.thislocation.latitude;
    double long = widget.thislocation.longitude;
    //_readfile();
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
            //_addMarkerLongPressed(latlang); //we will call this function when pressed on the map
            Navigator.push(
            context, MaterialPageRoute(
              builder: (context) => MarkerForm(latlang: latlang)));
            },
          markers:markers.toSet(), //all markers are here
        ),

          floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MyHomePage(title: "Home")),
            );
          },
            label: Text('Finish setting'),
            icon: const Icon(Icons.refresh),
            backgroundColor: Colors.green,
            ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,

      ),

    );
  }
}