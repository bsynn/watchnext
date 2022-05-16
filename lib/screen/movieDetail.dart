// ignore_for_file: prefer_const_constructors, file_names, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:favorite_button/favorite_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:myflutter/providers/navigation_provider.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class MovieDetail extends StatefulWidget {
  const MovieDetail({Key? key}) : super(key: key);

  @override
  State<MovieDetail> createState() => _MovieDetailState();
}

class _MovieDetailState extends State<MovieDetail> {
  final Future<FirebaseApp> firebase = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    var provider =
        Provider.of<BottomNavigationBarProvider>(context, listen: false);

    List myList = provider.mylist;
    bool add = provider.FindNameSame(provider.name, myList);

    String vedioId;
    vedioId = YoutubePlayer.convertUrlToId(provider.vdoURL)!;

    YoutubePlayerController _controller = YoutubePlayerController(
      initialVideoId: vedioId,
      flags: YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
        disableDragSeek: false,
        isLive: false,
      ),
    );

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
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 0.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                child: YoutubePlayer(
                    controller: _controller, liveUIColor: Colors.amber),
              ),
              SizedBox(height: 15),
              SizedBox(
                child: Text(
                  provider.name,
                  style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                ),
              ),
              SizedBox(height: 2),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.red,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Text(
                    provider.type,
                    style: TextStyle(fontSize: 12, color: Colors.white),
                  ),
                ),
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  SizedBox(
                    child: Text(
                      "critic ",
                      style: TextStyle(fontSize: 14, color: Color(0xfff1d12d)),
                    ),
                  ),
                  SizedBox(
                    child: Text(
                      provider.critic,
                      style: TextStyle(fontSize: 14, color: Colors.white),
                    ),
                  ),
                  SizedBox(
                    child: Text(
                      "    audiece ",
                      style: TextStyle(fontSize: 14, color: Color(0xfff1d12d)),
                    ),
                  ),
                  SizedBox(
                    child: Text(
                      provider.audience,
                      style: TextStyle(fontSize: 14, color: Colors.white),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15),
              SizedBox(
                child: Text(
                  "Storyline",
                  style: TextStyle(fontSize: 16, color: Color(0xfff1d12d)),
                ),
              ),
              SizedBox(height: 5),
              SizedBox(
                child: Text(
                  provider.storyline,
                  style: TextStyle(fontSize: 14, color: Colors.white),
                ),
              ),
              SizedBox(height: 15),
              SizedBox(
                child: Text(
                  "Where to Watch",
                  style: TextStyle(fontSize: 16, color: Color(0xfff1d12d)),
                ),
              ),
              ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: provider.whrhave.length,
                  itemBuilder: (BuildContext context, index) {
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          child: InkWell(
                            onTap: () {
                              launch(provider.whrhave[index].link);
                            },
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: Row(
                                children: [
                                  Container(
                                      child: Image.asset(
                                    provider.whrhave[index].imgURL,
                                    width: 35,
                                  )),
                                  SizedBox(
                                    width: 12,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 50.0),
                                    child: SizedBox(
                                      child: Text(
                                        provider.whrhave[index].name,
                                        style: TextStyle(
                                            fontSize: 16, color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  }),
              SizedBox(
                height: 10,
              ),
              Divider(
                thickness: 1,
                color: Colors.white,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0, bottom: 50.0),
                child: Row(
                  //crossAxisAlignment: CrossAxisAlignment.center,
                  //mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FavoriteButton(
                      isFavorite: add,
                      valueChanged: (_isFavorite) async {
                        if (_isFavorite) {
                          DocumentReference storeReference = FirebaseFirestore
                              .instance
                              .collection(
                                  FirebaseAuth.instance.currentUser!.uid)
                              .doc(provider.name);
                          await storeReference.set({
                            "Type": provider.type,
                            "Audience": provider.audience,
                            "Critic": provider.critic,
                            "ImagURL": provider.imgURL,
                            "name": provider.name,
                            "storyline": provider.storyline,
                            "trailer": provider.vdoURL,
                            "watch": FieldValue.arrayUnion(
                                provider.getWhrhave(provider.whrhave)),
                          });
                        } else {
                          FirebaseFirestore.instance
                              .collection(
                                  FirebaseAuth.instance.currentUser!.uid)
                              .doc(provider.name)
                              .delete();
                        }
                      },
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    SizedBox(
                      child: Text(
                        "Add to My List",
                        style:
                            TextStyle(fontSize: 16, color: Color(0xfff1d12d)),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
