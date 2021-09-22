import 'package:flutter/material.dart';
import 'package:myapp/Setting.dart';
import 'package:myapp/main.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';


void main(){
  location thislocation = location(115.857048, -31.953512);

  testWidgets('Setting page title', (WidgetTester tester) async {
    await tester.pumpWidget(
        MaterialApp(home: Setting(thislocation: thislocation)));

    /** screen title checking*/
    expect(find.text('Visited Places'), findsOneWidget);
  });

  testWidgets('Setting page submit button', (WidgetTester tester) async {
    await tester.pumpWidget(
        MaterialApp(home: Setting(thislocation: thislocation)));

    var button = find.byKey(ValueKey('finish'));
    /** screen title checking*/
    expect(button, findsOneWidget);
  });

  testWidgets('Setting page Editing button', (WidgetTester tester) async {
    await tester.pumpWidget(
        MaterialApp(home: Setting(thislocation: thislocation)));

    var button = find.byKey(ValueKey('edit'));
    /** screen title checking*/
    expect(button, findsOneWidget);
  });


  test('checking read file ', () async{
    final directory = await getApplicationDocumentsDirectory();
    final path = directory.path + "/locations.csv";
    File locationfile = File(path);
    expect(await locationfile.exists(), false);
  });
}