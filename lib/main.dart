// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_field, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:myflutter/providers/navigation_provider.dart';
import 'package:myflutter/screen/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) {
          return BottomNavigationBarProvider();
        }),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: "Watch Next",
          theme: ThemeData(primaryColor: Colors.black, fontFamily: 'Poppins'),
          home: HomeScreen()),
    );
  }
}
