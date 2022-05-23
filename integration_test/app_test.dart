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
      await homerobot.findBtn();

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
      await homerobot.findBtn();
      await Future.delayed(Duration(seconds: 5));
    });

    testWidgets('login', (WidgetTester tester) async {
      app.main();

      homerobot = Homerobot(tester);
      await homerobot.findBtn();
      await homerobot.tapLogIn();

      logInrobot = LogInrobot(tester);
      await logInrobot.findTitle();
      await logInrobot.LogIn();
      await Future.delayed(Duration(seconds: 5));
    });

    testWidgets('Create', (WidgetTester tester) async {
      app.main();

      homerobot = Homerobot(tester);
      await homerobot.findBtn();
      await homerobot.tapRegister();

      createrobot = Createrobot(tester);
      await createrobot.findTitle();
      await createrobot.Register();

      logInrobot = LogInrobot(tester);
      await logInrobot.findTitle();
      await Future.delayed(Duration(seconds: 5));
    });
  });
}
