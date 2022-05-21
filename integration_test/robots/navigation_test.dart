import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:myflutter/screen/selectMovie.dart';

class Navigationbot {
  const Navigationbot(this.tester);
  final WidgetTester tester;

  Future<void> findTitle() async {
    final navigationtitle = find.byKey(const Key('navigationpage'));
    await tester.pumpAndSettle();
    expect(navigationtitle, findsOneWidget);
  }
}
