import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';//Import intl in the file this is being done
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';


class UserInfo extends StatefulWidget {
  const UserInfo({Key? key}) : super(key: key);

  @override
  _UserInfoState createState() => _UserInfoState();
}


class _UserInfoState extends State<UserInfo> {

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  
  String? name;
  String? garminId;
  String? stravaId;
  String? gender;
  // String? dob;
  String? numOfvehicle;
  String? vehicleType;
  
  void _formSubmitted() {
    // get the current state of the form
    var _form = _formKey.currentState;
    if (_form!.validate()) {
      _form.save();
    }

  }
  
  void _generateUserProfile() async{
    Map<String, dynamic> _userInfo = {'UserName': name, 'GarminId': garminId, 
    'StravaId': stravaId, 'Gender': gender,  'NumberOfVehicle': numOfvehicle, 'VehicleType': vehicleType};
    final directory = await getApplicationDocumentsDirectory();
    final path = directory.path;
    File file = File('$path/${garminId}userProfile.json');
    // write user info into a json file
    file.writeAsString(jsonEncode(_userInfo));
    // set file path on firebase storage
    final destination = '$garminId/${garminId}userProfile.json';
    Reference storageReference = FirebaseStorage.instance.ref().child("$destination");
    // upload file to firebase
    final UploadTask uploadTask = storageReference.putFile(file);
  }
  // store GarminId to shared_preference
  void _setGarminId(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("GarminId", value);    
    // String gId = (prefs.getString('GarminId') ?? "");
    // print("get ${gId}");

  }
  
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('User Information'),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'Enter your Name',
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  onSaved: (v) {
                    name = v;
                  }
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'Garmin Account ID',
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  onSaved: (v) {
                    garminId = v;
                  }
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'Strava Account ID',
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  onSaved: (v) {
                    stravaId = v;
                  }
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'Gender',
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  onSaved: (v){
                    gender = v;
                  }

                ),
                /*
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'Date of Birth',
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  onSaved: (v){
                    dob = v;
                  }
                ), */
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'Number of Vehicle Owned',
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  onSaved: (v){
                    numOfvehicle = v;
                  }
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'Vehicle Type',
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  onSaved: (v){
                    vehicleType = v;
                  }
                ),
                
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: ElevatedButton(
                    onPressed: () {
                      // Validate will return true if the form is valid, or false if
                      // the form is invalid.
                      _formSubmitted();
                      _setGarminId(garminId!);
                      _generateUserProfile();

                      Navigator.pop(context);
                    },
                    child: const Text('Save'),
                  ),
                ),
              ],
            ),
          ),
      ),
    );
  }
}

