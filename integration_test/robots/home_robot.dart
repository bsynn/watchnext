import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:myflutter/screen/home.dart';

class Homerobot {
  const Homerobot(this.tester);
  final WidgetTester tester;

  Future<void> findTitle() async {
    await tester.pumpAndSettle(new Duration(seconds: 5));

    final Loginbtn = find.byKey(const Key('LogIn'));
    final Regisbtn = find.byKey(const Key('Register'));
    expect(Loginbtn, findsWidgets);
    expect(Regisbtn, findsWidgets);
  }

  Future<void> tapLogIn() async {
    final Loginbtn = find.byKey(const Key('LogIn'));
    await tester.ensureVisible(Loginbtn);
    await tester.tap(Loginbtn);
    expect(Loginbtn, findsWidgets);
  }

  Future<void> tapRegister() async {
    final Regisbtn = find.byKey(const Key('Register'));
    await tester.ensureVisible(Regisbtn);
    await tester.tap(Regisbtn);
    await tester.pumpAndSettle(new Duration(seconds: 5));
    expect(find.text("Create Account"), findsWidgets);
  }

}
