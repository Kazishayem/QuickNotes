import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:quicknotes/presentration/note/note details/view/notedetails_screen.dart';

void main() {
  testWidgets('note details screen renders title and description', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: NoteDetailsScreen(
          title: 'Test title',
          description: 'Test description',
        ),
      ),
    );

    expect(find.text('Test title'), findsOneWidget);
    expect(find.text('Test description'), findsOneWidget);
  });
}
