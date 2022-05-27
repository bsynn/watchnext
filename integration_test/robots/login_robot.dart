import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:myflutter/screen/login.dart';

class LogInrobot {
  const LogInrobot(this.tester);
  final WidgetTester tester;

  Future<void> findTitle() async {
    await tester.pumpAndSettle(new Duration(seconds: 5));
    expect(find.text("Log In"), findsWidgets);
  }

  Future<void> LogIn({bool scrollUp = false}) async {
    final LogInbtn = find.byKey(const Key('loginbtn'));

    await tester.pump(Duration(milliseconds: 400));
    await tester.enterText(find.byType(TextFormField).first, 'god@mail.com');
    await tester.pump(Duration(milliseconds: 400));
    await tester.enterText(find.byType(TextFormField).last, '123456');
    await tester.pump(Duration(milliseconds: 400));
    await tester.tap(LogInbtn);
    await tester.pumpAndSettle();
  }

  Future<void> tapCreate() async {
    final Createbtn = find.byKey(const Key('Createbtn'));
    await tester.tap(Createbtn);
    await tester.pumpAndSettle(new Duration(seconds: 5));
    expect(find.text("Create Account"), findsWidgets);
  }

  Future<void> fillEmailOnly({bool scrollUp = false}) async {
    final LogInbtn = find.byKey(const Key('loginbtn'));
    await tester.pump(Duration(milliseconds: 400));
    await tester.enterText(find.byType(TextFormField).first, 'god@mail.com');
    await tester.tap(LogInbtn);
    await tester.pumpAndSettle();
    expect(find.text("This field is required!"), findsWidgets);
    await tester.pumpAndSettle();
  }

  Future<void> fillPassOnly({bool scrollUp = false}) async {
    final LogInbtn = find.byKey(const Key('loginbtn'));
    await tester.pump(Duration(milliseconds: 400));
    await tester.enterText(find.byType(TextFormField).last, '123456');
    await tester.tap(LogInbtn);
    await tester.pumpAndSettle();
    expect(find.text("This field is required!"), findsWidgets);
    await tester.pumpAndSettle();
  }

  Future<void> WrongFormatEmail({bool scrollUp = false}) async {
    final LogInbtn = find.byKey(const Key('loginbtn'));
    await tester.pump(Duration(milliseconds: 400));
    await tester.enterText(find.byType(TextFormField).first, 'god.com');
    await tester.tap(LogInbtn);
    await tester.pumpAndSettle();
    expect(find.text("Invalid email format!"), findsWidgets);
    await tester.pumpAndSettle();
  }

  Future<void> WrongEmailOrPass({bool scrollUp = false}) async {
    final LogInbtn = find.byKey(const Key('loginbtn'));

    await tester.pump(Duration(milliseconds: 400));
    await tester.enterText(find.byType(TextFormField).first, 'god1@mail.com');
    await tester.pump(Duration(milliseconds: 400));
    await tester.enterText(find.byType(TextFormField).last, '1234567');
    await tester.pump(Duration(milliseconds: 400));
    await tester.testTextInput.receiveAction(TextInputAction.done);
    await tester.pumpAndSettle(new Duration(seconds: 2));
    await tester.tap(LogInbtn);
    await tester.pumpAndSettle(new Duration(seconds: 5));
    expect(
        find.text(
            "The password is invalid or the user does not have a password."),
        findsWidgets);
    await tester.pumpAndSettle(new Duration(seconds: 5));
  }

  //null tab login
  Future<void> NullInput({bool scrollUp = false}) async {
    final LogInbtn = find.byKey(const Key('loginbtn'));
    await tester.pump(Duration(milliseconds: 400));
    await tester.tap(LogInbtn);
    await tester.pumpAndSettle();
    expect(find.text("This field is required!"), findsWidgets);
    await tester.pumpAndSettle();
  }
}
