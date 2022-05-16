// ignore_for_file: camel_case_types, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:provider/provider.dart';
import 'package:myflutter/providers/navigation_provider.dart';
import 'package:myflutter/screen/movieDetail.dart';

class mylist extends StatefulWidget {
  const mylist({Key? key}) : super(key: key);

  @override
  _mylistState createState() => _mylistState();
}

class _mylistState extends State<mylist> {
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
              'My List',
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
              .collection(FirebaseAuth.instance.currentUser!.uid)
              .snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot1) {
            if (!snapshot1.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return Scaffold(
              backgroundColor: Colors.black,
              body: SingleChildScrollView(
                child: SizedBox(
                  height: 600,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 10.0),
                    child: GridView.count(
                        crossAxisCount: 3,
                        mainAxisSpacing: 20,
                        crossAxisSpacing: 10,
                        childAspectRatio: (9 / 13.5),
                        children: snapshot1.data!.docs.map((document) {
                          return InkWell(
                            onTap: () async {
                              List<String> watch = List.from(document["watch"]);
                              provider.getDetail(
                                  document["name"],
                                  document["trailer"],
                                  document["Audience"],
                                  document["Critic"],
                                  document["storyline"],
                                  document["Type"],
                                  watch,
                                  document["ImagURL"]);
                              provider.havewacth(provider.WhereToWatch, watch);
                              await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MovieDetail()));
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                    image: NetworkImage(
                                      document["ImagURL"],
                                    ),
                                    fit: BoxFit.cover,
                                  )),
                            ),
                          );
                        }).toList()),
                  ),
                ),
              ),
            );
          },
        ));
  }
}
