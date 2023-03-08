import 'dart:math';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:tap_tennis/widgets/main_menu.dart' as menu_page;


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
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: menu_page.MainMenu(),
    );
  }
}