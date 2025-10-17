import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:explora_jampa/main.dart';

void main() {
  testWidgets('App starts with MapScreen', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp());

    // Verify that the MapScreen is displayed.
    expect(find.text('Mapa'), findsOneWidget);
    expect(find.text('Aqui será exibido o mapa.'), findsOneWidget);
  });
}
