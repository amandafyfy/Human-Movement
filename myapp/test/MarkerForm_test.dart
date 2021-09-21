import 'package:flutter/material.dart';
import 'package:myapp/MarkerForm.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main(){




  /** setUserState test function*/
  test('add headers to csv ', () {
    List<dynamic> row = ["longitude","latitude","locationName", "Activity 1", "Enjoyment1", "Activity 2", "Enjoyment2", "Activity 3", "Enjoyment3", "Comment"];
    List<List<dynamic>> rows = [];
    new MarkerForm(latlang: new LatLng(12.25, 13.55)).createState().add_head(rows);
    expect(row, rows.first);
  });
}