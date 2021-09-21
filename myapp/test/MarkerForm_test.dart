import 'package:flutter/material.dart';
import 'package:myapp/MarkerForm.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main(){

  /**Test all the text form fields are presented */
  testWidgets('Marker form', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: const MarkerForm(latlang: LatLng(12.25, 13.55))));

    //expect(find.text('Add Marker'), findsOneWidget);
    /** location widget for marker */
    expect(find.byKey(ValueKey('location_input')), findsOneWidget);
    /** transport mode widget for marker */
    expect(find.byKey(ValueKey('transport_input')), findsOneWidget);
    /** transport mode widget for marker */
    expect(find.byKey(ValueKey('Activity_one')), findsOneWidget);
    /** transport mode widget for marker */
    expect(find.byKey(ValueKey('Enjoy_one')), findsOneWidget);
    /** transport mode widget for marker */
    expect(find.byKey(ValueKey('comment')), findsOneWidget);
  });

  /** Test if text form field allow user input*/
  testWidgets('Marker form', (WidgetTester tester) async {
    await tester.pumpWidget(
        MaterialApp(home: const MarkerForm(latlang: LatLng(12.25, 13.55))));

    var textField = find.byKey(ValueKey('location_input'));

    /** Enter 'hi' into the TextField.*/
    await tester.enterText(textField, 'hi');
    /** Rebuild the widget with the new item.*/
    await tester.pump();
    /** Expect to find the item on screen.*/
    expect(find.text('hi'), findsOneWidget);
  });

  /** Test submit button exist */
  testWidgets('Marker form', (WidgetTester tester) async {
    await tester.pumpWidget(
        MaterialApp(home: const MarkerForm(latlang: LatLng(12.25, 13.55))));

    expect(find.byKey(ValueKey('submit')), findsOneWidget);
  });

    /** add header test function*/
  test('add headers to csv ', () {
    List<dynamic> row = ["longitude","latitude","locationName", "transport", "Activity 1", "Enjoyment1", "Activity 2", "Enjoyment2", "Activity 3", "Enjoyment3", "Comment"];
    List<List<dynamic>> rows = [];
    new MarkerForm(latlang: new LatLng(12.25, 13.55)).createState().add_head(rows);
    expect(row, rows.first);
  });


}