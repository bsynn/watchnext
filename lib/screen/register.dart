// ignore_for_file: prefer_const_constructors, unused_local_variable, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:myflutter/model/profile.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:myflutter/screen/home.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final formKey = GlobalKey<FormState>();
  Profile profile = Profile(name: "", lname: "", email: "", password: "");
  final Future<FirebaseApp> firebase = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
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
                leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.arrow_back_ios_rounded),
                ),
              ),
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15.0),
                          child: Image.asset(
                            "assets/images/2.png",
                            height: 90,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          child: Text(
                            "Create Account",
                            style: TextStyle(fontSize: 32, color: Colors.white),
                          ),
                        )
                      ],
                    ),
                    Form(
                      key: formKey,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30.0, vertical: 25.0),
                        child: Column(
                          children: [
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
                            SizedBox(height: 15),
                            TextFormField(
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                              ),
                              validator: MultiValidator([
                                RequiredValidator(
                                    errorText: "This field is required!"),
                                EmailValidator(
                                    errorText: "Invalid email format!")
                              ]),
                              keyboardType: TextInputType.emailAddress,
                              onSaved: (email) {
                                profile.email = email!;
                              },
                              decoration: InputDecoration(
                                hintText: 'Email',
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
                            TextFormField(
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                              ),
                              validator: RequiredValidator(
                                  errorText: "This field is required!"),
                              obscureText: true,
                              onSaved: (password) {
                                profile.password = password!;
                              },
                              decoration: InputDecoration(
                                hintText: 'Password',
                                hintStyle: TextStyle(
                                    fontSize: 16, color: Colors.grey.shade500),
                                fillColor: Colors.white,
                                filled: true,
                                border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                              ),
                            ),
                            SizedBox(height: 40),
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
                                child: Text("Register",
                                    style: TextStyle(fontSize: 18)),
                                onPressed: () async {
                                  if (formKey.currentState!.validate()) {
                                    formKey.currentState!.save();

                                    try {
                                      await FirebaseAuth.instance
                                          .createUserWithEmailAndPassword(
                                              email: profile.email,
                                              password: profile.password)
                                          .then((value) => {
                                                FirebaseFirestore.instance
                                                    .collection("profile" +
                                                        value.user!.uid)
                                                    .doc(value.user!.uid)
                                                    .set({
                                                  "name": profile.name,
                                                  "lname": profile.lname,
                                                  "email": profile.email,
                                                  "password": profile.password,
                                                })
                                              });
                                      Fluttertoast.showToast(
                                          msg: "Created an account already!",
                                          gravity: ToastGravity.TOP);
                                      formKey.currentState!.reset();
                                      Navigator.pushReplacement(context,
                                          MaterialPageRoute(builder: (context) {
                                        return HomeScreen();
                                      }));
                                    } on FirebaseAuthException catch (e) {
                                      String message;
                                      if (e.code == 'email-already-in-use') {
                                        message =
                                            "This email is already in use! Change to another email.";
                                      } else if (e.code == 'weak-password') {
                                        message =
                                            "The password needs to be longer than 6 or equal.";
                                      } else {
                                        message = e.message!;
                                      }
                                      Fluttertoast.showToast(
                                          msg: e.message!,
                                          gravity: ToastGravity.TOP);
                                    }
                                  }
                                },
                              ),
                            ),
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
