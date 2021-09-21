import 'package:flutter/material.dart';

class DataPoint {
  double? date;
  double? longitude;
  double? latitude;
  double? speed;

  //constructor
  DataPoint(double date, double longitude, double latitude, double speed) {
    this.date = date;
    this.longitude = longitude;
    this.latitude = latitude;
    this.speed = speed;
  }

  @override
  String toString() {
    return 'DataPoint: {unixTime: $date, longitude: $longitude, latitude: $latitude,speed: $speed,}';
  }

}
