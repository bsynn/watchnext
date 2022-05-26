import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

class Createrobot {
  const Createrobot(this.tester);
  final WidgetTester tester;

  Future<void> findTitle() async {
    await tester.pumpAndSettle(new Duration(seconds: 5));
    expect(find.text("Create Account"), findsWidgets);
  }

  Future<void> Register({bool scrollUp = false}) async {
    final Regisbtn = find.byKey(const Key("Regisbtn1"));

    await tester.pump(Duration(milliseconds: 400));
    await tester.enterText(find.byKey(const Key("Name")), 'god1');
    await tester.pump(Duration(milliseconds: 400));
    await tester.enterText(find.byKey(const Key("Last Name")), 'god1');
    await tester.pump(Duration(milliseconds: 400));
    await tester.enterText(find.byKey(const Key("Email")), 'god1@mail.com');
    await tester.pump(Duration(milliseconds: 400));
    await tester.enterText(find.byKey(const Key("Password")), '123456');
    await tester.testTextInput.receiveAction(TextInputAction.done);
    await tester.pumpAndSettle(new Duration(seconds: 2));
    await tester.tap(Regisbtn);
    await tester.pumpAndSettle();
  }

  //still error
  Future<void> AlreadyAccount({bool scrollUp = false}) async {
    final Regisbtn = find.byKey(const Key("Regisbtn1"));

    await tester.pump(Duration(milliseconds: 400));
    await tester.enterText(find.byKey(const Key("Name")), 'god1');
    await tester.pump(Duration(milliseconds: 400));
    await tester.enterText(find.byKey(const Key("Last Name")), 'god1');
    await tester.pump(Duration(milliseconds: 400));
    await tester.enterText(find.byKey(const Key("Email")), 'god1@mail.com');
    await tester.pump(Duration(milliseconds: 400));
    await tester.enterText(find.byKey(const Key("Password")), '123456');
    await tester.testTextInput.receiveAction(TextInputAction.done);
    await tester.pumpAndSettle(new Duration(seconds: 2));
    await tester.tap(Regisbtn);
    expect(find.text("This email is already in use! Change to another email."),
        findsWidgets);
    await tester.pumpAndSettle(new Duration(seconds: 5));
  }

  //null tab register
  Future<void> NullInput({bool scrollUp = false}) async {
    final Regisbtn = find.byKey(const Key("Regisbtn1"));

    await tester.pump(Duration(milliseconds: 400));
    await tester.tap(Regisbtn);
    await tester.pumpAndSettle(new Duration(seconds: 5));
  }

  Future<void> fillNameOnly({bool scrollUp = false}) async {
    final Regisbtn = find.byKey(const Key("Regisbtn1"));

    await tester.pump(Duration(milliseconds: 400));
    await tester.enterText(find.byKey(const Key("Name")), 'god1');
    await tester.tap(Regisbtn);
    await tester.pumpAndSettle();
    expect(find.text("This field is required!"), findsWidgets);
    await tester.pumpAndSettle(new Duration(seconds: 5));
  }
  
  Future<void> WrongFormatEmail({bool scrollUp = false}) async {
    final Regisbtn = find.byKey(const Key("Regisbtn1"));

    await tester.pump(Duration(milliseconds: 400));
    await tester.enterText(find.byKey(const Key("Name")), 'god1');
    await tester.pump(Duration(milliseconds: 400));
    await tester.enterText(find.byKey(const Key("Last Name")), 'god1');
    await tester.pump(Duration(milliseconds: 400));
    await tester.enterText(find.byKey(const Key("Email")), 'god1.com');
    await tester.pump(Duration(milliseconds: 400));
    await tester.enterText(find.byKey(const Key("Password")), '123456');
    await tester.testTextInput.receiveAction(TextInputAction.done);
    await tester.pumpAndSettle(new Duration(seconds: 2));
    await tester.tap(Regisbtn);
    await tester.pumpAndSettle(new Duration(seconds: 5));
    expect(find.text("Invalid email format!"), findsWidgets);
    await tester.pumpAndSettle(new Duration(seconds: 5));
  }
}
