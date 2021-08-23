import 'package:flutter/material.dart';
import 'package:intl/intl.dart';//Import intl in the file this is being done
import 'package:path_provider/path_provider.dart';
import 'dart:io';


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
  String? dob;
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
    
    final directory = await getApplicationDocumentsDirectory();
    final path = directory.path;
    File file = File('$path/userProfile.csv');
    file.writeAsString('Hello Folks');
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
                ),
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
                      _generateUserProfile();

                      if (_formKey.currentState!.validate()) {
                        // Process data.
                      }
                    },
                    child: const Text('Submit'),
                  ),
                ),
              ],
            ),
          ),
      ),
    );
  }
}

