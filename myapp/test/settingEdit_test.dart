import 'package:flutter/material.dart';
import 'package:myapp/SettingEdit.dart';
import 'package:flutter_test/flutter_test.dart';


void main(){
  /** mock an item*/
  final item = [13.25, 25.25, 'new location'];
  testWidgets('Widget test: Editing location page edit button', (WidgetTester tester) async {
    await tester.pumpWidget(
        MaterialApp(home: Post(item: item)));

    var button = find.byKey(ValueKey('edit'));
    /** screen title checking*/
    expect(button, findsOneWidget);
  });

  testWidgets('Widget test: editing page delete button', (WidgetTester tester) async {
    await tester.pumpWidget(
        MaterialApp(home: Post(item: item)));

    var button = find.byKey(ValueKey('delete'));
    /** screen title checking*/
    expect(button, findsOneWidget);
  });

  testWidgets('Widget test: Setting page location name text field', (WidgetTester tester) async {
    await tester.pumpWidget(
        MaterialApp(home: Post(item: item)));

    /** screen title checking*/
    expect(find.text('new location'), findsOneWidget);
  });

}