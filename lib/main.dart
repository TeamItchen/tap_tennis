import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:tap_tennis/colours.dart' as colours;
import 'package:tap_tennis/widgets/main_menu.dart' as menu_page;
import 'package:tap_tennis/widgets/play.dart' as play_page;
import 'package:tap_tennis/widgets/options.dart' as options_page;
import 'package:tap_tennis/widgets/leaderboard.dart' as leaderboard_page;

//Main Method - Runs the Flutter App
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

//Main widget- Defines the characteristics of all widgets in the app
class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _fbApp = Firebase.initializeApp();
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    //Lock orientation to landscape
		SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);

		//Auto-hide system navbar
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.top]);

		//Various parameters incl routes for navigation between widgets
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pong',
      initialRoute: '/',
      routes: {
        '/': (context) => menu_page.MainMenu(),
        '/play': (context) => play_page.createGameWidget(),
        '/options': (context) => options_page.Options(),
        '/leaderboard': (context) =>
            const leaderboard_page.Leaderboard(title: ""),
      },
      theme: ThemeData(
        primarySwatch: colours.Palette.midnightGreen,
				scaffoldBackgroundColor: colours.Palette.gunmetal,
      ),
    );
  }
}
