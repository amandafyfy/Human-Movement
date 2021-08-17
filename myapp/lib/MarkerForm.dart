import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import './Setting.dart';

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