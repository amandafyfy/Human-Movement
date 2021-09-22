import 'package:flutter/material.dart';
import 'package:myapp/UserInfo.dart';
import 'package:flutter_test/flutter_test.dart';

void main(){


  testWidgets('Widget test: page include all the text filed required', (WidgetTester tester) async {
    await tester.pumpWidget(
        MaterialApp(home: UserInfo()));

    /**  find widget for user name */
    expect(find.byKey(ValueKey('name')), findsOneWidget);
    /**  find widget for Garmin */
    expect(find.byKey(ValueKey('Garmin')), findsOneWidget);
    /**  find widget for Strava */
    expect(find.byKey(ValueKey('Strava')), findsOneWidget);
    /**  find widget for Gender */
    expect(find.byKey(ValueKey('Gender')), findsOneWidget);
    /**  find widget for Vehicle */
    expect(find.byKey(ValueKey('Vehicle')), findsOneWidget);
    /**  find widget for vehicle type */
    expect(find.byKey(ValueKey('type')), findsOneWidget);
  });


  testWidgets('Widget test: Submit button exist', (WidgetTester tester) async {
    await tester.pumpWidget(
        MaterialApp(home: UserInfo()));

    expect(find.byKey(ValueKey('Submit')), findsOneWidget);
  });

}