import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:myflutter/main.dart' as app;
import 'package:myflutter/screen/editprofile.dart';

import 'robots/create_robot.dart';
import 'robots/home_robot.dart';
import 'robots/login_robot.dart';
import 'robots/navigation_test.dart';
import 'robots/editprofile_robot.dart';

void main() {
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized()
      as IntegrationTestWidgetsFlutterBinding;

  Homerobot homerobot;
  LogInrobot logInrobot;
  Navigationbot navigationbot;
  EditProfilebot editProfilebot;
  Createrobot createrobot;

  group('e2etest', () {
    testWidgets('Boot app', (WidgetTester tester) async {
      app.main();

      homerobot = Homerobot(tester);
      await homerobot.findTitle();

      logInrobot = LogInrobot(tester);
      await logInrobot.findTitle();
      await logInrobot.LogIn();

      navigationbot = Navigationbot(tester);
      await navigationbot.findWidgetandIcon();
      await navigationbot.tapProfile();

      editProfilebot = EditProfilebot(tester);
      await editProfilebot.editprofile();
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
  });

  //group('login', () {

  //});
}
