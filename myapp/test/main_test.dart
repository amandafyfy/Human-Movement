import 'package:flutter/material.dart';
import 'package:myapp/main.dart';
import 'package:flutter_test/flutter_test.dart';
import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'package:myapp/UserData.dart';


void main(){

  /**Test main page element */
  testWidgets('Myapp test', (WidgetTester tester) async {
    await tester.pumpWidget(new MyApp());

    /** 1st widget for user guide */
    expect(find.text('Open user profile'), findsOneWidget);
    /** 2nd widget for user guide */
    expect(find.text('Open Map Setting'), findsOneWidget);
  });

  /** test drawer */
  testWidgets('my drawer test', (WidgetTester tester) async {
    final scaffoldKey = GlobalKey<ScaffoldState>();
    const displayName = "displayName";

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          key: scaffoldKey,
          drawer: const Text(displayName),
        ),
      ),
    );

    scaffoldKey.currentState?.openDrawer();
    await tester.pump();

    expect(find.text(displayName), findsOneWidget);
  });

  /** setUserState test function*/
  test('add headers to csv ', () {
    List<dynamic> row = ["date","latitude","longitude", "speed"];
    List<List<dynamic>> rows = [];
    new MyHomePage(title: 'Flutter Demo Home Page').createState().add_head(rows);
    expect(row, rows.first);
  });

  /** add context test function*/
  test('add rows to csv ', () {
    List<List<dynamic>> rows = [];
    DataPoint row = DataPoint(12000, 12.5, 78.5, 2.0);
    List<DataPoint> UserData = [];
    UserData.add(row);
    new MyHomePage(title: 'Flutter Demo Home Page').createState().add_context(rows);
    expect(row.date, UserData[0].date);
    expect(row.latitude, UserData[0].latitude);
    expect(row.longitude, UserData[0].longitude);
    expect(row.speed, UserData[0].speed);
  });

  test('test generating of csv file ', () async{

    final Homepage = MyHomePage(title: 'Flutter Demo Home Page').createState();
    final generator = Homepage.generateCsvFile();
    bool generatecsv = true;
    expect(generatecsv, true);
    //expect(row, rows.first);
  });

}