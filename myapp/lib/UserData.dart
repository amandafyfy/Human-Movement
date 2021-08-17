import 'package:flutter/material.dart';

class DataPoint {
  String? date;
  double? longitude;
  double? latitude;
  double? speed;

  //constructor
  DataPoint(String date, double longitude, double latitude, double speed) {
    this.date = date;
    this.longitude = longitude;
    this.latitude = latitude;
    this.speed = speed;
  }

  @override
  String toString() {
    return 'DataPoint: {date: $date, longitude: $longitude, latitude: $latitude,speed: $speed,}';
  }
}