import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:explora_jampa/main.dart';

void main() {
  testWidgets('App starts with HomeScreen and BottomNavigationBar', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp());

    // Verify that the HomeScreen is displayed.
    expect(find.byIcon(Icons.map), findsOneWidget);
    expect(find.byIcon(Icons.explore), findsOneWidget);
    expect(find.byIcon(Icons.person), findsOneWidget);

    // Verify that the MapScreen is displayed by default.
    expect(find.text('Mapa de João Pessoa'), findsOneWidget);
  });
}
