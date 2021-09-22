import 'package:flutter/material.dart';
import 'package:myapp/editLocation.dart';
import 'package:flutter_test/flutter_test.dart';

void main(){
  final item = [13.25, 25.25, 'new location', 'transport', 'act1', 'enjoy1', 'act2', 'enjoy2', 'act3', 'enjoy3', 'comment'];

  testWidgets('Widget test: page include all the text filed required', (WidgetTester tester) async {
    await tester.pumpWidget(
        MaterialApp(home: editLocation(item: item)));

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

  testWidgets('Widget test: All text fileds include text info from file', (WidgetTester tester) async {
    await tester.pumpWidget(
        MaterialApp(home: editLocation(item: item)));

    /** location widget for marker */
    expect(find.text('new location'), findsOneWidget);
    /** transport mode widget for marker */
    expect(find.text('transport'), findsOneWidget);
    /** activity  widget for marker */
    expect(find.text('act1'), findsOneWidget);
    /** enjoyment widget for marker */
    expect(find.text('enjoy1'), findsOneWidget);
    /** comment widget for marker */
    expect(find.text('comment'), findsOneWidget);
  });

  testWidgets('Widget test: Submit button exist', (WidgetTester tester) async {
    await tester.pumpWidget(
        MaterialApp(home: editLocation(item: item)));

    expect(find.byKey(ValueKey('confirm')), findsOneWidget);
  });


}