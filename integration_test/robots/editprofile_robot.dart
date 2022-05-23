import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';


class EditProfilebot {
  const EditProfilebot(this.tester);
  final WidgetTester tester;

  Future<void> editprofile() async { 
    await tester.pumpAndSettle(new Duration(seconds: 5));
    expect(find.text("Edit Profile"), findsWidgets);
    await tester.tap(find.text("Edit Profile"));
    await tester.pumpAndSettle(new Duration(seconds: 5));
    await tester.pump(Duration(milliseconds:400));
    await tester.enterText(find.byType(TextFormField).first, 'god');
    await tester.pump(Duration(milliseconds:400));
    await tester.enterText(find.byType(TextFormField).last, 'SiN');
    await tester.pump(Duration(milliseconds:400));
    await tester.tap(find.text("Save"));
  }
}
