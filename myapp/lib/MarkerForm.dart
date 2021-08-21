import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:csv/csv.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'dart:convert';

class MarkerForm extends StatefulWidget {

  const MarkerForm({Key? key, required this.latlang}) : super(key: key);
  final LatLng latlang;

  @override
  _MarkerFormState createState() => _MarkerFormState();
}

class _MarkerFormState extends State<MarkerForm> {
  TextEditingController _locationnameController = new TextEditingController();
  TextEditingController _Activity1Controller = new TextEditingController();
  TextEditingController _Activity2Controller = new TextEditingController();
  TextEditingController _Activity3Controller = new TextEditingController();
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  void add_head(List<List<dynamic>> rows){
    List<dynamic> row = [];
    row.add("longitude");
    row.add("latitude");
    row.add("locationName");
    row.add("Activity 1");
    row.add("Activity 2");
    row.add("Activity 3");
    rows.add(row);
  }

  void add_context(List<List<dynamic>> rows, LatLng latlang, String locationName, String Activ1, String Activ2, String Activ3){
    List<dynamic> row = [];
    List<dynamic> empty = [];
    rows.add(empty);

    row.add(latlang.longitude);
    row.add(latlang.latitude);
    row.add(locationName);
    row.add(Activ1);
    row.add(Activ2);
    row.add(Activ3);
    rows.add(row);
  }

  void _recordvalue(LatLng latlang, String locationName, String Activ1, String Activ2, String Activ3) async{
    List<List<dynamic>> rows = [];

    String csv = "";
    final directory = await getApplicationDocumentsDirectory();
    final path = directory.path+"/locations.csv";
    print("path:" + path);

    File file = File(path);
    if(await file.exists()){
      add_context(rows, latlang, locationName, Activ1, Activ2, Activ3);
      csv = const ListToCsvConverter().convert(rows);
      await file.writeAsString(csv, mode: FileMode.append);
    }else{
      add_head(rows);
      add_context(rows, latlang, locationName, Activ1, Activ2, Activ3);
      csv = const ListToCsvConverter().convert(rows);
      await file.writeAsString(csv);
    }

    final input = new File(path).openRead();
    final fields = await input.transform(utf8.decoder).transform(new CsvToListConverter()).toList();
    print(fields);

    await file.delete();
  }

  @override
  Widget build(BuildContext context) {
    LatLng latlang = new LatLng(widget.latlang.latitude.toDouble(), widget.latlang.longitude.toDouble());
    print(latlang.longitude);
    print(latlang.latitude);
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Marker'),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                controller: _locationnameController,
                autofocus: true,
                autocorrect: true,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Name this location',
                  prefixIcon: Icon(Icons.person),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter location name';
                  }
                  return null;
                },
              ),

              TextFormField(
                controller: _Activity1Controller,
                autofocus: true,
                autocorrect: true,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Enter activity you perform in this place',
                  prefixIcon: Icon(Icons.person),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Must fill at least one activity';
                  }
                  return null;
                },
              ),

              TextFormField(
                controller: _Activity2Controller,
                autofocus: true,
                autocorrect: true,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Enter activity you perform in this place',
                  prefixIcon: Icon(Icons.person),
                ),
              ),

              TextFormField(
                controller: _Activity3Controller,
                autofocus: true,
                autocorrect: true,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Enter activity you perform in this place?',
                  prefixIcon: Icon(Icons.person),
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(top: 25),
                child: ConstrainedBox(
                  constraints: BoxConstraints.expand(height: 55.0),
                  child: ElevatedButton(
                    //style: style,
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _recordvalue(latlang, _locationnameController.text, _Activity1Controller.text, _Activity2Controller.text, _Activity3Controller.text);
                        Navigator.of(context).pop();
                      }
                    },
                    child: const Text('Add Marker'),
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}