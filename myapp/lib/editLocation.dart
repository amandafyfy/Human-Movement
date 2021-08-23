import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:csv/csv.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'dart:convert';
import './Setting.dart';
import './main.dart';

class editLocation extends StatefulWidget {
  final List<dynamic> item;
  const editLocation({Key? key, required this.item}) : super(key: key);

  @override
  _editLocationState createState() => _editLocationState();
}

class _editLocationState extends State<editLocation> {
  TextEditingController _locationnameController = new TextEditingController();
  TextEditingController _Activity1Controller = new TextEditingController();
  TextEditingController _Activity2Controller = new TextEditingController();
  TextEditingController _Activity3Controller = new TextEditingController();
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();


  void editvalue(String key, double long, double lat, String locationName, String Activ1, String Activ2, String Activ3) async{

    String csv = "";
    final directory = await getApplicationDocumentsDirectory();
    final path = directory.path+"/locations.csv";
    print("path:" + path);
    File file = File(path);

    final input = new File(path).openRead();
    final fields = await input.transform(utf8.decoder).transform(new CsvToListConverter()).toList();
    print(fields);

    for(int i =2; i<fields.length; i++) {
      List<dynamic> element = [];
      element = fields[i];
      if (element[2] == key) {
        element[0]=long;
        element[1]=lat;
        element[2]=locationName;
        element[3]=Activ1;
        element[4]=Activ2;
        element[5]=Activ3;
      }
    }

    await file.delete();
    csv = const ListToCsvConverter().convert(fields);
    await file.writeAsString(csv);
    //await file.delete();
    print(fields);
  }

  @override
  Widget build(BuildContext context) {
    location thislocation = new location(0.0,0.0);
    thislocation.longitude = widget.item[0];
    thislocation.latitude = widget.item[1];
    _locationnameController = TextEditingController(text: widget.item[2]);
    _Activity1Controller = TextEditingController(text: widget.item[3]);
    _Activity2Controller = TextEditingController(text: widget.item[4]);
    _Activity3Controller = TextEditingController(text: widget.item[5]);

    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Marker'),
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
                        editvalue(widget.item[2], widget.item[0], widget.item[1], _locationnameController.text, _Activity1Controller.text, _Activity2Controller.text, _Activity3Controller.text);
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Setting(thislocation: thislocation)),
                        );
                      }
                    },
                    child: const Text('Edit Marker'),
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