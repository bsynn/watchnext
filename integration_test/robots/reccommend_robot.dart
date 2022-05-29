import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

class Recrobot {
  const Recrobot(this.tester);
  final WidgetTester tester;

  Future<void> findTitle() async {
    await tester.pumpAndSettle(new Duration(seconds: 5));
    expect(find.text("Recommend"), findsWidgets);
  }

}
