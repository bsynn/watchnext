import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

class MyListrobot {
  const MyListrobot(this.tester);
  final WidgetTester tester;

  Future<void> AddMovie({bool scrollUp = false}) async {
    final Favbtn = find.byKey(const Key('FavoriteButton'));
    final Back = find.byKey(const Key('back'));
    final gesture =
        await tester.startGesture(Offset(0, 200)); //Position of the scrollview
    await gesture.moveBy(Offset(0, -200)); //How much to scroll

    await tester.pumpAndSettle(new Duration(seconds: 5));
    await tester.tap(Favbtn);
    await tester.pumpAndSettle(new Duration(seconds: 5));
    expect(Favbtn, findsWidgets);
    await tester.tap(Back);
    await tester.pumpAndSettle(new Duration(seconds: 5));
  }

  String getNameFromAdd() {
    final movieText = find.byKey(const Key("movieName"));
    var text = movieText.evaluate().single.widget as Text;
    return text.data.toString();
  }
  String getTypeFromAdd() {
    final movieText = find.byKey(const Key("movieType"));
    var text = movieText.evaluate().single.widget as Text;
    return text.data.toString();
  }
  String getCriticFromAdd() {
    final movieText = find.byKey(const Key("movieCritic"));
    var text = movieText.evaluate().single.widget as Text;
    return text.data.toString();
  }
  String getAudienceFromAdd() {
    final movieText = find.byKey(const Key("movieAudience"));
    var text = movieText.evaluate().single.widget as Text;
    return text.data.toString();
  }
  String getStorylineFromAdd() {
    final movieText = find.byKey(const Key("movieStoryline"));
    var text = movieText.evaluate().single.widget as Text;
    return text.data.toString();
  }
  
  
  Future<void> setAddTofirebase(String name1, String vdoURL1, String audience1, String critic1,
      String storyline1, String type1, String watch, String imgURL1) async {
    DocumentReference storeReference = FirebaseFirestore
                              .instance
                              .collection(
                                  FirebaseAuth.instance.currentUser!.uid)
                              .doc(name1);
                          await storeReference.set({
                            "Type":type1,
                            "Audience":audience1,
                            "Critic":critic1,
                            "ImagURL":imgURL1,
                            "name":name1,
                            "storyline":storyline1,
                            "trailer":"",
                            "watch": "",
                          });
  }

  Future<void> RemoveFromFirebase(String name1)async {
    FirebaseFirestore.instance
                              .collection(
                                  FirebaseAuth.instance.currentUser!.uid)
                              .doc(name1)
                              .delete();
  }
}
