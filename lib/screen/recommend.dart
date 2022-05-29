// ignore_for_file: prefer_const_constructors, unnecessary_new, prefer_const_literals_to_create_immutables, camel_case_types, use_key_in_widget_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myflutter/providers/navigation_provider.dart';
import 'package:myflutter/screen/movieDetail.dart';
import 'package:provider/provider.dart';

class recScreen extends StatefulWidget {
  @override
  _recScreenState createState() => _recScreenState();
}

class _recScreenState extends State<recScreen> {
  @override
  Widget build(BuildContext context) {
    var provider =
        Provider.of<BottomNavigationBarProvider>(context, listen: false);

    String uid = FirebaseAuth.instance.currentUser!.uid;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        automaticallyImplyLeading: false,
        title: Padding(
          padding: const EdgeInsets.only(left: 5.0),
          child: Text(
            'Recommend',
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
          stream: FirebaseFirestore.instance.collection(uid).snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            List perMovie = snapshot.data?.docs ?? [];
            provider.getRecMovie(perMovie);
            List<String> type = provider.rectype;
            if (!snapshot.hasData) {
              Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.hasError) {
              Center(
                child: CircularProgressIndicator(),
              );
            }
            return StreamBuilder(
              stream:
                  FirebaseFirestore.instance.collection("Action").snapshots(),
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
                      builder:
                          (context, AsyncSnapshot<QuerySnapshot> snapshot3) {
                        return StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection("Drama")
                              .snapshots(),
                          builder: (context,
                              AsyncSnapshot<QuerySnapshot> snapshot4) {
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
                                        AsyncSnapshot<QuerySnapshot>
                                            snapshot6) {
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
                                                stream: FirebaseFirestore
                                                    .instance
                                                    .collection("Thriller")
                                                    .snapshots(),
                                                builder: (context,
                                                    AsyncSnapshot<QuerySnapshot>
                                                        snapshot9) {
                                                  if (!snapshot1.hasData ||
                                                      !snapshot2.hasData ||
                                                      !snapshot3.hasData ||
                                                      !snapshot4.hasData ||
                                                      !snapshot5.hasData ||
                                                      !snapshot6.hasData ||
                                                      !snapshot7.hasData ||
                                                      !snapshot8.hasData ||
                                                      !snapshot9.hasData) {
                                                    return Center(
                                                      child:
                                                          CircularProgressIndicator(),
                                                    );
                                                  }
                                                  print(type.length);

                                                  if (type.length == 1) {
                                                    var gg =
                                                        provider.getsnapshot(
                                                            type[0],
                                                            snapshot1,
                                                            snapshot2,
                                                            snapshot3,
                                                            snapshot4,
                                                            snapshot5,
                                                            snapshot6,
                                                            snapshot7,
                                                            snapshot8,
                                                            snapshot9);
                                                    return Scaffold(
                                                      backgroundColor:
                                                          Colors.black,
                                                      body: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child:
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
                                                                    type[0],
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            24,
                                                                        color: Colors
                                                                            .white),
                                                                  ),
                                                                ),
                                                                Container(
                                                                  height: 200,
                                                                  child: ListView(
                                                                      scrollDirection: Axis.horizontal,
                                                                      children: gg.data!.docs.map((document) {
                                                                        return InkWell(
                                                                          onTap:
                                                                              () {
                                                                            List<String>
                                                                                watch =
                                                                                List.from(document["watch"]);
                                                                            provider.getDetail(
                                                                                document["name"],
                                                                                document["trailer"],
                                                                                document["Audience"],
                                                                                document["Critic"],
                                                                                document["storyline"],
                                                                                type[0],
                                                                                watch,
                                                                                document["ImgURL"]);
                                                                            provider.havewacth(provider.WhereToWatch,
                                                                                watch);
                                                                            Navigator.push(context,
                                                                                MaterialPageRoute(builder: (context) => MovieDetail()));
                                                                          },
                                                                          child:
                                                                              Padding(
                                                                            padding:
                                                                                const EdgeInsets.all(8.0),
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
                                                              ]),
                                                        ),
                                                      ),
                                                    );
                                                  } else if (type.length == 2) {
                                                    var type1 =
                                                        provider.getsnapshot(
                                                            type[0],
                                                            snapshot1,
                                                            snapshot2,
                                                            snapshot3,
                                                            snapshot4,
                                                            snapshot5,
                                                            snapshot6,
                                                            snapshot7,
                                                            snapshot8,
                                                            snapshot9);
                                                    var type2 =
                                                        provider.getsnapshot(
                                                            type[1],
                                                            snapshot1,
                                                            snapshot2,
                                                            snapshot3,
                                                            snapshot4,
                                                            snapshot5,
                                                            snapshot6,
                                                            snapshot7,
                                                            snapshot8,
                                                            snapshot9);
                                                    return Scaffold(
                                                      backgroundColor:
                                                          Colors.black,
                                                      body: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child:
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
                                                                    type[0],
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            24,
                                                                        color: Colors
                                                                            .white),
                                                                  ),
                                                                ),
                                                                Container(
                                                                  height: 200,
                                                                  child: ListView(
                                                                      scrollDirection: Axis.horizontal,
                                                                      children: type1.data!.docs.map((document) {
                                                                        return InkWell(
                                                                          onTap:
                                                                              () {
                                                                            List<String>
                                                                                watch =
                                                                                List.from(document["watch"]);
                                                                            provider.getDetail(
                                                                                document["name"],
                                                                                document["trailer"],
                                                                                document["Audience"],
                                                                                document["Critic"],
                                                                                document["storyline"],
                                                                                type[0],
                                                                                watch,
                                                                                document["ImgURL"]);
                                                                            provider.havewacth(provider.WhereToWatch,
                                                                                watch);
                                                                            Navigator.push(context,
                                                                                MaterialPageRoute(builder: (context) => MovieDetail()));
                                                                          },
                                                                          child:
                                                                              Padding(
                                                                            padding:
                                                                                const EdgeInsets.all(8.0),
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
                                                                  child: Text(
                                                                    type[1],
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            24,
                                                                        color: Colors
                                                                            .white),
                                                                  ),
                                                                ),
                                                                Container(
                                                                  height: 200,
                                                                  child: ListView(
                                                                      scrollDirection: Axis.horizontal,
                                                                      children: type2.data!.docs.map((document) {
                                                                        return InkWell(
                                                                          onTap:
                                                                              () {
                                                                            List<String>
                                                                                watch =
                                                                                List.from(document["watch"]);
                                                                            provider.getDetail(
                                                                                document["name"],
                                                                                document["trailer"],
                                                                                document["Audience"],
                                                                                document["Critic"],
                                                                                document["storyline"],
                                                                                type[1],
                                                                                watch,
                                                                                document["ImgURL"]);
                                                                            provider.havewacth(provider.WhereToWatch,
                                                                                watch);
                                                                            Navigator.push(context,
                                                                                MaterialPageRoute(builder: (context) => MovieDetail()));
                                                                          },
                                                                          child:
                                                                              Padding(
                                                                            padding:
                                                                                const EdgeInsets.all(8.0),
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
                                                              ]),
                                                        ),
                                                      ),
                                                    );
                                                  } else if (type.length == 3) {
                                                    var type0 =
                                                        provider.getsnapshot(
                                                            type[0],
                                                            snapshot1,
                                                            snapshot2,
                                                            snapshot3,
                                                            snapshot4,
                                                            snapshot5,
                                                            snapshot6,
                                                            snapshot7,
                                                            snapshot8,
                                                            snapshot9);
                                                    var type1 =
                                                        provider.getsnapshot(
                                                            type[1],
                                                            snapshot1,
                                                            snapshot2,
                                                            snapshot3,
                                                            snapshot4,
                                                            snapshot5,
                                                            snapshot6,
                                                            snapshot7,
                                                            snapshot8,
                                                            snapshot9);
                                                    var type2 =
                                                        provider.getsnapshot(
                                                            type[2],
                                                            snapshot1,
                                                            snapshot2,
                                                            snapshot3,
                                                            snapshot4,
                                                            snapshot5,
                                                            snapshot6,
                                                            snapshot7,
                                                            snapshot8,
                                                            snapshot9);
                                                    return Scaffold(
                                                      backgroundColor:
                                                          Colors.black,
                                                      body: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child:
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
                                                                    type[0],
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            24,
                                                                        color: Colors
                                                                            .white),
                                                                  ),
                                                                ),
                                                                Container(
                                                                  height: 200,
                                                                  child: ListView(
                                                                      scrollDirection: Axis.horizontal,
                                                                      children: type0.data!.docs.map((document) {
                                                                        return InkWell(
                                                                          onTap:
                                                                              () {
                                                                            List<String>
                                                                                watch =
                                                                                List.from(document["watch"]);
                                                                            provider.getDetail(
                                                                                document["name"],
                                                                                document["trailer"],
                                                                                document["Audience"],
                                                                                document["Critic"],
                                                                                document["storyline"],
                                                                                type[0],
                                                                                watch,
                                                                                document["ImgURL"]);
                                                                            provider.havewacth(provider.WhereToWatch,
                                                                                watch);
                                                                            Navigator.push(context,
                                                                                MaterialPageRoute(builder: (context) => MovieDetail()));
                                                                          },
                                                                          child:
                                                                              Padding(
                                                                            padding:
                                                                                const EdgeInsets.all(8.0),
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
                                                                  child: Text(
                                                                    type[1],
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            24,
                                                                        color: Colors
                                                                            .white),
                                                                  ),
                                                                ),
                                                                Container(
                                                                  height: 200,
                                                                  child: ListView(
                                                                      scrollDirection: Axis.horizontal,
                                                                      children: type1.data!.docs.map((document) {
                                                                        return InkWell(
                                                                          onTap:
                                                                              () {
                                                                            List<String>
                                                                                watch =
                                                                                List.from(document["watch"]);
                                                                            provider.getDetail(
                                                                                document["name"],
                                                                                document["trailer"],
                                                                                document["Audience"],
                                                                                document["Critic"],
                                                                                document["storyline"],
                                                                                type[1],
                                                                                watch,
                                                                                document["ImgURL"]);
                                                                            provider.havewacth(provider.WhereToWatch,
                                                                                watch);
                                                                            Navigator.push(context,
                                                                                MaterialPageRoute(builder: (context) => MovieDetail()));
                                                                          },
                                                                          child:
                                                                              Padding(
                                                                            padding:
                                                                                const EdgeInsets.all(8.0),
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
                                                                  child: Text(
                                                                    type[2],
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            24,
                                                                        color: Colors
                                                                            .white),
                                                                  ),
                                                                ),
                                                                Container(
                                                                  height: 200,
                                                                  child: ListView(
                                                                      scrollDirection: Axis.horizontal,
                                                                      children: type2.data!.docs.map((document) {
                                                                        return InkWell(
                                                                          onTap:
                                                                              () {
                                                                            List<String>
                                                                                watch =
                                                                                List.from(document["watch"]);
                                                                            provider.getDetail(
                                                                                document["name"],
                                                                                document["trailer"],
                                                                                document["Audience"],
                                                                                document["Critic"],
                                                                                document["storyline"],
                                                                                type[2],
                                                                                watch,
                                                                                document["ImgURL"]);
                                                                            provider.havewacth(provider.WhereToWatch,
                                                                                watch);
                                                                            Navigator.push(context,
                                                                                MaterialPageRoute(builder: (context) => MovieDetail()));
                                                                          },
                                                                          child:
                                                                              Padding(
                                                                            padding:
                                                                                const EdgeInsets.all(8.0),
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
                                                              ]),
                                                        ),
                                                      ),
                                                    );
                                                  } else if (type.length == 4) {
                                                    var type0 =
                                                        provider.getsnapshot(
                                                            type[0],
                                                            snapshot1,
                                                            snapshot2,
                                                            snapshot3,
                                                            snapshot4,
                                                            snapshot5,
                                                            snapshot6,
                                                            snapshot7,
                                                            snapshot8,
                                                            snapshot9);
                                                    var type1 =
                                                        provider.getsnapshot(
                                                            type[1],
                                                            snapshot1,
                                                            snapshot2,
                                                            snapshot3,
                                                            snapshot4,
                                                            snapshot5,
                                                            snapshot6,
                                                            snapshot7,
                                                            snapshot8,
                                                            snapshot9);
                                                    var type2 =
                                                        provider.getsnapshot(
                                                            type[2],
                                                            snapshot1,
                                                            snapshot2,
                                                            snapshot3,
                                                            snapshot4,
                                                            snapshot5,
                                                            snapshot6,
                                                            snapshot7,
                                                            snapshot8,
                                                            snapshot9);
                                                    var type3 =
                                                        provider.getsnapshot(
                                                            type[3],
                                                            snapshot1,
                                                            snapshot2,
                                                            snapshot3,
                                                            snapshot4,
                                                            snapshot5,
                                                            snapshot6,
                                                            snapshot7,
                                                            snapshot8,
                                                            snapshot9);
                                                    return Scaffold(
                                                      backgroundColor:
                                                          Colors.black,
                                                      body: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child:
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
                                                                    type[0],
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            24,
                                                                        color: Colors
                                                                            .white),
                                                                  ),
                                                                ),
                                                                Container(
                                                                  height: 200,
                                                                  child: ListView(
                                                                      scrollDirection: Axis.horizontal,
                                                                      children: type0.data!.docs.map((document) {
                                                                        return InkWell(
                                                                          onTap:
                                                                              () {
                                                                            List<String>
                                                                                watch =
                                                                                List.from(document["watch"]);
                                                                            provider.getDetail(
                                                                                document["name"],
                                                                                document["trailer"],
                                                                                document["Audience"],
                                                                                document["Critic"],
                                                                                document["storyline"],
                                                                                type[0],
                                                                                watch,
                                                                                document["ImgURL"]);
                                                                            provider.havewacth(provider.WhereToWatch,
                                                                                watch);
                                                                            Navigator.push(context,
                                                                                MaterialPageRoute(builder: (context) => MovieDetail()));
                                                                          },
                                                                          child:
                                                                              Padding(
                                                                            padding:
                                                                                const EdgeInsets.all(8.0),
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
                                                                  child: Text(
                                                                    type[1],
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            24,
                                                                        color: Colors
                                                                            .white),
                                                                  ),
                                                                ),
                                                                Container(
                                                                  height: 200,
                                                                  child: ListView(
                                                                      scrollDirection: Axis.horizontal,
                                                                      children: type1.data!.docs.map((document) {
                                                                        return InkWell(
                                                                          onTap:
                                                                              () {
                                                                            List<String>
                                                                                watch =
                                                                                List.from(document["watch"]);
                                                                            provider.getDetail(
                                                                                document["name"],
                                                                                document["trailer"],
                                                                                document["Audience"],
                                                                                document["Critic"],
                                                                                document["storyline"],
                                                                                type[1],
                                                                                watch,
                                                                                document["ImgURL"]);
                                                                            provider.havewacth(provider.WhereToWatch,
                                                                                watch);
                                                                            Navigator.push(context,
                                                                                MaterialPageRoute(builder: (context) => MovieDetail()));
                                                                          },
                                                                          child:
                                                                              Padding(
                                                                            padding:
                                                                                const EdgeInsets.all(8.0),
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
                                                                  child: Text(
                                                                    type[2],
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            24,
                                                                        color: Colors
                                                                            .white),
                                                                  ),
                                                                ),
                                                                Container(
                                                                  height: 200,
                                                                  child: ListView(
                                                                      scrollDirection: Axis.horizontal,
                                                                      children: type2.data!.docs.map((document) {
                                                                        return InkWell(
                                                                          onTap:
                                                                              () {
                                                                            List<String>
                                                                                watch =
                                                                                List.from(document["watch"]);
                                                                            provider.getDetail(
                                                                                document["name"],
                                                                                document["trailer"],
                                                                                document["Audience"],
                                                                                document["Critic"],
                                                                                document["storyline"],
                                                                                type[2],
                                                                                watch,
                                                                                document["ImgURL"]);
                                                                            provider.havewacth(provider.WhereToWatch,
                                                                                watch);
                                                                            Navigator.push(context,
                                                                                MaterialPageRoute(builder: (context) => MovieDetail()));
                                                                          },
                                                                          child:
                                                                              Padding(
                                                                            padding:
                                                                                const EdgeInsets.all(8.0),
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
                                                                  child: Text(
                                                                    type[3],
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            24,
                                                                        color: Colors
                                                                            .white),
                                                                  ),
                                                                ),
                                                                Container(
                                                                  height: 200,
                                                                  child: ListView(
                                                                      scrollDirection: Axis.horizontal,
                                                                      children: type3.data!.docs.map((document) {
                                                                        return InkWell(
                                                                          onTap:
                                                                              () {
                                                                            List<String>
                                                                                watch =
                                                                                List.from(document["watch"]);
                                                                            provider.getDetail(
                                                                                document["name"],
                                                                                document["trailer"],
                                                                                document["Audience"],
                                                                                document["Critic"],
                                                                                document["storyline"],
                                                                                type[3],
                                                                                watch,
                                                                                document["ImgURL"]);
                                                                            provider.havewacth(provider.WhereToWatch,
                                                                                watch);
                                                                            Navigator.push(context,
                                                                                MaterialPageRoute(builder: (context) => MovieDetail()));
                                                                          },
                                                                          child:
                                                                              Padding(
                                                                            padding:
                                                                                const EdgeInsets.all(8.0),
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
                                                              ]),
                                                        ),
                                                      ),
                                                    );
                                                  } else if (type.length == 5) {
                                                    var type0 =
                                                        provider.getsnapshot(
                                                            type[0],
                                                            snapshot1,
                                                            snapshot2,
                                                            snapshot3,
                                                            snapshot4,
                                                            snapshot5,
                                                            snapshot6,
                                                            snapshot7,
                                                            snapshot8,
                                                            snapshot9);
                                                    var type1 =
                                                        provider.getsnapshot(
                                                            type[1],
                                                            snapshot1,
                                                            snapshot2,
                                                            snapshot3,
                                                            snapshot4,
                                                            snapshot5,
                                                            snapshot6,
                                                            snapshot7,
                                                            snapshot8,
                                                            snapshot9);
                                                    var type2 =
                                                        provider.getsnapshot(
                                                            type[2],
                                                            snapshot1,
                                                            snapshot2,
                                                            snapshot3,
                                                            snapshot4,
                                                            snapshot5,
                                                            snapshot6,
                                                            snapshot7,
                                                            snapshot8,
                                                            snapshot9);
                                                    var type3 =
                                                        provider.getsnapshot(
                                                            type[3],
                                                            snapshot1,
                                                            snapshot2,
                                                            snapshot3,
                                                            snapshot4,
                                                            snapshot5,
                                                            snapshot6,
                                                            snapshot7,
                                                            snapshot8,
                                                            snapshot9);
                                                    var type4 =
                                                        provider.getsnapshot(
                                                            type[4],
                                                            snapshot1,
                                                            snapshot2,
                                                            snapshot3,
                                                            snapshot4,
                                                            snapshot5,
                                                            snapshot6,
                                                            snapshot7,
                                                            snapshot8,
                                                            snapshot9);
                                                    return Scaffold(
                                                      backgroundColor:
                                                          Colors.black,
                                                      body: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child:
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
                                                                    type[0],
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            24,
                                                                        color: Colors
                                                                            .white),
                                                                  ),
                                                                ),
                                                                Container(
                                                                  height: 200,
                                                                  child: ListView(
                                                                      scrollDirection: Axis.horizontal,
                                                                      children: type0.data!.docs.map((document) {
                                                                        return InkWell(
                                                                          onTap:
                                                                              () {
                                                                            List<String>
                                                                                watch =
                                                                                List.from(document["watch"]);
                                                                            provider.getDetail(
                                                                                document["name"],
                                                                                document["trailer"],
                                                                                document["Audience"],
                                                                                document["Critic"],
                                                                                document["storyline"],
                                                                                type[0],
                                                                                watch,
                                                                                document["ImgURL"]);
                                                                            provider.havewacth(provider.WhereToWatch,
                                                                                watch);
                                                                            Navigator.push(context,
                                                                                MaterialPageRoute(builder: (context) => MovieDetail()));
                                                                          },
                                                                          child:
                                                                              Padding(
                                                                            padding:
                                                                                const EdgeInsets.all(8.0),
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
                                                                  child: Text(
                                                                    type[1],
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            24,
                                                                        color: Colors
                                                                            .white),
                                                                  ),
                                                                ),
                                                                Container(
                                                                  height: 200,
                                                                  child: ListView(
                                                                      scrollDirection: Axis.horizontal,
                                                                      children: type1.data!.docs.map((document) {
                                                                        return InkWell(
                                                                          onTap:
                                                                              () {
                                                                            List<String>
                                                                                watch =
                                                                                List.from(document["watch"]);
                                                                            provider.getDetail(
                                                                                document["name"],
                                                                                document["trailer"],
                                                                                document["Audience"],
                                                                                document["Critic"],
                                                                                document["storyline"],
                                                                                type[1],
                                                                                watch,
                                                                                document["ImgURL"]);
                                                                            provider.havewacth(provider.WhereToWatch,
                                                                                watch);
                                                                            Navigator.push(context,
                                                                                MaterialPageRoute(builder: (context) => MovieDetail()));
                                                                          },
                                                                          child:
                                                                              Padding(
                                                                            padding:
                                                                                const EdgeInsets.all(8.0),
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
                                                                  child: Text(
                                                                    type[2],
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            24,
                                                                        color: Colors
                                                                            .white),
                                                                  ),
                                                                ),
                                                                Container(
                                                                  height: 200,
                                                                  child: ListView(
                                                                      scrollDirection: Axis.horizontal,
                                                                      children: type2.data!.docs.map((document) {
                                                                        return InkWell(
                                                                          onTap:
                                                                              () {
                                                                            List<String>
                                                                                watch =
                                                                                List.from(document["watch"]);
                                                                            provider.getDetail(
                                                                                document["name"],
                                                                                document["trailer"],
                                                                                document["Audience"],
                                                                                document["Critic"],
                                                                                document["storyline"],
                                                                                type[2],
                                                                                watch,
                                                                                document["ImgURL"]);
                                                                            provider.havewacth(provider.WhereToWatch,
                                                                                watch);
                                                                            Navigator.push(context,
                                                                                MaterialPageRoute(builder: (context) => MovieDetail()));
                                                                          },
                                                                          child:
                                                                              Padding(
                                                                            padding:
                                                                                const EdgeInsets.all(8.0),
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
                                                                  child: Text(
                                                                    type[3],
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            24,
                                                                        color: Colors
                                                                            .white),
                                                                  ),
                                                                ),
                                                                Container(
                                                                  height: 200,
                                                                  child: ListView(
                                                                      scrollDirection: Axis.horizontal,
                                                                      children: type3.data!.docs.map((document) {
                                                                        return InkWell(
                                                                          onTap:
                                                                              () {
                                                                            List<String>
                                                                                watch =
                                                                                List.from(document["watch"]);
                                                                            provider.getDetail(
                                                                                document["name"],
                                                                                document["trailer"],
                                                                                document["Audience"],
                                                                                document["Critic"],
                                                                                document["storyline"],
                                                                                type[3],
                                                                                watch,
                                                                                document["ImgURL"]);
                                                                            provider.havewacth(provider.WhereToWatch,
                                                                                watch);
                                                                            Navigator.push(context,
                                                                                MaterialPageRoute(builder: (context) => MovieDetail()));
                                                                          },
                                                                          child:
                                                                              Padding(
                                                                            padding:
                                                                                const EdgeInsets.all(8.0),
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
                                                                  child: Text(
                                                                    type[4],
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            24,
                                                                        color: Colors
                                                                            .white),
                                                                  ),
                                                                ),
                                                                Container(
                                                                  height: 200,
                                                                  child: ListView(
                                                                      scrollDirection: Axis.horizontal,
                                                                      children: type4.data!.docs.map((document) {
                                                                        return InkWell(
                                                                          onTap:
                                                                              () {
                                                                            List<String>
                                                                                watch =
                                                                                List.from(document["watch"]);
                                                                            provider.getDetail(
                                                                                document["name"],
                                                                                document["trailer"],
                                                                                document["Audience"],
                                                                                document["Critic"],
                                                                                document["storyline"],
                                                                                type[4],
                                                                                watch,
                                                                                document["ImgURL"]);
                                                                            provider.havewacth(provider.WhereToWatch,
                                                                                watch);
                                                                            Navigator.push(context,
                                                                                MaterialPageRoute(builder: (context) => MovieDetail()));
                                                                          },
                                                                          child:
                                                                              Padding(
                                                                            padding:
                                                                                const EdgeInsets.all(8.0),
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
                                                              ]),
                                                        ),
                                                      ),
                                                    );
                                                  } else if (type.length == 6) {
                                                    var type0 =
                                                        provider.getsnapshot(
                                                            type[0],
                                                            snapshot1,
                                                            snapshot2,
                                                            snapshot3,
                                                            snapshot4,
                                                            snapshot5,
                                                            snapshot6,
                                                            snapshot7,
                                                            snapshot8,
                                                            snapshot9);
                                                    var type1 =
                                                        provider.getsnapshot(
                                                            type[1],
                                                            snapshot1,
                                                            snapshot2,
                                                            snapshot3,
                                                            snapshot4,
                                                            snapshot5,
                                                            snapshot6,
                                                            snapshot7,
                                                            snapshot8,
                                                            snapshot9);
                                                    var type2 =
                                                        provider.getsnapshot(
                                                            type[2],
                                                            snapshot1,
                                                            snapshot2,
                                                            snapshot3,
                                                            snapshot4,
                                                            snapshot5,
                                                            snapshot6,
                                                            snapshot7,
                                                            snapshot8,
                                                            snapshot9);
                                                    var type3 =
                                                        provider.getsnapshot(
                                                            type[3],
                                                            snapshot1,
                                                            snapshot2,
                                                            snapshot3,
                                                            snapshot4,
                                                            snapshot5,
                                                            snapshot6,
                                                            snapshot7,
                                                            snapshot8,
                                                            snapshot9);
                                                    var type4 =
                                                        provider.getsnapshot(
                                                            type[4],
                                                            snapshot1,
                                                            snapshot2,
                                                            snapshot3,
                                                            snapshot4,
                                                            snapshot5,
                                                            snapshot6,
                                                            snapshot7,
                                                            snapshot8,
                                                            snapshot9);
                                                    var type5 =
                                                        provider.getsnapshot(
                                                            type[5],
                                                            snapshot1,
                                                            snapshot2,
                                                            snapshot3,
                                                            snapshot4,
                                                            snapshot5,
                                                            snapshot6,
                                                            snapshot7,
                                                            snapshot8,
                                                            snapshot9);
                                                    return Scaffold(
                                                      backgroundColor:
                                                          Colors.black,
                                                      body: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child:
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
                                                                    type[0],
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            24,
                                                                        color: Colors
                                                                            .white),
                                                                  ),
                                                                ),
                                                                Container(
                                                                  height: 200,
                                                                  child: ListView(
                                                                      scrollDirection: Axis.horizontal,
                                                                      children: type0.data!.docs.map((document) {
                                                                        return InkWell(
                                                                          onTap:
                                                                              () {
                                                                            List<String>
                                                                                watch =
                                                                                List.from(document["watch"]);
                                                                            provider.getDetail(
                                                                                document["name"],
                                                                                document["trailer"],
                                                                                document["Audience"],
                                                                                document["Critic"],
                                                                                document["storyline"],
                                                                                type[0],
                                                                                watch,
                                                                                document["ImgURL"]);
                                                                            provider.havewacth(provider.WhereToWatch,
                                                                                watch);
                                                                            Navigator.push(context,
                                                                                MaterialPageRoute(builder: (context) => MovieDetail()));
                                                                          },
                                                                          child:
                                                                              Padding(
                                                                            padding:
                                                                                const EdgeInsets.all(8.0),
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
                                                                  child: Text(
                                                                    type[1],
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            24,
                                                                        color: Colors
                                                                            .white),
                                                                  ),
                                                                ),
                                                                Container(
                                                                  height: 200,
                                                                  child: ListView(
                                                                      scrollDirection: Axis.horizontal,
                                                                      children: type1.data!.docs.map((document) {
                                                                        return InkWell(
                                                                          onTap:
                                                                              () {
                                                                            List<String>
                                                                                watch =
                                                                                List.from(document["watch"]);
                                                                            provider.getDetail(
                                                                                document["name"],
                                                                                document["trailer"],
                                                                                document["Audience"],
                                                                                document["Critic"],
                                                                                document["storyline"],
                                                                                type[1],
                                                                                watch,
                                                                                document["ImgURL"]);
                                                                            provider.havewacth(provider.WhereToWatch,
                                                                                watch);
                                                                            Navigator.push(context,
                                                                                MaterialPageRoute(builder: (context) => MovieDetail()));
                                                                          },
                                                                          child:
                                                                              Padding(
                                                                            padding:
                                                                                const EdgeInsets.all(8.0),
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
                                                                  child: Text(
                                                                    type[2],
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            24,
                                                                        color: Colors
                                                                            .white),
                                                                  ),
                                                                ),
                                                                Container(
                                                                  height: 200,
                                                                  child: ListView(
                                                                      scrollDirection: Axis.horizontal,
                                                                      children: type2.data!.docs.map((document) {
                                                                        return InkWell(
                                                                          onTap:
                                                                              () {
                                                                            List<String>
                                                                                watch =
                                                                                List.from(document["watch"]);
                                                                            provider.getDetail(
                                                                                document["name"],
                                                                                document["trailer"],
                                                                                document["Audience"],
                                                                                document["Critic"],
                                                                                document["storyline"],
                                                                                type[2],
                                                                                watch,
                                                                                document["ImgURL"]);
                                                                            provider.havewacth(provider.WhereToWatch,
                                                                                watch);
                                                                            Navigator.push(context,
                                                                                MaterialPageRoute(builder: (context) => MovieDetail()));
                                                                          },
                                                                          child:
                                                                              Padding(
                                                                            padding:
                                                                                const EdgeInsets.all(8.0),
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
                                                                  child: Text(
                                                                    type[3],
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            24,
                                                                        color: Colors
                                                                            .white),
                                                                  ),
                                                                ),
                                                                Container(
                                                                  height: 200,
                                                                  child: ListView(
                                                                      scrollDirection: Axis.horizontal,
                                                                      children: type3.data!.docs.map((document) {
                                                                        return InkWell(
                                                                          onTap:
                                                                              () {
                                                                            List<String>
                                                                                watch =
                                                                                List.from(document["watch"]);
                                                                            provider.getDetail(
                                                                                document["name"],
                                                                                document["trailer"],
                                                                                document["Audience"],
                                                                                document["Critic"],
                                                                                document["storyline"],
                                                                                type[3],
                                                                                watch,
                                                                                document["ImgURL"]);
                                                                            provider.havewacth(provider.WhereToWatch,
                                                                                watch);
                                                                            Navigator.push(context,
                                                                                MaterialPageRoute(builder: (context) => MovieDetail()));
                                                                          },
                                                                          child:
                                                                              Padding(
                                                                            padding:
                                                                                const EdgeInsets.all(8.0),
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
                                                                  child: Text(
                                                                    type[4],
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            24,
                                                                        color: Colors
                                                                            .white),
                                                                  ),
                                                                ),
                                                                Container(
                                                                  height: 200,
                                                                  child: ListView(
                                                                      scrollDirection: Axis.horizontal,
                                                                      children: type4.data!.docs.map((document) {
                                                                        return InkWell(
                                                                          onTap:
                                                                              () {
                                                                            List<String>
                                                                                watch =
                                                                                List.from(document["watch"]);
                                                                            provider.getDetail(
                                                                                document["name"],
                                                                                document["trailer"],
                                                                                document["Audience"],
                                                                                document["Critic"],
                                                                                document["storyline"],
                                                                                type[4],
                                                                                watch,
                                                                                document["ImgURL"]);
                                                                            provider.havewacth(provider.WhereToWatch,
                                                                                watch);
                                                                            Navigator.push(context,
                                                                                MaterialPageRoute(builder: (context) => MovieDetail()));
                                                                          },
                                                                          child:
                                                                              Padding(
                                                                            padding:
                                                                                const EdgeInsets.all(8.0),
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
                                                                  child: Text(
                                                                    type[5],
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            24,
                                                                        color: Colors
                                                                            .white),
                                                                  ),
                                                                ),
                                                                Container(
                                                                  height: 200,
                                                                  child: ListView(
                                                                      scrollDirection: Axis.horizontal,
                                                                      children: type5.data!.docs.map((document) {
                                                                        return InkWell(
                                                                          onTap:
                                                                              () {
                                                                            List<String>
                                                                                watch =
                                                                                List.from(document["watch"]);
                                                                            provider.getDetail(
                                                                                document["name"],
                                                                                document["trailer"],
                                                                                document["Audience"],
                                                                                document["Critic"],
                                                                                document["storyline"],
                                                                                type[5],
                                                                                watch,
                                                                                document["ImgURL"]);
                                                                            provider.havewacth(provider.WhereToWatch,
                                                                                watch);
                                                                            Navigator.push(context,
                                                                                MaterialPageRoute(builder: (context) => MovieDetail()));
                                                                          },
                                                                          child:
                                                                              Padding(
                                                                            padding:
                                                                                const EdgeInsets.all(8.0),
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
                                                              ]),
                                                        ),
                                                      ),
                                                    );
                                                  } else if (type.length == 7) {
                                                    var type0 =
                                                        provider.getsnapshot(
                                                            type[0],
                                                            snapshot1,
                                                            snapshot2,
                                                            snapshot3,
                                                            snapshot4,
                                                            snapshot5,
                                                            snapshot6,
                                                            snapshot7,
                                                            snapshot8,
                                                            snapshot9);
                                                    var type1 =
                                                        provider.getsnapshot(
                                                            type[1],
                                                            snapshot1,
                                                            snapshot2,
                                                            snapshot3,
                                                            snapshot4,
                                                            snapshot5,
                                                            snapshot6,
                                                            snapshot7,
                                                            snapshot8,
                                                            snapshot9);
                                                    var type2 =
                                                        provider.getsnapshot(
                                                            type[2],
                                                            snapshot1,
                                                            snapshot2,
                                                            snapshot3,
                                                            snapshot4,
                                                            snapshot5,
                                                            snapshot6,
                                                            snapshot7,
                                                            snapshot8,
                                                            snapshot9);
                                                    var type3 =
                                                        provider.getsnapshot(
                                                            type[3],
                                                            snapshot1,
                                                            snapshot2,
                                                            snapshot3,
                                                            snapshot4,
                                                            snapshot5,
                                                            snapshot6,
                                                            snapshot7,
                                                            snapshot8,
                                                            snapshot9);
                                                    var type4 =
                                                        provider.getsnapshot(
                                                            type[4],
                                                            snapshot1,
                                                            snapshot2,
                                                            snapshot3,
                                                            snapshot4,
                                                            snapshot5,
                                                            snapshot6,
                                                            snapshot7,
                                                            snapshot8,
                                                            snapshot9);
                                                    var type5 =
                                                        provider.getsnapshot(
                                                            type[5],
                                                            snapshot1,
                                                            snapshot2,
                                                            snapshot3,
                                                            snapshot4,
                                                            snapshot5,
                                                            snapshot6,
                                                            snapshot7,
                                                            snapshot8,
                                                            snapshot9);
                                                    var type6 =
                                                        provider.getsnapshot(
                                                            type[6],
                                                            snapshot1,
                                                            snapshot2,
                                                            snapshot3,
                                                            snapshot4,
                                                            snapshot5,
                                                            snapshot6,
                                                            snapshot7,
                                                            snapshot8,
                                                            snapshot9);
                                                    return Scaffold(
                                                      backgroundColor:
                                                          Colors.black,
                                                      body: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child:
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
                                                                    type[0],
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            24,
                                                                        color: Colors
                                                                            .white),
                                                                  ),
                                                                ),
                                                                Container(
                                                                  height: 200,
                                                                  child: ListView(
                                                                      scrollDirection: Axis.horizontal,
                                                                      children: type0.data!.docs.map((document) {
                                                                        return InkWell(
                                                                          onTap:
                                                                              () {
                                                                            List<String>
                                                                                watch =
                                                                                List.from(document["watch"]);
                                                                            provider.getDetail(
                                                                                document["name"],
                                                                                document["trailer"],
                                                                                document["Audience"],
                                                                                document["Critic"],
                                                                                document["storyline"],
                                                                                type[0],
                                                                                watch,
                                                                                document["ImgURL"]);
                                                                            provider.havewacth(provider.WhereToWatch,
                                                                                watch);
                                                                            Navigator.push(context,
                                                                                MaterialPageRoute(builder: (context) => MovieDetail()));
                                                                          },
                                                                          child:
                                                                              Padding(
                                                                            padding:
                                                                                const EdgeInsets.all(8.0),
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
                                                                  child: Text(
                                                                    type[1],
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            24,
                                                                        color: Colors
                                                                            .white),
                                                                  ),
                                                                ),
                                                                Container(
                                                                  height: 200,
                                                                  child: ListView(
                                                                      scrollDirection: Axis.horizontal,
                                                                      children: type1.data!.docs.map((document) {
                                                                        return InkWell(
                                                                          onTap:
                                                                              () {
                                                                            List<String>
                                                                                watch =
                                                                                List.from(document["watch"]);
                                                                            provider.getDetail(
                                                                                document["name"],
                                                                                document["trailer"],
                                                                                document["Audience"],
                                                                                document["Critic"],
                                                                                document["storyline"],
                                                                                type[1],
                                                                                watch,
                                                                                document["ImgURL"]);
                                                                            provider.havewacth(provider.WhereToWatch,
                                                                                watch);
                                                                            Navigator.push(context,
                                                                                MaterialPageRoute(builder: (context) => MovieDetail()));
                                                                          },
                                                                          child:
                                                                              Padding(
                                                                            padding:
                                                                                const EdgeInsets.all(8.0),
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
                                                                  child: Text(
                                                                    type[2],
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            24,
                                                                        color: Colors
                                                                            .white),
                                                                  ),
                                                                ),
                                                                Container(
                                                                  height: 200,
                                                                  child: ListView(
                                                                      scrollDirection: Axis.horizontal,
                                                                      children: type2.data!.docs.map((document) {
                                                                        return InkWell(
                                                                          onTap:
                                                                              () {
                                                                            List<String>
                                                                                watch =
                                                                                List.from(document["watch"]);
                                                                            provider.getDetail(
                                                                                document["name"],
                                                                                document["trailer"],
                                                                                document["Audience"],
                                                                                document["Critic"],
                                                                                document["storyline"],
                                                                                type[2],
                                                                                watch,
                                                                                document["ImgURL"]);
                                                                            provider.havewacth(provider.WhereToWatch,
                                                                                watch);
                                                                            Navigator.push(context,
                                                                                MaterialPageRoute(builder: (context) => MovieDetail()));
                                                                          },
                                                                          child:
                                                                              Padding(
                                                                            padding:
                                                                                const EdgeInsets.all(8.0),
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
                                                                  child: Text(
                                                                    type[3],
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            24,
                                                                        color: Colors
                                                                            .white),
                                                                  ),
                                                                ),
                                                                Container(
                                                                  height: 200,
                                                                  child: ListView(
                                                                      scrollDirection: Axis.horizontal,
                                                                      children: type3.data!.docs.map((document) {
                                                                        return InkWell(
                                                                          onTap:
                                                                              () {
                                                                            List<String>
                                                                                watch =
                                                                                List.from(document["watch"]);
                                                                            provider.getDetail(
                                                                                document["name"],
                                                                                document["trailer"],
                                                                                document["Audience"],
                                                                                document["Critic"],
                                                                                document["storyline"],
                                                                                type[3],
                                                                                watch,
                                                                                document["ImgURL"]);
                                                                            provider.havewacth(provider.WhereToWatch,
                                                                                watch);
                                                                            Navigator.push(context,
                                                                                MaterialPageRoute(builder: (context) => MovieDetail()));
                                                                          },
                                                                          child:
                                                                              Padding(
                                                                            padding:
                                                                                const EdgeInsets.all(8.0),
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
                                                                  child: Text(
                                                                    type[4],
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            24,
                                                                        color: Colors
                                                                            .white),
                                                                  ),
                                                                ),
                                                                Container(
                                                                  height: 200,
                                                                  child: ListView(
                                                                      scrollDirection: Axis.horizontal,
                                                                      children: type4.data!.docs.map((document) {
                                                                        return InkWell(
                                                                          onTap:
                                                                              () {
                                                                            List<String>
                                                                                watch =
                                                                                List.from(document["watch"]);
                                                                            provider.getDetail(
                                                                                document["name"],
                                                                                document["trailer"],
                                                                                document["Audience"],
                                                                                document["Critic"],
                                                                                document["storyline"],
                                                                                type[4],
                                                                                watch,
                                                                                document["ImgURL"]);
                                                                            provider.havewacth(provider.WhereToWatch,
                                                                                watch);
                                                                            Navigator.push(context,
                                                                                MaterialPageRoute(builder: (context) => MovieDetail()));
                                                                          },
                                                                          child:
                                                                              Padding(
                                                                            padding:
                                                                                const EdgeInsets.all(8.0),
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
                                                                  child: Text(
                                                                    type[5],
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            24,
                                                                        color: Colors
                                                                            .white),
                                                                  ),
                                                                ),
                                                                Container(
                                                                  height: 200,
                                                                  child: ListView(
                                                                      scrollDirection: Axis.horizontal,
                                                                      children: type5.data!.docs.map((document) {
                                                                        return InkWell(
                                                                          onTap:
                                                                              () {
                                                                            List<String>
                                                                                watch =
                                                                                List.from(document["watch"]);
                                                                            provider.getDetail(
                                                                                document["name"],
                                                                                document["trailer"],
                                                                                document["Audience"],
                                                                                document["Critic"],
                                                                                document["storyline"],
                                                                                type[5],
                                                                                watch,
                                                                                document["ImgURL"]);
                                                                            provider.havewacth(provider.WhereToWatch,
                                                                                watch);
                                                                            Navigator.push(context,
                                                                                MaterialPageRoute(builder: (context) => MovieDetail()));
                                                                          },
                                                                          child:
                                                                              Padding(
                                                                            padding:
                                                                                const EdgeInsets.all(8.0),
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
                                                                  child: Text(
                                                                    type[6],
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            24,
                                                                        color: Colors
                                                                            .white),
                                                                  ),
                                                                ),
                                                                Container(
                                                                  height: 200,
                                                                  child: ListView(
                                                                      scrollDirection: Axis.horizontal,
                                                                      children: type6.data!.docs.map((document) {
                                                                        return InkWell(
                                                                          onTap:
                                                                              () {
                                                                            List<String>
                                                                                watch =
                                                                                List.from(document["watch"]);
                                                                            provider.getDetail(
                                                                                document["name"],
                                                                                document["trailer"],
                                                                                document["Audience"],
                                                                                document["Critic"],
                                                                                document["storyline"],
                                                                                type[6],
                                                                                watch,
                                                                                document["ImgURL"]);
                                                                            provider.havewacth(provider.WhereToWatch,
                                                                                watch);
                                                                            Navigator.push(context,
                                                                                MaterialPageRoute(builder: (context) => MovieDetail()));
                                                                          },
                                                                          child:
                                                                              Padding(
                                                                            padding:
                                                                                const EdgeInsets.all(8.0),
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
                                                              ]),
                                                        ),
                                                      ),
                                                    );
                                                  } else if (type.length == 8) {
                                                    var type0 =
                                                        provider.getsnapshot(
                                                            type[0],
                                                            snapshot1,
                                                            snapshot2,
                                                            snapshot3,
                                                            snapshot4,
                                                            snapshot5,
                                                            snapshot6,
                                                            snapshot7,
                                                            snapshot8,
                                                            snapshot9);
                                                    var type1 =
                                                        provider.getsnapshot(
                                                            type[1],
                                                            snapshot1,
                                                            snapshot2,
                                                            snapshot3,
                                                            snapshot4,
                                                            snapshot5,
                                                            snapshot6,
                                                            snapshot7,
                                                            snapshot8,
                                                            snapshot9);
                                                    var type2 =
                                                        provider.getsnapshot(
                                                            type[2],
                                                            snapshot1,
                                                            snapshot2,
                                                            snapshot3,
                                                            snapshot4,
                                                            snapshot5,
                                                            snapshot6,
                                                            snapshot7,
                                                            snapshot8,
                                                            snapshot9);
                                                    var type3 =
                                                        provider.getsnapshot(
                                                            type[3],
                                                            snapshot1,
                                                            snapshot2,
                                                            snapshot3,
                                                            snapshot4,
                                                            snapshot5,
                                                            snapshot6,
                                                            snapshot7,
                                                            snapshot8,
                                                            snapshot9);
                                                    var type4 =
                                                        provider.getsnapshot(
                                                            type[4],
                                                            snapshot1,
                                                            snapshot2,
                                                            snapshot3,
                                                            snapshot4,
                                                            snapshot5,
                                                            snapshot6,
                                                            snapshot7,
                                                            snapshot8,
                                                            snapshot9);
                                                    var type5 =
                                                        provider.getsnapshot(
                                                            type[5],
                                                            snapshot1,
                                                            snapshot2,
                                                            snapshot3,
                                                            snapshot4,
                                                            snapshot5,
                                                            snapshot6,
                                                            snapshot7,
                                                            snapshot8,
                                                            snapshot9);
                                                    var type6 =
                                                        provider.getsnapshot(
                                                            type[6],
                                                            snapshot1,
                                                            snapshot2,
                                                            snapshot3,
                                                            snapshot4,
                                                            snapshot5,
                                                            snapshot6,
                                                            snapshot7,
                                                            snapshot8,
                                                            snapshot9);
                                                    var type7 =
                                                        provider.getsnapshot(
                                                            type[7],
                                                            snapshot1,
                                                            snapshot2,
                                                            snapshot3,
                                                            snapshot4,
                                                            snapshot5,
                                                            snapshot6,
                                                            snapshot7,
                                                            snapshot8,
                                                            snapshot9);
                                                    return Scaffold(
                                                      backgroundColor:
                                                          Colors.black,
                                                      body: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child:
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
                                                                    type[0],
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            24,
                                                                        color: Colors
                                                                            .white),
                                                                  ),
                                                                ),
                                                                Container(
                                                                  height: 200,
                                                                  child: ListView(
                                                                      scrollDirection: Axis.horizontal,
                                                                      children: type0.data!.docs.map((document) {
                                                                        return InkWell(
                                                                          onTap:
                                                                              () {
                                                                            List<String>
                                                                                watch =
                                                                                List.from(document["watch"]);
                                                                            provider.getDetail(
                                                                                document["name"],
                                                                                document["trailer"],
                                                                                document["Audience"],
                                                                                document["Critic"],
                                                                                document["storyline"],
                                                                                type[0],
                                                                                watch,
                                                                                document["ImgURL"]);
                                                                            provider.havewacth(provider.WhereToWatch,
                                                                                watch);
                                                                            Navigator.push(context,
                                                                                MaterialPageRoute(builder: (context) => MovieDetail()));
                                                                          },
                                                                          child:
                                                                              Padding(
                                                                            padding:
                                                                                const EdgeInsets.all(8.0),
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
                                                                  child: Text(
                                                                    type[1],
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            24,
                                                                        color: Colors
                                                                            .white),
                                                                  ),
                                                                ),
                                                                Container(
                                                                  height: 200,
                                                                  child: ListView(
                                                                      scrollDirection: Axis.horizontal,
                                                                      children: type1.data!.docs.map((document) {
                                                                        return InkWell(
                                                                          onTap:
                                                                              () {
                                                                            List<String>
                                                                                watch =
                                                                                List.from(document["watch"]);
                                                                            provider.getDetail(
                                                                                document["name"],
                                                                                document["trailer"],
                                                                                document["Audience"],
                                                                                document["Critic"],
                                                                                document["storyline"],
                                                                                type[1],
                                                                                watch,
                                                                                document["ImgURL"]);
                                                                            provider.havewacth(provider.WhereToWatch,
                                                                                watch);
                                                                            Navigator.push(context,
                                                                                MaterialPageRoute(builder: (context) => MovieDetail()));
                                                                          },
                                                                          child:
                                                                              Padding(
                                                                            padding:
                                                                                const EdgeInsets.all(8.0),
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
                                                                  child: Text(
                                                                    type[2],
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            24,
                                                                        color: Colors
                                                                            .white),
                                                                  ),
                                                                ),
                                                                Container(
                                                                  height: 200,
                                                                  child: ListView(
                                                                      scrollDirection: Axis.horizontal,
                                                                      children: type2.data!.docs.map((document) {
                                                                        return InkWell(
                                                                          onTap:
                                                                              () {
                                                                            List<String>
                                                                                watch =
                                                                                List.from(document["watch"]);
                                                                            provider.getDetail(
                                                                                document["name"],
                                                                                document["trailer"],
                                                                                document["Audience"],
                                                                                document["Critic"],
                                                                                document["storyline"],
                                                                                type[2],
                                                                                watch,
                                                                                document["ImgURL"]);
                                                                            provider.havewacth(provider.WhereToWatch,
                                                                                watch);
                                                                            Navigator.push(context,
                                                                                MaterialPageRoute(builder: (context) => MovieDetail()));
                                                                          },
                                                                          child:
                                                                              Padding(
                                                                            padding:
                                                                                const EdgeInsets.all(8.0),
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
                                                                  child: Text(
                                                                    type[3],
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            24,
                                                                        color: Colors
                                                                            .white),
                                                                  ),
                                                                ),
                                                                Container(
                                                                  height: 200,
                                                                  child: ListView(
                                                                      scrollDirection: Axis.horizontal,
                                                                      children: type3.data!.docs.map((document) {
                                                                        return InkWell(
                                                                          onTap:
                                                                              () {
                                                                            List<String>
                                                                                watch =
                                                                                List.from(document["watch"]);
                                                                            provider.getDetail(
                                                                                document["name"],
                                                                                document["trailer"],
                                                                                document["Audience"],
                                                                                document["Critic"],
                                                                                document["storyline"],
                                                                                type[3],
                                                                                watch,
                                                                                document["ImgURL"]);
                                                                            provider.havewacth(provider.WhereToWatch,
                                                                                watch);
                                                                            Navigator.push(context,
                                                                                MaterialPageRoute(builder: (context) => MovieDetail()));
                                                                          },
                                                                          child:
                                                                              Padding(
                                                                            padding:
                                                                                const EdgeInsets.all(8.0),
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
                                                                  child: Text(
                                                                    type[4],
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            24,
                                                                        color: Colors
                                                                            .white),
                                                                  ),
                                                                ),
                                                                Container(
                                                                  height: 200,
                                                                  child: ListView(
                                                                      scrollDirection: Axis.horizontal,
                                                                      children: type4.data!.docs.map((document) {
                                                                        return InkWell(
                                                                          onTap:
                                                                              () {
                                                                            List<String>
                                                                                watch =
                                                                                List.from(document["watch"]);
                                                                            provider.getDetail(
                                                                                document["name"],
                                                                                document["trailer"],
                                                                                document["Audience"],
                                                                                document["Critic"],
                                                                                document["storyline"],
                                                                                type[4],
                                                                                watch,
                                                                                document["ImgURL"]);
                                                                            provider.havewacth(provider.WhereToWatch,
                                                                                watch);
                                                                            Navigator.push(context,
                                                                                MaterialPageRoute(builder: (context) => MovieDetail()));
                                                                          },
                                                                          child:
                                                                              Padding(
                                                                            padding:
                                                                                const EdgeInsets.all(8.0),
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
                                                                  child: Text(
                                                                    type[5],
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            24,
                                                                        color: Colors
                                                                            .white),
                                                                  ),
                                                                ),
                                                                Container(
                                                                  height: 200,
                                                                  child: ListView(
                                                                      scrollDirection: Axis.horizontal,
                                                                      children: type5.data!.docs.map((document) {
                                                                        return InkWell(
                                                                          onTap:
                                                                              () {
                                                                            List<String>
                                                                                watch =
                                                                                List.from(document["watch"]);
                                                                            provider.getDetail(
                                                                                document["name"],
                                                                                document["trailer"],
                                                                                document["Audience"],
                                                                                document["Critic"],
                                                                                document["storyline"],
                                                                                type[5],
                                                                                watch,
                                                                                document["ImgURL"]);
                                                                            provider.havewacth(provider.WhereToWatch,
                                                                                watch);
                                                                            Navigator.push(context,
                                                                                MaterialPageRoute(builder: (context) => MovieDetail()));
                                                                          },
                                                                          child:
                                                                              Padding(
                                                                            padding:
                                                                                const EdgeInsets.all(8.0),
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
                                                                  child: Text(
                                                                    type[6],
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            24,
                                                                        color: Colors
                                                                            .white),
                                                                  ),
                                                                ),
                                                                Container(
                                                                  height: 200,
                                                                  child: ListView(
                                                                      scrollDirection: Axis.horizontal,
                                                                      children: type6.data!.docs.map((document) {
                                                                        return InkWell(
                                                                          onTap:
                                                                              () {
                                                                            List<String>
                                                                                watch =
                                                                                List.from(document["watch"]);
                                                                            provider.getDetail(
                                                                                document["name"],
                                                                                document["trailer"],
                                                                                document["Audience"],
                                                                                document["Critic"],
                                                                                document["storyline"],
                                                                                type[6],
                                                                                watch,
                                                                                document["ImgURL"]);
                                                                            provider.havewacth(provider.WhereToWatch,
                                                                                watch);
                                                                            Navigator.push(context,
                                                                                MaterialPageRoute(builder: (context) => MovieDetail()));
                                                                          },
                                                                          child:
                                                                              Padding(
                                                                            padding:
                                                                                const EdgeInsets.all(8.0),
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
                                                                  child: Text(
                                                                    type[7],
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            24,
                                                                        color: Colors
                                                                            .white),
                                                                  ),
                                                                ),
                                                                Container(
                                                                  height: 200,
                                                                  child: ListView(
                                                                      scrollDirection: Axis.horizontal,
                                                                      children: type7.data!.docs.map((document) {
                                                                        return InkWell(
                                                                          onTap:
                                                                              () {
                                                                            List<String>
                                                                                watch =
                                                                                List.from(document["watch"]);
                                                                            provider.getDetail(
                                                                                document["name"],
                                                                                document["trailer"],
                                                                                document["Audience"],
                                                                                document["Critic"],
                                                                                document["storyline"],
                                                                                type[7],
                                                                                watch,
                                                                                document["ImgURL"]);
                                                                            provider.havewacth(provider.WhereToWatch,
                                                                                watch);
                                                                            Navigator.push(context,
                                                                                MaterialPageRoute(builder: (context) => MovieDetail()));
                                                                          },
                                                                          child:
                                                                              Padding(
                                                                            padding:
                                                                                const EdgeInsets.all(8.0),
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
                                                              ]),
                                                        ),
                                                      ),
                                                    );
                                                  } else if (type.length == 9) {
                                                    var type0 =
                                                        provider.getsnapshot(
                                                            type[0],
                                                            snapshot1,
                                                            snapshot2,
                                                            snapshot3,
                                                            snapshot4,
                                                            snapshot5,
                                                            snapshot6,
                                                            snapshot7,
                                                            snapshot8,
                                                            snapshot9);
                                                    var type1 =
                                                        provider.getsnapshot(
                                                            type[1],
                                                            snapshot1,
                                                            snapshot2,
                                                            snapshot3,
                                                            snapshot4,
                                                            snapshot5,
                                                            snapshot6,
                                                            snapshot7,
                                                            snapshot8,
                                                            snapshot9);
                                                    var type2 =
                                                        provider.getsnapshot(
                                                            type[2],
                                                            snapshot1,
                                                            snapshot2,
                                                            snapshot3,
                                                            snapshot4,
                                                            snapshot5,
                                                            snapshot6,
                                                            snapshot7,
                                                            snapshot8,
                                                            snapshot9);
                                                    var type3 =
                                                        provider.getsnapshot(
                                                            type[3],
                                                            snapshot1,
                                                            snapshot2,
                                                            snapshot3,
                                                            snapshot4,
                                                            snapshot5,
                                                            snapshot6,
                                                            snapshot7,
                                                            snapshot8,
                                                            snapshot9);
                                                    var type4 =
                                                        provider.getsnapshot(
                                                            type[4],
                                                            snapshot1,
                                                            snapshot2,
                                                            snapshot3,
                                                            snapshot4,
                                                            snapshot5,
                                                            snapshot6,
                                                            snapshot7,
                                                            snapshot8,
                                                            snapshot9);
                                                    var type5 =
                                                        provider.getsnapshot(
                                                            type[5],
                                                            snapshot1,
                                                            snapshot2,
                                                            snapshot3,
                                                            snapshot4,
                                                            snapshot5,
                                                            snapshot6,
                                                            snapshot7,
                                                            snapshot8,
                                                            snapshot9);
                                                    var type6 =
                                                        provider.getsnapshot(
                                                            type[6],
                                                            snapshot1,
                                                            snapshot2,
                                                            snapshot3,
                                                            snapshot4,
                                                            snapshot5,
                                                            snapshot6,
                                                            snapshot7,
                                                            snapshot8,
                                                            snapshot9);
                                                    var type7 =
                                                        provider.getsnapshot(
                                                            type[7],
                                                            snapshot1,
                                                            snapshot2,
                                                            snapshot3,
                                                            snapshot4,
                                                            snapshot5,
                                                            snapshot6,
                                                            snapshot7,
                                                            snapshot8,
                                                            snapshot9);
                                                    var type8 =
                                                        provider.getsnapshot(
                                                            type[8],
                                                            snapshot1,
                                                            snapshot2,
                                                            snapshot3,
                                                            snapshot4,
                                                            snapshot5,
                                                            snapshot6,
                                                            snapshot7,
                                                            snapshot8,
                                                            snapshot9);
                                                    return Scaffold(
                                                      backgroundColor:
                                                          Colors.black,
                                                      body: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child:
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
                                                                    type[0],
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            24,
                                                                        color: Colors
                                                                            .white),
                                                                  ),
                                                                ),
                                                                Container(
                                                                  height: 200,
                                                                  child: ListView(
                                                                      scrollDirection: Axis.horizontal,
                                                                      children: type0.data!.docs.map((document) {
                                                                        return InkWell(
                                                                          onTap:
                                                                              () {
                                                                            List<String>
                                                                                watch =
                                                                                List.from(document["watch"]);
                                                                            provider.getDetail(
                                                                                document["name"],
                                                                                document["trailer"],
                                                                                document["Audience"],
                                                                                document["Critic"],
                                                                                document["storyline"],
                                                                                type[0],
                                                                                watch,
                                                                                document["ImgURL"]);
                                                                            provider.havewacth(provider.WhereToWatch,
                                                                                watch);
                                                                            Navigator.push(context,
                                                                                MaterialPageRoute(builder: (context) => MovieDetail()));
                                                                          },
                                                                          child:
                                                                              Padding(
                                                                            padding:
                                                                                const EdgeInsets.all(8.0),
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
                                                                  child: Text(
                                                                    type[1],
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            24,
                                                                        color: Colors
                                                                            .white),
                                                                  ),
                                                                ),
                                                                Container(
                                                                  height: 200,
                                                                  child: ListView(
                                                                      scrollDirection: Axis.horizontal,
                                                                      children: type1.data!.docs.map((document) {
                                                                        return InkWell(
                                                                          onTap:
                                                                              () {
                                                                            List<String>
                                                                                watch =
                                                                                List.from(document["watch"]);
                                                                            provider.getDetail(
                                                                                document["name"],
                                                                                document["trailer"],
                                                                                document["Audience"],
                                                                                document["Critic"],
                                                                                document["storyline"],
                                                                                type[1],
                                                                                watch,
                                                                                document["ImgURL"]);
                                                                            provider.havewacth(provider.WhereToWatch,
                                                                                watch);
                                                                            Navigator.push(context,
                                                                                MaterialPageRoute(builder: (context) => MovieDetail()));
                                                                          },
                                                                          child:
                                                                              Padding(
                                                                            padding:
                                                                                const EdgeInsets.all(8.0),
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
                                                                  child: Text(
                                                                    type[2],
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            24,
                                                                        color: Colors
                                                                            .white),
                                                                  ),
                                                                ),
                                                                Container(
                                                                  height: 200,
                                                                  child: ListView(
                                                                      scrollDirection: Axis.horizontal,
                                                                      children: type2.data!.docs.map((document) {
                                                                        return InkWell(
                                                                          onTap:
                                                                              () {
                                                                            List<String>
                                                                                watch =
                                                                                List.from(document["watch"]);
                                                                            provider.getDetail(
                                                                                document["name"],
                                                                                document["trailer"],
                                                                                document["Audience"],
                                                                                document["Critic"],
                                                                                document["storyline"],
                                                                                type[2],
                                                                                watch,
                                                                                document["ImgURL"]);
                                                                            provider.havewacth(provider.WhereToWatch,
                                                                                watch);
                                                                            Navigator.push(context,
                                                                                MaterialPageRoute(builder: (context) => MovieDetail()));
                                                                          },
                                                                          child:
                                                                              Padding(
                                                                            padding:
                                                                                const EdgeInsets.all(8.0),
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
                                                                  child: Text(
                                                                    type[3],
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            24,
                                                                        color: Colors
                                                                            .white),
                                                                  ),
                                                                ),
                                                                Container(
                                                                  height: 200,
                                                                  child: ListView(
                                                                      scrollDirection: Axis.horizontal,
                                                                      children: type3.data!.docs.map((document) {
                                                                        return InkWell(
                                                                          onTap:
                                                                              () {
                                                                            List<String>
                                                                                watch =
                                                                                List.from(document["watch"]);
                                                                            provider.getDetail(
                                                                                document["name"],
                                                                                document["trailer"],
                                                                                document["Audience"],
                                                                                document["Critic"],
                                                                                document["storyline"],
                                                                                type[3],
                                                                                watch,
                                                                                document["ImgURL"]);
                                                                            provider.havewacth(provider.WhereToWatch,
                                                                                watch);
                                                                            Navigator.push(context,
                                                                                MaterialPageRoute(builder: (context) => MovieDetail()));
                                                                          },
                                                                          child:
                                                                              Padding(
                                                                            padding:
                                                                                const EdgeInsets.all(8.0),
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
                                                                  child: Text(
                                                                    type[4],
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            24,
                                                                        color: Colors
                                                                            .white),
                                                                  ),
                                                                ),
                                                                Container(
                                                                  height: 200,
                                                                  child: ListView(
                                                                      scrollDirection: Axis.horizontal,
                                                                      children: type4.data!.docs.map((document) {
                                                                        return InkWell(
                                                                          onTap:
                                                                              () {
                                                                            List<String>
                                                                                watch =
                                                                                List.from(document["watch"]);
                                                                            provider.getDetail(
                                                                                document["name"],
                                                                                document["trailer"],
                                                                                document["Audience"],
                                                                                document["Critic"],
                                                                                document["storyline"],
                                                                                type[4],
                                                                                watch,
                                                                                document["ImgURL"]);
                                                                            provider.havewacth(provider.WhereToWatch,
                                                                                watch);
                                                                            Navigator.push(context,
                                                                                MaterialPageRoute(builder: (context) => MovieDetail()));
                                                                          },
                                                                          child:
                                                                              Padding(
                                                                            padding:
                                                                                const EdgeInsets.all(8.0),
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
                                                                  child: Text(
                                                                    type[5],
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            24,
                                                                        color: Colors
                                                                            .white),
                                                                  ),
                                                                ),
                                                                Container(
                                                                  height: 200,
                                                                  child: ListView(
                                                                      scrollDirection: Axis.horizontal,
                                                                      children: type5.data!.docs.map((document) {
                                                                        return InkWell(
                                                                          onTap:
                                                                              () {
                                                                            List<String>
                                                                                watch =
                                                                                List.from(document["watch"]);
                                                                            provider.getDetail(
                                                                                document["name"],
                                                                                document["trailer"],
                                                                                document["Audience"],
                                                                                document["Critic"],
                                                                                document["storyline"],
                                                                                type[5],
                                                                                watch,
                                                                                document["ImgURL"]);
                                                                            provider.havewacth(provider.WhereToWatch,
                                                                                watch);
                                                                            Navigator.push(context,
                                                                                MaterialPageRoute(builder: (context) => MovieDetail()));
                                                                          },
                                                                          child:
                                                                              Padding(
                                                                            padding:
                                                                                const EdgeInsets.all(8.0),
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
                                                                  child: Text(
                                                                    type[6],
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            24,
                                                                        color: Colors
                                                                            .white),
                                                                  ),
                                                                ),
                                                                Container(
                                                                  height: 200,
                                                                  child: ListView(
                                                                      scrollDirection: Axis.horizontal,
                                                                      children: type6.data!.docs.map((document) {
                                                                        return InkWell(
                                                                          onTap:
                                                                              () {
                                                                            List<String>
                                                                                watch =
                                                                                List.from(document["watch"]);
                                                                            provider.getDetail(
                                                                                document["name"],
                                                                                document["trailer"],
                                                                                document["Audience"],
                                                                                document["Critic"],
                                                                                document["storyline"],
                                                                                type[6],
                                                                                watch,
                                                                                document["ImgURL"]);
                                                                            provider.havewacth(provider.WhereToWatch,
                                                                                watch);
                                                                            Navigator.push(context,
                                                                                MaterialPageRoute(builder: (context) => MovieDetail()));
                                                                          },
                                                                          child:
                                                                              Padding(
                                                                            padding:
                                                                                const EdgeInsets.all(8.0),
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
                                                                  child: Text(
                                                                    type[7],
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            24,
                                                                        color: Colors
                                                                            .white),
                                                                  ),
                                                                ),
                                                                Container(
                                                                  height: 200,
                                                                  child: ListView(
                                                                      scrollDirection: Axis.horizontal,
                                                                      children: type7.data!.docs.map((document) {
                                                                        return InkWell(
                                                                          onTap:
                                                                              () {
                                                                            List<String>
                                                                                watch =
                                                                                List.from(document["watch"]);
                                                                            provider.getDetail(
                                                                                document["name"],
                                                                                document["trailer"],
                                                                                document["Audience"],
                                                                                document["Critic"],
                                                                                document["storyline"],
                                                                                type[7],
                                                                                watch,
                                                                                document["ImgURL"]);
                                                                            provider.havewacth(provider.WhereToWatch,
                                                                                watch);
                                                                            Navigator.push(context,
                                                                                MaterialPageRoute(builder: (context) => MovieDetail()));
                                                                          },
                                                                          child:
                                                                              Padding(
                                                                            padding:
                                                                                const EdgeInsets.all(8.0),
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
                                                                  child: Text(
                                                                    type[8],
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            24,
                                                                        color: Colors
                                                                            .white),
                                                                  ),
                                                                ),
                                                                Container(
                                                                  height: 200,
                                                                  child: ListView(
                                                                      scrollDirection: Axis.horizontal,
                                                                      children: type8.data!.docs.map((document) {
                                                                        return InkWell(
                                                                          onTap:
                                                                              () {
                                                                            List<String>
                                                                                watch =
                                                                                List.from(document["watch"]);
                                                                            provider.getDetail(
                                                                                document["name"],
                                                                                document["trailer"],
                                                                                document["Audience"],
                                                                                document["Critic"],
                                                                                document["storyline"],
                                                                                type[8],
                                                                                watch,
                                                                                document["ImgURL"]);
                                                                            provider.havewacth(provider.WhereToWatch,
                                                                                watch);
                                                                            Navigator.push(context,
                                                                                MaterialPageRoute(builder: (context) => MovieDetail()));
                                                                          },
                                                                          child:
                                                                              Padding(
                                                                            padding:
                                                                                const EdgeInsets.all(8.0),
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
                                                              ]),
                                                        ),
                                                      ),
                                                    );
                                                  } else {
                                                    return Scaffold(
                                                      backgroundColor:
                                                          Colors.black,
                                                      body: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .stretch,
                                                            children: [
                                                              Icon(Icons.hourglass_empty_rounded, color: Colors.white, size: 40,),
                                                              SizedBox(height: 15,),
                                                              SizedBox(
                                                                child: Text(
                                                                  "Can't Recommend\nPlease add movie to My List",//hight ava
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          18,
                                                                      color: Colors
                                                                          .white),
                                                                ),
                                                              ),
                                                            ]),
                                                      ),
                                                    );
                                                  }
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
            );
          }),
    );
  }
}
