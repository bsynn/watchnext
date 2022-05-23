// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:form_field_validator/form_field_validator.dart';

import 'package:myflutter/model/profile.dart';
import 'package:myflutter/screen/profile.dart';
import 'package:provider/provider.dart';
import 'package:myflutter/providers/navigation_provider.dart';


class editprofile extends StatefulWidget {
  const editprofile({Key? key}) : super(key: key);

  @override
  _editprofileState createState() => _editprofileState();
}

class _editprofileState extends State<editprofile> {
  final formKey = GlobalKey<FormState>();
  Profile profile = Profile(name: "", lname: "", email: "", password: "");

  final Future<FirebaseApp> firebase = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    var provider =
        Provider.of<BottomNavigationBarProvider>(context, listen: false);
    String imgName = provider.pname;
    String imgName2 = imgName.substring(0, 1);
    return FutureBuilder(
        future: firebase,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Scaffold(
              appBar: AppBar(
                title: Text("Error"),
              ),
              body: Center(
                child: Text("${snapshot.error}"),
              ),
            );
          }
          if (snapshot.connectionState == ConnectionState.done) {
            return Scaffold(
              backgroundColor: Colors.black,
              appBar: AppBar(
                backgroundColor: Colors.black,
                title: Text("Edit Profile"),
                centerTitle: true,
                leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.arrow_back_ios_rounded),
                ),
                actions: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Colors.black,
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(30)))),
                    child: Text("Save",
                        style: TextStyle(fontSize: 18, color: Colors.red)),
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        formKey.currentState!.save();
                        DocumentReference storeReference = FirebaseFirestore
                            .instance
                            .collection("profile" +
                                FirebaseAuth.instance.currentUser!.uid)
                            .doc(FirebaseAuth.instance.currentUser!.uid);
                        await storeReference.update(
                            {"name": profile.name, "lname": profile.lname});
                        Navigator.pop(context);
                      }
                    },
                  ),
                ],
              ),
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          child: CircleAvatar(
                            backgroundColor: Color(0xFF8C8C8C),
                            radius: 40,
                            child: Text(imgName2, style: TextStyle(fontSize: 25, color: Colors.white),)
                          ),
                        )
                      ],
                    ),
                    Form(
                      key: formKey,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30.0, vertical: 15.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 5.0),
                              child: SizedBox(
                                  child: Text(
                                "Name",
                                style:
                                    TextStyle(fontSize: 16, color: Colors.white),
                              )),
                            ),
                            TextFormField(
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                              ),
                              validator: RequiredValidator(
                                  errorText: "This field is required!"),
                              onSaved: (name) {
                                profile.name = name!;
                              },
                              initialValue: provider.pname,
                              decoration: InputDecoration(
                                hintText: 'Name',
                                hintStyle: TextStyle(
                                    fontSize: 16, color: Colors.grey.shade500),
                                fillColor: Colors.white,
                                filled: true,
                                border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                              ),
                            ),
                            SizedBox(height: 15),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 5.0),
                              child: SizedBox(
                                  child: Text(
                                "Last Name",
                                style:
                                    TextStyle(fontSize: 16, color: Colors.white),
                              )),
                            ),
                            TextFormField(
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                              ),
                              validator: RequiredValidator(
                                  errorText: "This field is required!"),
                              onSaved: (lname) {
                                profile.lname = lname!;
                              },
                              initialValue: provider.plname,
                              decoration: InputDecoration(
                                hintText: 'Last Name',
                                hintStyle: TextStyle(
                                    fontSize: 16, color: Colors.grey.shade500),
                                fillColor: Colors.white,
                                filled: true,
                                border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                              ),
                            ),
                            // SizedBox(height: 40),
                            // SizedBox(
                            //   height: 55,
                            //   width: double.infinity,
                            //   child: ElevatedButton(
                            //     style: ElevatedButton.styleFrom(
                            //         primary: Color(0xFFE82C3A),
                            //         onPrimary: Colors.white,
                            //         shape: RoundedRectangleBorder(
                            //             borderRadius: BorderRadius.all(
                            //                 Radius.circular(10)))),
                            //     child: Text("Save",
                            //         style: TextStyle(fontSize: 18)),
                            //     onPressed: () async {
                            //       if (formKey.currentState!.validate()) {
                            //         formKey.currentState!.save();

                            //         DocumentReference storeReference =
                            //             FirebaseFirestore
                            //                 .instance
                            //                 .collection("profile" +
                            //                     FirebaseAuth
                            //                         .instance.currentUser!.uid)
                            //                 .doc(FirebaseAuth
                            //                     .instance.currentUser!.uid);
                            //         await storeReference.update({
                            //           "name": profile.name,
                            //           "lname": profile.lname
                            //         });
                            //         Navigator.push(context,
                            //             MaterialPageRoute(builder: (context) {
                            //           return profileScreen();
                            //         }));
                            //       }
                            //     },
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
          return Scaffold(
            backgroundColor: Colors.black,
            body: Center(child: CircularProgressIndicator()),
          );
        });
  }
}
