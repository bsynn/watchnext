import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:myflutter/main.dart' as app;
import 'package:myflutter/providers/navigation_provider.dart';
import 'package:myflutter/screen/editprofile.dart';

import 'robots/create_robot.dart';
import 'robots/home_robot.dart';
import 'robots/login_robot.dart';
import 'robots/navigation_test.dart';
import 'robots/editprofile_robot.dart';
import 'robots/reccommend_robot.dart';
import 'robots/select_robot.dart';
import 'robots/mylist_robot.dart';

void main() {
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized()
      as IntegrationTestWidgetsFlutterBinding;

  Homerobot homerobot;
  LogInrobot logInrobot;
  Navigationbot navigationbot;
  EditProfilebot editProfilebot;
  Createrobot createrobot;
  String moviename;
  String audience1;
  String critic1;
  String storyline1;
  String type1;
  String imgURL1;
  Selectrobot selectrobot;
  MyListrobot mylistrobot;
  Recrobot recrobot;
  group('Basic', () {
    testWidgets('Boot app', (WidgetTester tester) async {
      app.main();
      await Future.delayed(Duration(seconds: 5));
    });

    testWidgets('Home', (WidgetTester tester) async {
      app.main();

      homerobot = Homerobot(tester);
      await homerobot.findTitle();
      await Future.delayed(Duration(seconds: 5));
    });
  });

  group('login', () {
    testWidgets('login', (WidgetTester tester) async {
      app.main();

      homerobot = Homerobot(tester);
      await homerobot.findTitle();
      await homerobot.tapLogIn();

      logInrobot = LogInrobot(tester);
      await logInrobot.findTitle();
      await logInrobot.LogIn();
      await Future.delayed(Duration(seconds: 5));
    });

    testWidgets('tapCreateButton', (WidgetTester tester) async {
      app.main();

      homerobot = Homerobot(tester);
      await homerobot.findTitle();
      await homerobot.tapLogIn();

      logInrobot = LogInrobot(tester);
      await logInrobot.findTitle();
      await logInrobot.tapCreate();
      await Future.delayed(Duration(seconds: 5));
    });

    testWidgets('check Error fill email only', (WidgetTester tester) async {
      app.main();

      homerobot = Homerobot(tester);
      await homerobot.findTitle();
      await homerobot.tapLogIn();

      logInrobot = LogInrobot(tester);
      await logInrobot.findTitle();
      await logInrobot.fillEmailOnly();
      await Future.delayed(Duration(seconds: 5));
    });

    testWidgets('check Error fill password only', (WidgetTester tester) async {
      app.main();

      homerobot = Homerobot(tester);
      await homerobot.findTitle();
      await homerobot.tapLogIn();

      logInrobot = LogInrobot(tester);
      await logInrobot.findTitle();
      await logInrobot.fillPassOnly();
      await Future.delayed(Duration(seconds: 5));
    });

    testWidgets('check Error invalid email format',
        (WidgetTester tester) async {
      app.main();

      homerobot = Homerobot(tester);
      await homerobot.findTitle();
      await homerobot.tapLogIn();

      logInrobot = LogInrobot(tester);
      await logInrobot.findTitle();
      await logInrobot.WrongFormatEmail();
      await Future.delayed(Duration(seconds: 5));
    });

    testWidgets('check Error wrong email or pass', //still error
        (WidgetTester tester) async {
      app.main();

      homerobot = Homerobot(tester);
      await homerobot.findTitle();
      await homerobot.tapLogIn();

      logInrobot = LogInrobot(tester);
      await logInrobot.findTitle();
      await logInrobot.WrongEmailOrPass();
      await Future.delayed(Duration(seconds: 5));
    });

    testWidgets('check null input', //still error
        (WidgetTester tester) async {
      app.main();

      homerobot = Homerobot(tester);
      await homerobot.findTitle();
      await homerobot.tapLogIn();

      logInrobot = LogInrobot(tester);
      await logInrobot.findTitle();
      await logInrobot.NullInput();
      await Future.delayed(Duration(seconds: 5));
    });
  });

  group('Register', () {
    testWidgets('Register', (WidgetTester tester) async {
      app.main();

      homerobot = Homerobot(tester);
      await homerobot.findTitle();
      await homerobot.tapRegister();

      createrobot = Createrobot(tester);
      await createrobot.findTitle();
      await createrobot.Register();

      logInrobot = LogInrobot(tester);
      await logInrobot.findTitle();
      await Future.delayed(Duration(seconds: 5));
    });

    testWidgets('Already Account', (WidgetTester tester) async {
      app.main();

      homerobot = Homerobot(tester);
      await homerobot.findTitle();
      await homerobot.tapRegister();

      createrobot = Createrobot(tester);
      await createrobot.findTitle();
      await createrobot.AlreadyAccount();
    });

    testWidgets('Check Null Input', (WidgetTester tester) async {
      app.main();

      homerobot = Homerobot(tester);
      await homerobot.findTitle();
      await homerobot.tapRegister();

      createrobot = Createrobot(tester);
      await createrobot.findTitle();
      await createrobot.NullInput();
    });

    testWidgets('Check error input name only', (WidgetTester tester) async {
      app.main();

      homerobot = Homerobot(tester);
      await homerobot.findTitle();
      await homerobot.tapRegister();

      createrobot = Createrobot(tester);
      await createrobot.findTitle();
      await createrobot.fillNameOnly();
    });

    testWidgets('Check error invalid Email format',
        (WidgetTester tester) async {
      app.main();

      homerobot = Homerobot(tester);
      await homerobot.findTitle();
      await homerobot.tapRegister();

      createrobot = Createrobot(tester);
      await createrobot.findTitle();
      await createrobot.WrongFormatEmail();
    });

    testWidgets('Check error Password shortly', (WidgetTester tester) async {
      app.main();

      homerobot = Homerobot(tester);
      await homerobot.findTitle();
      await homerobot.tapRegister();

      createrobot = Createrobot(tester);
      await createrobot.findTitle();
      await createrobot.ShortPass();
    });

    testWidgets('Check error when input name and lastname',
        (WidgetTester tester) async {
      app.main();

      homerobot = Homerobot(tester);
      await homerobot.findTitle();
      await homerobot.tapRegister();

      createrobot = Createrobot(tester);
      await createrobot.findTitle();
      await createrobot.fillNameAndLN();
    });

    testWidgets('Check error when input email and password',
        (WidgetTester tester) async {
      app.main();

      homerobot = Homerobot(tester);
      await homerobot.findTitle();
      await homerobot.tapRegister();

      createrobot = Createrobot(tester);
      await createrobot.findTitle();
      await createrobot.fillEmailAndPass();
    });
  });

  group('Movie', () {
    testWidgets('Select Movie', (WidgetTester tester) async {
      app.main();

      homerobot = Homerobot(tester);
      await homerobot.findTitle();
      await homerobot.tapLogIn();

      logInrobot = LogInrobot(tester);
      await logInrobot.findTitle();
      await logInrobot.LogIn();

      selectrobot = Selectrobot(tester);
      await selectrobot.findTitle();
      await Future.delayed(Duration(seconds: 5));
    });

    testWidgets('Add Movie', (WidgetTester tester) async {
      app.main();

      homerobot = Homerobot(tester);
      await homerobot.findTitle();
      await homerobot.tapLogIn();

      logInrobot = LogInrobot(tester);
      await logInrobot.findTitle();
      await logInrobot.LogIn();

      selectrobot = Selectrobot(tester);
      await selectrobot.findTitle();
      await Future.delayed(Duration(seconds: 5));

      mylistrobot = MyListrobot(tester);
      moviename = mylistrobot.getNameFromAdd();
      type1 = mylistrobot.getTypeFromAdd();
      critic1 = mylistrobot.getCriticFromAdd();
      audience1 = mylistrobot.getAudienceFromAdd();
      storyline1 = mylistrobot.getStorylineFromAdd();
      imgURL1 =
          "https://firebasestorage.googleapis.com/v0/b/watchnext-b1bdb.appspot.com/o/MoviePoster%2FAction%2Fact_BabyDriver.jpg?alt=media&token=80ff441e-1690-42d9-8390-cbf6cb519d24";
      await mylistrobot.AddMovie();
      await mylistrobot.setAddTofirebase(moviename, "vdoURL1", audience1,
          critic1, storyline1, type1, "", imgURL1);
      await Future.delayed(Duration(seconds: 5));
      navigationbot = Navigationbot(tester);
      await navigationbot.tapMylist();
      await Future.delayed(Duration(seconds: 5));
      await navigationbot.tapReccommend();
      await Future.delayed(Duration(seconds: 5));
    });

    testWidgets('remove Movie', (WidgetTester tester) async {
      app.main();

      homerobot = Homerobot(tester);
      await homerobot.findTitle();
      await homerobot.tapLogIn();

      logInrobot = LogInrobot(tester);
      await logInrobot.findTitle();
      await logInrobot.LogIn();

      selectrobot = Selectrobot(tester);
      await selectrobot.findTitle();
      await Future.delayed(Duration(seconds: 5));

      mylistrobot = MyListrobot(tester);
      moviename = mylistrobot.getNameFromAdd();
      await mylistrobot.AddMovie();

      await mylistrobot.RemoveFromFirebase(moviename);
      navigationbot = Navigationbot(tester);
      await navigationbot.tapMylist();
      await Future.delayed(Duration(seconds: 5));
      await navigationbot.tapReccommend();
      await Future.delayed(Duration(seconds: 5));
    });
  });
}
