import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

class MyListrobot {
  const MyListrobot(this.tester);
  final WidgetTester tester;

  Future<void> AddMovie ({bool scrollUp = false}) async {
    final Favbtn = find.byKey(const Key('FavoriteButton'));
    final Back = find.byKey(const Key('back'));
    await tester.tap(Favbtn);
    await tester.pumpAndSettle(new Duration(seconds: 2));
    expect(Favbtn, findsWidgets);
    await tester.tap(Back);
    await tester.pumpAndSettle(new Duration(seconds: 2));

    final navi = find.byKey(const Key("navi"));
    final favorite = find.byIcon(Icons.favorite_border_rounded);
    await tester.pumpAndSettle(new Duration(seconds: 5));
    expect(navi, findsWidgets);
    await tester.pumpAndSettle(new Duration(seconds: 2));
    await tester.tap(favorite);
    //expect(Favbtn, findsWidgets);

  }
}
