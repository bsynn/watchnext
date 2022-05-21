// ignore_for_file: prefer_const_constructors

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:myflutter/screen/mylist.dart';
import 'package:myflutter/screen/profile.dart';
import 'package:myflutter/screen/recommend.dart';

import 'package:provider/provider.dart';
import 'package:myflutter/screen/selectMovie.dart';
import 'package:myflutter/providers/navigation_provider.dart';

class BottomNavigationBarExample extends StatefulWidget {
  @override
  _BottomNavigationBarExampleState createState() =>
      _BottomNavigationBarExampleState();
}

class _BottomNavigationBarExampleState
    extends State<BottomNavigationBarExample> {
  final Future<FirebaseApp> firebase = Firebase.initializeApp();
  var currentTab = [selectMovic(), mylist(), recScreen(), profileScreen()];

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<BottomNavigationBarProvider>(context);
    return Scaffold(
      key: Key('navigationpage'),
      body: currentTab[provider.currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        iconSize: 28.0,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey.shade700,
        showUnselectedLabels: true,
        selectedFontSize: 14.0,
        unselectedFontSize: 13.0,
        currentIndex: provider.currentIndex,
        onTap: (index) {
          provider.currentIndex = index;
        },
        items: [
          BottomNavigationBarItem(
            backgroundColor: Colors.black,
            icon: new Icon(Icons.local_movies_rounded),
            title: new Text('Movies'),
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.black,
            icon: new Icon(Icons.favorite_border_rounded),
            title: new Text('My List'),
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.black,
            icon: new Icon(Icons.recommend_rounded),
            title: new Text('Recommend'),
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.black,
            icon: Icon(Icons.person),
            title: Text('Profile'),
          )
        ],
      ),
    );
  }
}

class Home2 extends StatefulWidget {
  const Home2({Key? key}) : super(key: key);

  @override
  _Home2State createState() => _Home2State();
}

class _Home2State extends State<Home2> {
  @override
  Widget build(BuildContext context) {
    return selectMovic();
  }
}
