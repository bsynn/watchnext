import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:myflutter/screen/navigation.dart';

class Selectrobot {
  const Selectrobot(this.tester);
  final WidgetTester tester;

  Future<void> findTitle() async {
    await tester.pumpAndSettle(new Duration(seconds: 5));
    await tester.tap(find.byType(InkWell).first);
    await tester.pumpAndSettle(new Duration(seconds: 5));
    expect(find.text("Storyline"), findsWidgets);
  }
}