import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:biovision_camp/main.dart';

void main() {
  testWidgets('App starts successfully', (WidgetTester tester) async {
    await tester.pumpWidget(const BioVisionCampApp());
    expect(find.text('BioVision Camp'), findsOneWidget);
  });
}
