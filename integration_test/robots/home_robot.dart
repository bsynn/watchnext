import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:myflutter/screen/home.dart';

class Homerobot {
  const Homerobot(this.tester);
  final WidgetTester tester;

  Future<void> findBtn() async {
    await tester.pumpAndSettle(new Duration(seconds: 5));

    final Loginbtn = find.byKey(const Key('LogIn'));
    await tester.ensureVisible(Loginbtn);
    await tester.tap(Loginbtn);
    expect(Loginbtn, findsWidgets);
  }
}
