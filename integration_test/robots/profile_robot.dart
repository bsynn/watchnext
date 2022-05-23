import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';


class Profilebot {
  const Profilebot(this.tester);
  final WidgetTester tester;

  Future<void> editprofile() async { 
    await tester.pumpAndSettle(new Duration(seconds: 5));
    expect(find.text("Log Out"), findsWidgets);
  }
}
