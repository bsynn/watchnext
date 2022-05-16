// ignore_for_file: camel_case_types, file_names, prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace, avoid_print, non_constant_identifier_names

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:myflutter/providers/navigation_provider.dart';

import 'package:myflutter/screen/movieDetail.dart';

class selectMovic extends StatefulWidget {
  const selectMovic({Key? key}) : super(key: key);

  @override
  _selectMovicState createState() => _selectMovicState();
}

class _selectMovicState extends State<selectMovic> {
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
              'Movies',
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
          stream: FirebaseFirestore.instance.collection("Action").snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot1) {
            return StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("Adventure")
                  .snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot2) {
                return StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("Comedy")
                      .snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot3) {
                    return StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection("Drama")
                          .snapshots(),
                      builder:
                          (context, AsyncSnapshot<QuerySnapshot> snapshot4) {
                        return StreamBuilder(
                            stream: FirebaseFirestore.instance
                                .collection("Fantasy")
                                .snapshots(),
                            builder: (context,
                                AsyncSnapshot<QuerySnapshot> snapshot5) {
                              return StreamBuilder(
                                stream: FirebaseFirestore.instance
                                    .collection("Horror")
                                    .snapshots(),
                                builder: (context,
                                    AsyncSnapshot<QuerySnapshot> snapshot6) {
                                  return StreamBuilder(
                                    stream: FirebaseFirestore.instance
                                        .collection("Mystery")
                                        .snapshots(),
                                    builder: (context,
                                        AsyncSnapshot<QuerySnapshot>
                                            snapshot7) {
                                      return StreamBuilder(
                                        stream: FirebaseFirestore.instance
                                            .collection("Romance")
                                            .snapshots(),
                                        builder: (context,
                                            AsyncSnapshot<QuerySnapshot>
                                                snapshot8) {
                                          return StreamBuilder(
                                            stream: FirebaseFirestore.instance
                                                .collection("Thriller")
                                                .snapshots(),
                                            builder: (context,
                                                AsyncSnapshot<QuerySnapshot>
                                                    snapshot9) {
                                              return StreamBuilder(
                                                  stream: FirebaseFirestore
                                                      .instance
                                                      .collection(FirebaseAuth
                                                          .instance
                                                          .currentUser!
                                                          .uid)
                                                      .snapshots(),
                                                  builder: (context,
                                                      AsyncSnapshot<
                                                              QuerySnapshot>
                                                          snapshot10) {
                                                    if (!snapshot1.hasData ||
                                                        !snapshot2.hasData ||
                                                        !snapshot3.hasData ||
                                                        !snapshot4.hasData ||
                                                        !snapshot5.hasData ||
                                                        !snapshot6.hasData ||
                                                        !snapshot7.hasData ||
                                                        !snapshot8.hasData ||
                                                        !snapshot9.hasData ||
                                                        !snapshot10.hasData) {
                                                      return Center(
                                                        child:
                                                            CircularProgressIndicator(),
                                                      );
                                                    }
                                                    List Mylist =
                                                        snapshot10.data!.docs;
                                                    provider.mylist = Mylist;

                                                    return Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 20.0,
                                                              top: 10.0),
                                                      child: Scaffold(
                                                        backgroundColor:
                                                            Colors.black,
                                                        body:
                                                            SingleChildScrollView(
                                                          child: Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                SizedBox(
                                                                  child: Text(
                                                                    "Action",
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            24,
                                                                        color: Colors
                                                                            .white),
                                                                  ),
                                                                ),
                                                                Container(
                                                                  height: 190,
                                                                  child: ListView(
                                                                      scrollDirection: Axis.horizontal,
                                                                      children: snapshot1.data!.docs.map((document) {
                                                                        return Padding(
                                                                          padding: const EdgeInsets.only(
                                                                              top: 8.0,
                                                                              right: 15.0),
                                                                          child:
                                                                              InkWell(
                                                                            onTap:
                                                                                () {
                                                                              List<String> watch = List.from(document["watch"]);
                                                                              provider.getDetail(document["name"], document["trailer"], document["Audience"], document["Critic"], document["storyline"], "Action", watch, document["ImgURL"]);
                                                                              provider.havewacth(provider.WhereToWatch, watch);
                                                                              Navigator.push(context, MaterialPageRoute(builder: (context) => MovieDetail()));
                                                                            },
                                                                            child:
                                                                                Container(
                                                                              width: 120,
                                                                              decoration: BoxDecoration(
                                                                                  borderRadius: BorderRadius.circular(10),
                                                                                  image: DecorationImage(
                                                                                    image: NetworkImage(
                                                                                      document["ImgURL"],
                                                                                    ),
                                                                                    fit: BoxFit.cover,
                                                                                  )),
                                                                            ),
                                                                          ),
                                                                        );
                                                                      }).toList()),
                                                                ),
                                                                SizedBox(
                                                                  height: 20.0,
                                                                ),
                                                                SizedBox(
                                                                  child: Text(
                                                                    "Adventure",
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            24,
                                                                        color: Colors
                                                                            .white),
                                                                  ),
                                                                ),
                                                                Container(
                                                                  height: 190,
                                                                  child: ListView(
                                                                      scrollDirection: Axis.horizontal,
                                                                      children: snapshot2.data!.docs.map((document) {
                                                                        return Padding(
                                                                          padding: const EdgeInsets.only(
                                                                              top: 8.0,
                                                                              right: 15.0),
                                                                          child:
                                                                              InkWell(
                                                                            onTap:
                                                                                () {
                                                                              List<String> watch = List.from(document["watch"]);
                                                                              provider.getDetail(document["name"], document["trailer"], document["Audience"], document["Critic"], document["storyline"], "Adventure", watch, document["ImgURL"]);
                                                                              provider.havewacth(provider.WhereToWatch, watch);
                                                                              Navigator.push(context, MaterialPageRoute(builder: (context) => MovieDetail()));
                                                                            },
                                                                            child:
                                                                                Container(
                                                                              width: 120,
                                                                              decoration: BoxDecoration(
                                                                                  borderRadius: BorderRadius.circular(10),
                                                                                  image: DecorationImage(
                                                                                    image: NetworkImage(
                                                                                      document["ImgURL"],
                                                                                    ),
                                                                                    fit: BoxFit.cover,
                                                                                  )),
                                                                            ),
                                                                          ),
                                                                        );
                                                                      }).toList()),
                                                                ),
                                                                SizedBox(
                                                                  height: 20.0,
                                                                ),
                                                                SizedBox(
                                                                  child: Text(
                                                                    "Comedy",
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            24,
                                                                        color: Colors
                                                                            .white),
                                                                  ),
                                                                ),
                                                                Container(
                                                                  height: 190,
                                                                  child: ListView(
                                                                      scrollDirection: Axis.horizontal,
                                                                      children: snapshot3.data!.docs.map((document) {
                                                                        return Padding(
                                                                          padding: const EdgeInsets.only(
                                                                              top: 8.0,
                                                                              right: 15.0),
                                                                          child:
                                                                              InkWell(
                                                                            onTap:
                                                                                () {
                                                                              List<String> watch = List.from(document["watch"]);
                                                                              provider.getDetail(document["name"], document["trailer"], document["Audience"], document["Critic"], document["storyline"], "Comedy", watch, document["ImgURL"]);
                                                                              provider.havewacth(provider.WhereToWatch, watch);
                                                                              Navigator.push(context, MaterialPageRoute(builder: (context) => MovieDetail()));
                                                                            },
                                                                            child:
                                                                                Container(
                                                                              width: 120,
                                                                              decoration: BoxDecoration(
                                                                                  borderRadius: BorderRadius.circular(10),
                                                                                  image: DecorationImage(
                                                                                    image: NetworkImage(
                                                                                      document["ImgURL"],
                                                                                    ),
                                                                                    fit: BoxFit.cover,
                                                                                  )),
                                                                            ),
                                                                          ),
                                                                        );
                                                                      }).toList()),
                                                                ),
                                                                SizedBox(
                                                                  height: 20.0,
                                                                ),
                                                                SizedBox(
                                                                  child: Text(
                                                                    "Drama",
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            24,
                                                                        color: Colors
                                                                            .white),
                                                                  ),
                                                                ),
                                                                Container(
                                                                  height: 190,
                                                                  child: ListView(
                                                                      scrollDirection: Axis.horizontal,
                                                                      children: snapshot4.data!.docs.map((document) {
                                                                        return Padding(
                                                                          padding: const EdgeInsets.only(
                                                                              top: 8.0,
                                                                              right: 15.0),
                                                                          child:
                                                                              InkWell(
                                                                            onTap:
                                                                                () {
                                                                              List<String> watch = List.from(document["watch"]);
                                                                              provider.getDetail(document["name"], document["trailer"], document["Audience"], document["Critic"], document["storyline"], "Drama", watch, document["ImgURL"]);
                                                                              provider.havewacth(provider.WhereToWatch, watch);
                                                                              Navigator.push(context, MaterialPageRoute(builder: (context) => MovieDetail()));
                                                                            },
                                                                            child:
                                                                                Container(
                                                                              width: 120,
                                                                              decoration: BoxDecoration(
                                                                                  borderRadius: BorderRadius.circular(10),
                                                                                  image: DecorationImage(
                                                                                    image: NetworkImage(
                                                                                      document["ImgURL"],
                                                                                    ),
                                                                                    fit: BoxFit.cover,
                                                                                  )),
                                                                            ),
                                                                          ),
                                                                        );
                                                                      }).toList()),
                                                                ),
                                                                SizedBox(
                                                                  height: 20.0,
                                                                ),
                                                                SizedBox(
                                                                  child: Text(
                                                                    "Fantasy",
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            24,
                                                                        color: Colors
                                                                            .white),
                                                                  ),
                                                                ),
                                                                Container(
                                                                  height: 190,
                                                                  child: ListView(
                                                                      scrollDirection: Axis.horizontal,
                                                                      children: snapshot5.data!.docs.map((document) {
                                                                        return Padding(
                                                                          padding: const EdgeInsets.only(
                                                                              top: 8.0,
                                                                              right: 15.0),
                                                                          child:
                                                                              InkWell(
                                                                            onTap:
                                                                                () {
                                                                              List<String> watch = List.from(document["watch"]);
                                                                              provider.getDetail(document["name"], document["trailer"], document["Audience"], document["Critic"], document["storyline"], "Fantasy", watch, document["ImgURL"]);
                                                                              provider.havewacth(provider.WhereToWatch, watch);
                                                                              Navigator.push(context, MaterialPageRoute(builder: (context) => MovieDetail()));
                                                                            },
                                                                            child:
                                                                                Container(
                                                                              width: 120,
                                                                              decoration: BoxDecoration(
                                                                                  borderRadius: BorderRadius.circular(10),
                                                                                  image: DecorationImage(
                                                                                    image: NetworkImage(
                                                                                      document["ImgURL"],
                                                                                    ),
                                                                                    fit: BoxFit.cover,
                                                                                  )),
                                                                            ),
                                                                          ),
                                                                        );
                                                                      }).toList()),
                                                                ),
                                                                SizedBox(
                                                                  height: 20.0,
                                                                ),
                                                                SizedBox(
                                                                  child: Text(
                                                                    "Horror",
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            24,
                                                                        color: Colors
                                                                            .white),
                                                                  ),
                                                                ),
                                                                Container(
                                                                  height: 190,
                                                                  child: ListView(
                                                                      scrollDirection: Axis.horizontal,
                                                                      children: snapshot6.data!.docs.map((document) {
                                                                        return Padding(
                                                                          padding: const EdgeInsets.only(
                                                                              top: 8.0,
                                                                              right: 15.0),
                                                                          child:
                                                                              InkWell(
                                                                            onTap:
                                                                                () {
                                                                              List<String> watch = List.from(document["watch"]);
                                                                              provider.getDetail(document["name"], document["trailer"], document["Audience"], document["Critic"], document["storyline"], "Horror", watch, document["ImgURL"]);
                                                                              provider.havewacth(provider.WhereToWatch, watch);
                                                                              Navigator.push(context, MaterialPageRoute(builder: (context) => MovieDetail()));
                                                                            },
                                                                            child:
                                                                                Container(
                                                                              width: 120,
                                                                              decoration: BoxDecoration(
                                                                                  borderRadius: BorderRadius.circular(10),
                                                                                  image: DecorationImage(
                                                                                    image: NetworkImage(
                                                                                      document["ImgURL"],
                                                                                    ),
                                                                                    fit: BoxFit.cover,
                                                                                  )),
                                                                            ),
                                                                          ),
                                                                        );
                                                                      }).toList()),
                                                                ),
                                                                SizedBox(
                                                                  height: 20.0,
                                                                ),
                                                                SizedBox(
                                                                  child: Text(
                                                                    "Mystery",
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            24,
                                                                        color: Colors
                                                                            .white),
                                                                  ),
                                                                ),
                                                                Container(
                                                                  height: 190,
                                                                  child: ListView(
                                                                      scrollDirection: Axis.horizontal,
                                                                      children: snapshot7.data!.docs.map((document) {
                                                                        return Padding(
                                                                          padding: const EdgeInsets.only(
                                                                              top: 8.0,
                                                                              right: 15.0),
                                                                          child:
                                                                              InkWell(
                                                                            onTap:
                                                                                () {
                                                                              List<String> watch = List.from(document["watch"]);
                                                                              provider.getDetail(document["name"], document["trailer"], document["Audience"], document["Critic"], document["storyline"], "Mystery", watch, document["ImgURL"]);
                                                                              provider.havewacth(provider.WhereToWatch, watch);
                                                                              Navigator.push(context, MaterialPageRoute(builder: (context) => MovieDetail()));
                                                                            },
                                                                            child:
                                                                                Container(
                                                                              width: 120,
                                                                              decoration: BoxDecoration(
                                                                                  borderRadius: BorderRadius.circular(10),
                                                                                  image: DecorationImage(
                                                                                    image: NetworkImage(
                                                                                      document["ImgURL"],
                                                                                    ),
                                                                                    fit: BoxFit.cover,
                                                                                  )),
                                                                            ),
                                                                          ),
                                                                        );
                                                                      }).toList()),
                                                                ),
                                                                SizedBox(
                                                                  height: 20.0,
                                                                ),
                                                                SizedBox(
                                                                  child: Text(
                                                                    "Romance",
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            24,
                                                                        color: Colors
                                                                            .white),
                                                                  ),
                                                                ),
                                                                Container(
                                                                  height: 190,
                                                                  child: ListView(
                                                                      scrollDirection: Axis.horizontal,
                                                                      children: snapshot8.data!.docs.map((document) {
                                                                        return Padding(
                                                                          padding: const EdgeInsets.only(
                                                                              top: 8.0,
                                                                              right: 15.0),
                                                                          child:
                                                                              InkWell(
                                                                            onTap:
                                                                                () {
                                                                              List<String> watch = List.from(document["watch"]);
                                                                              provider.getDetail(document["name"], document["trailer"], document["Audience"], document["Critic"], document["storyline"], "Romance", watch, document["ImgURL"]);
                                                                              provider.havewacth(provider.WhereToWatch, watch);
                                                                              Navigator.push(context, MaterialPageRoute(builder: (context) => MovieDetail()));
                                                                            },
                                                                            child:
                                                                                Container(
                                                                              width: 120,
                                                                              decoration: BoxDecoration(
                                                                                  borderRadius: BorderRadius.circular(10),
                                                                                  image: DecorationImage(
                                                                                    image: NetworkImage(
                                                                                      document["ImgURL"],
                                                                                    ),
                                                                                    fit: BoxFit.cover,
                                                                                  )),
                                                                            ),
                                                                          ),
                                                                        );
                                                                      }).toList()),
                                                                ),
                                                                SizedBox(
                                                                  height: 20.0,
                                                                ),
                                                                SizedBox(
                                                                  child: Text(
                                                                    "Thriller",
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            24,
                                                                        color: Colors
                                                                            .white),
                                                                  ),
                                                                ),
                                                                Container(
                                                                  height: 190,
                                                                  child: ListView(
                                                                      scrollDirection: Axis.horizontal,
                                                                      children: snapshot9.data!.docs.map((document) {
                                                                        return Padding(
                                                                          padding: const EdgeInsets.only(
                                                                              top: 8.0,
                                                                              right: 15.0),
                                                                          child:
                                                                              InkWell(
                                                                            onTap:
                                                                                () {
                                                                              List<String> watch = List.from(document["watch"]);
                                                                              provider.getDetail(document["name"], document["trailer"], document["Audience"], document["Critic"], document["storyline"], "Thriller", watch, document["ImgURL"]);
                                                                              provider.havewacth(provider.WhereToWatch, watch);
                                                                              Navigator.push(context, MaterialPageRoute(builder: (context) => MovieDetail()));
                                                                            },
                                                                            child:
                                                                                Container(
                                                                              width: 120,
                                                                              decoration: BoxDecoration(
                                                                                  borderRadius: BorderRadius.circular(10),
                                                                                  image: DecorationImage(
                                                                                    image: NetworkImage(
                                                                                      document["ImgURL"],
                                                                                    ),
                                                                                    fit: BoxFit.cover,
                                                                                  )),
                                                                            ),
                                                                          ),
                                                                        );
                                                                      }).toList()),
                                                                ),
                                                                SizedBox(
                                                                  height: 20.0,
                                                                ),
                                                              ]),
                                                        ),
                                                      ),
                                                    );
                                                  });
                                            },
                                          );
                                        },
                                      );
                                    },
                                  );
                                },
                              );
                            });
                      },
                    );
                  },
                );
              },
            );
          },
        ));
  }
}
