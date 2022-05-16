// ignore_for_file: non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:myflutter/model/watch.dart';
import 'package:flutter/foundation.dart';

class BottomNavigationBarProvider with ChangeNotifier {
  int _currentIndex = 0;

  int get currentIndex => _currentIndex;

  set currentIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }

  void getDetail(String name1, String vdoURL1, String audience1, String critic1,
      String storyline1, String type1, List<String> watch, String imgURL1) {
    name = name1;
    vdoURL = vdoURL1;
    audience = audience1;
    critic = critic1;
    storyline = storyline1;
    type = type1;
    whr = watch;
    imgURL = imgURL1;
  }

  String name = "";
  String vdoURL = "";
  String imgURL = "";
  String audience = "";
  String critic = "";
  String storyline = "";
  String type = "";

  List<watch> WhereToWatch = [
    watch(
        name: "Fandango",
        imgURL: "assets/images/fandago.png",
        link: "https://www.fandango.com/"),
    watch(
        name: "Peacock",
        imgURL: "assets/images/peacock.png",
        link: "https://www.peacocktv.com/"),
    watch(
        name: "Prime video",
        imgURL: "assets/images/primevideo.png",
        link: "https://www.primevideo.com/"),
    watch(
        name: "VUDU",
        imgURL: "assets/images/vudu.png",
        link: "https://www.vudu.com/"),
    watch(
        name: "Hulu",
        imgURL: "assets/images/hulu.png",
        link:
            "https://www.hulu.com/welcome?orig_referrer=https%3A%2F%2Fwww.bing.com%2F"),
    watch(
        name: "Disney",
        imgURL: "assets/images/disney.png",
        link: "https://www.disney.co.th/"),
    watch(
        name: "HBO",
        imgURL: "assets/images/hbo.png",
        link: "https://www.hbo.com/"),
    watch(
        name: "Netflix",
        imgURL: "assets/images/netflix.png",
        link: "https://www.netflix.com/th-en/"),
    watch(
        name: "iTunes",
        imgURL: "assets/images/itunes.png",
        link: "https://www.apple.com/itunes/"),
    watch(
        name: "Google play",
        imgURL: "assets/images/googleplay.png",
        link:
            "https://play.google.com/store/movies?utm_source=apac_med&utm_medium=hasem&utm_content=Oct0121&utm_campaign=Evergreen&pcamp"),
    watch(
        name: "Disneyplus",
        imgURL: "assets/images/disneyplus.png",
        link: "https://www.hotstar.com/th"),
    watch(
        name: "Tubi",
        imgURL: "assets/images/tubi.png",
        link: "https://tubitv.com/"),
    watch(
        name: "IMDB",
        imgURL: "assets/images/imdb.png",
        link: "https://www.imdb.com/"),
    watch(
        name: "Paramount",
        imgURL: "assets/images/paramount.png",
        link: "https://www.paramount.com/"),
  ];

  List<String> whr = [];
  List<watch> whrhave = [];
  List<String> getwhrhave = [];

  void havewacth(List<watch> WhereToWatch, List<String> whr) {
    whrhave = [];
    for (int i = 0; i < WhereToWatch.length; i++) {
      if (FindSame(WhereToWatch[i].name, whr)) {
        whrhave.add(WhereToWatch[i]);
      }
    }
  }

  bool FindSame(String whrname, List<String> whr) {
    for (int i = 0; i < whr.length; i++) {
      if (whrname == whr[i]) {
        return true;
      }
    }
    return false;
  }

  List<String> getWhrhave(List<watch> whrhave) {
    for (int i = 0; i < whrhave.length; i++) {
      getwhrhave.add(whrhave[i].name);
    }
    return getwhrhave;
  }

  List mylist = [];
  bool FindNameSame(String name, List myList) {
    for (int i = 0; i < myList.length; i++) {
      if (name == myList[i]["name"]) {
        return true;
      }
    }
    return false;
  }

  String pname = "";
  String plname = "";

  void getPnamePlname(String pname1, String plname1) {
    pname = pname1;
    plname = plname1;
  }

  List<String> rectype = [];

  void getRecMovie(List perMovie) {
    rectype = [];
    int cAction = 0;
    int cAdventure = 0;
    int cComedy = 0;
    int cDrama = 0;
    int cFantasy = 0;
    int cHorror = 0;
    int cMystery = 0;
    int cRomance = 0;
    int cThriller = 0;

    for (int i = 0; i < perMovie.length; i++) {
      if (perMovie[i]["Type"] == "Action") {
        cAction++;
      } else if (perMovie[i]["Type"] == "Adventure") {
        cAdventure++;
      } else if (perMovie[i]["Type"] == "Comedy") {
        cComedy++;
      } else if (perMovie[i]["Type"] == "Drama") {
        cDrama++;
      } else if (perMovie[i]["Type"] == "Fantasy") {
        cFantasy++;
      } else if (perMovie[i]["Type"] == "Horror") {
        cHorror++;
      } else if (perMovie[i]["Type"] == "Mystery") {
        cMystery++;
      } else if (perMovie[i]["Type"] == "Romance") {
        cRomance++;
      } else {
        cThriller++;
      }
    }
    List<int> list = [
      cAction,
      cAdventure,
      cComedy,
      cDrama,
      cFantasy,
      cHorror,
      cMystery,
      cRomance,
      cThriller
    ];

    list.sort();
    int max = 0;

    for (int i = 0; i < list.length; i++) {
      if (list[i] >= list.last && list[i] > 0) {
        max++;
      }
    }
    for (int i = 0; i < max; i++) {
      if (list[8 - i] == cAction) {
        rectype.add("Action");
        cAction = 0;
      } else if (list[8 - i] == cAdventure) {
        rectype.add("Adventure");
        cAdventure = 0;
      } else if (list[8 - i] == cComedy) {
        rectype.add("Comedy");
        cComedy = 0;
      } else if (list[8 - i] == cDrama) {
        rectype.add("Drama");
        cDrama = 0;
      } else if (list[8 - i] == cFantasy) {
        rectype.add("Fantasy");
        cFantasy = 0;
      } else if (list[8 - i] == cHorror) {
        rectype.add("Horror");
        cHorror = 0;
      } else if (list[8 - i] == cMystery) {
        rectype.add("Mystery");
        cMystery = 0;
      } else if (list[8 - i] == cRomance) {
        rectype.add("Romance");
        cRomance = 0;
      } else {
        rectype.add("Thriller");
        cThriller = 0;
      }
    }
    print(rectype.toString());
  }

  AsyncSnapshot<QuerySnapshot<Object?>> getsnapshot(
      String type,
      AsyncSnapshot<QuerySnapshot<Object?>> snapshot1,
      AsyncSnapshot<QuerySnapshot<Object?>> snapshot2,
      AsyncSnapshot<QuerySnapshot<Object?>> snapshot3,
      AsyncSnapshot<QuerySnapshot<Object?>> snapshot4,
      AsyncSnapshot<QuerySnapshot<Object?>> snapshot5,
      AsyncSnapshot<QuerySnapshot<Object?>> snapshot6,
      AsyncSnapshot<QuerySnapshot<Object?>> snapshot7,
      AsyncSnapshot<QuerySnapshot<Object?>> snapshot8,
      AsyncSnapshot<QuerySnapshot<Object?>> snapshot9) {
    if (type == "Action") {
      return snapshot1;
    } else if (type == "Adventure") {
      return snapshot2;
    } else if (type == "Comedy") {
      return snapshot3;
    } else if (type == "Drama") {
      return snapshot4;
    } else if (type == "Fantasy") {
      return snapshot5;
    } else if (type == "Horror") {
      return snapshot6;
    } else if (type == "Mystery") {
      return snapshot7;
    } else if (type == "Romance") {
      return snapshot8;
    } else {
      return snapshot9;
    }
  }
}
