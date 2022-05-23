import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:myflutter/screen/login.dart';

class LogInrobot {
  const LogInrobot(this.tester);
  final WidgetTester tester;

  Future<void> findTitle() async {
    await tester.pumpAndSettle();
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
  }
}
