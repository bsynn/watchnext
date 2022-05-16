// ignore_for_file: prefer_const_constructors, camel_case_types, unused_element

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:myflutter/model/profile.dart';
import 'package:myflutter/providers/navigation_provider.dart';
import 'package:myflutter/screen/editprofile.dart';
import 'package:myflutter/screen/home.dart';

import 'package:provider/provider.dart';

class profileScreen extends StatefulWidget {
  const profileScreen({Key? key}) : super(key: key);

  @override
  _profileScreenState createState() => _profileScreenState();
}

class _profileScreenState extends State<profileScreen> {
  final formKey = GlobalKey<FormState>();
  Profile profile = Profile(name: "", lname: "", email: "", password: "");
  final Future<FirebaseApp> firebase = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    var provider =
        Provider.of<BottomNavigationBarProvider>(context, listen: false);
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          automaticallyImplyLeading: false,
          title: Padding(
            padding: const EdgeInsets.only(left: 5.0),
            child: Text(
              'Profile',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: Image.asset(
                "assets/images/2.png",
                width: 35,
              ),
            ),
          ],
        ),
        body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("profile" + FirebaseAuth.instance.currentUser!.uid)
              .snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return Scaffold(
              backgroundColor: Colors.black,
              body: Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
                child: SingleChildScrollView(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                            child: Text(
                          "Name",
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        )),
                        SizedBox(height: 5),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                          ),
                          width: double.infinity,
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Text(
                              snapshot.data!.docs[0]["name"].toString(),
                              style: TextStyle(fontSize: 18, color: Colors.black),
                            ),
                          ),
                        ),
                        SizedBox(height: 15),
                        SizedBox(
                            child: Text(
                          "Last Name",
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        )),
                        SizedBox(height: 5),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                          ),
                          width: double.infinity,
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Text(
                              snapshot.data!.docs[0]["lname"].toString(),
                              style: TextStyle(fontSize: 18,  color: Colors.black),
                            ),
                          ),
                        ),
                        SizedBox(height: 15),
                        SizedBox(
                            child: Text(
                          "Email",
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        )),
                        SizedBox(height: 5),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                          ),
                          width: double.infinity,
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Text(
                              snapshot.data!.docs[0]["email"].toString(),
                              style: TextStyle(fontSize: 18, color: Colors.black),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        SizedBox(
                          height: 55,
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: Colors.grey.shade700,
                                onPrimary: Colors.white,
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)))),
                            child: Text("Edit Profile",
                                style: TextStyle(fontSize: 18)),
                            onPressed: () {
                              provider.getPnamePlname(
                                  snapshot.data!.docs[0]["name"].toString(),
                                  snapshot.data!.docs[0]["lname"].toString());
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return editprofile();
                              }));
                            },
                          ),
                        ),
                        SizedBox(height: 60),
                        Divider(
                              thickness: 1,
                              color: Colors.white,
                            ),
                        SizedBox(height: 15),
                        SizedBox(
                          height: 55,
                          width: double.infinity,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: Color(0xFFE82C3A),
                                  onPrimary: Colors.white,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10)))),
                              child: Text("Log Out",
                                  style: TextStyle(fontSize: 18)),
                              onPressed: () {
                                Future<void> _signOut() async {
                                  await FirebaseAuth.instance.signOut();
                                }

                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return HomeScreen();
                                }));
                              }),
                        ),
                        SizedBox(height: 8,),
                        Center(
                          child: Text(
                                "Log out or Change account",
                                style:
                                    TextStyle(fontSize: 12, color: Colors.white),
                              ),
                        ),
                      ]),
                ),
              ),
            );
          },
        ));
  }
}
