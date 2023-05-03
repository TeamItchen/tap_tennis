import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:tap_tennis/widgets/main_menu.dart' as menu_page;
import 'package:tap_tennis/widgets/play.dart' as play_page;
import 'package:tap_tennis/widgets/options.dart' as options_page;
import 'package:tap_tennis/widgets/leaderboard.dart' as leaderboard_page;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _fbApp = Firebase.initializeApp();
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pong',
      initialRoute: '/',
      routes: {
        '/': (context) => menu_page.MainMenu(),
        '/play': (context) => play_page.createGameWidget(),
				'/options': (context) => options_page.Options(),
				'/leaderboard': (context) => const leaderboard_page.Leaderboard(title: ""), 
      },
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}
