import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';


class Navigationbot {
  const Navigationbot(this.tester);
  final WidgetTester tester;

  Future<void> findWidgetandIcon() async {
    final navi = find.byKey(const Key("navi"));
    final movieIcon = find.byIcon(Icons.local_movies_rounded);
    await tester.pumpAndSettle(new Duration(seconds: 5));
    expect(navi, findsWidgets);
    await tester.pumpAndSettle(new Duration(seconds: 2));
    expect(movieIcon, findsWidgets);

  }

  Future<void> tapProfile() async {
    final navi = find.byKey(const Key("navi"));
    final profile = find.byIcon(Icons.person);
    await tester.pumpAndSettle(new Duration(seconds: 5));
    expect(navi, findsWidgets);
    await tester.pumpAndSettle(new Duration(seconds: 2));
    await tester.tap(profile);
  }

  Future<void> tapMovie() async {
    final navi = find.byKey(const Key("navi"));
    final movieIcon = find.byIcon(Icons.local_movies_rounded);
    await tester.pumpAndSettle(new Duration(seconds: 5));
    expect(navi, findsWidgets);
    await tester.pumpAndSettle(new Duration(seconds: 2));
    await tester.tap(movieIcon);
  }

  Future<void> tapReccommend() async {
    final navi = find.byKey(const Key("navi"));
    final recIcon = find.byIcon(Icons.recommend_rounded);
    await tester.pumpAndSettle(new Duration(seconds: 5));
    expect(navi, findsWidgets);
    await tester.pumpAndSettle(new Duration(seconds: 2));
    await tester.tap(recIcon);
  }
}
