import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:myflutter/main.dart' as app;

import 'robots/home_robot.dart';
import 'robots/login_robot.dart';
import 'robots/navigation_test.dart';

void main() {
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized()
      as IntegrationTestWidgetsFlutterBinding;

  Homerobot homerobot;
  LogInrobot logInrobot;
  Navigationbot navigationbot;

  group('e2etest', () {
    testWidgets('whole app', (WidgetTester tester) async {
      app.main();

      homerobot = Homerobot(tester);
      await homerobot.findBtn();

      logInrobot = LogInrobot(tester);
      await logInrobot.findTitle();
      await logInrobot.ClickCreate();

      navigationbot = Navigationbot(tester);
      await navigationbot.findTitle();
      await Future.delayed(Duration(seconds: 10));
    });

    testWidgets('login', (WidgetTester tester) async {
      app.main();
      logInrobot = LogInrobot(tester);
      await logInrobot.findTitle();
      //await logInrobot.scrollThePage();
    });
  });
}
