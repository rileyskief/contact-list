// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:to_dont_list/main.dart';
import 'package:to_dont_list/objects/dog.dart';
import 'package:to_dont_list/widgets/to_do_items.dart';

void main() {
  testWidgets('DogListItem has collar color as elevated button',
      (tester) async {
    await tester.pumpWidget(MaterialApp(
        home: Scaffold(
            body: DogListItem(
                dog: Dog(
                    name: "test", collar: CollarColor.blue, breed: "testbreed"),
                completed: true,
                onListChanged: (Dog dog, bool completed) {},
                onDeleteItem: (Dog dog) {}))));
    final buttonFinder = find.byType(ElevatedButton);
    final ElevatedButton test = tester.widget(buttonFinder);
    final buttonColor = test.style?.backgroundColor?.resolve({});

    expect(buttonColor, equals(CollarColor.blue.color));
  });

  // Yes, you really need the MaterialApp and Scaffold
  testWidgets('DogListItem has a text', (tester) async {
    await tester.pumpWidget(MaterialApp(
        home: Scaffold(
            body: DogListItem(
                dog: Dog(
                    name: "test", collar: CollarColor.blue, breed: "testbreed"),
                completed: true,
                onListChanged: (Dog dog, bool completed) {},
                onDeleteItem: (Dog dog) {}))));
    final textFinder = find.text('test');

    // Use the `findsOneWidget` matcher provided by flutter_test to verify
    // that the Text widgets appear exactly once in the widget tree.
    expect(textFinder, findsOneWidget);
  });

  testWidgets(
      'ToDoListItem has Elevated Button that increases encounters when pressed',
      (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: DogListItem(
              dog: Dog(name: "test", collar: CollarColor.blue, breed: "test"),
              completed: true,
              onListChanged: (Dog dog, bool completed) {},
              onDeleteItem: (Dog dog) {}),
        ),
      ),
    );
    final buttonFinder = find.byType(ElevatedButton);
    expect(find.text('1'), findsOneWidget);

    await tester.tap(buttonFinder);
    await tester.pump();

    expect(find.text('2'), findsOne);
  });

  testWidgets('Default ToDoList has one item', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: ToDoList()));

    final listItemFinder = find.byType(DogListItem);

    expect(listItemFinder, findsOneWidget);
  });

  testWidgets('Clicking and Typing adds item to ToDoList', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: ToDoList()));

    expect(find.byType(TextField), findsNothing);

    await tester.tap(find.byType(FloatingActionButton));
    await tester.pump(); // Pump after every action to rebuild the widgets
    expect(find.text("name"), findsNothing);

    await tester.enterText(find.byType(TextField), 'name');
    await tester.pump();
    expect(find.text("name"), findsOneWidget);
    await tester.tap(find.byKey(const Key("OKButton")));
    await tester.pump();

    expect(find.text("name"), findsOneWidget);

    final listItemFinder = find.byType(DogListItem);

    expect(listItemFinder, findsNWidgets(2));
  });

  // One to test the tap and press actions on the items?
}
