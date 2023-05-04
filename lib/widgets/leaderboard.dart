import 'dart:async';

import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';

import 'leaderboard.dart';
export 'leaderboard.dart';

class Leaderboard extends StatefulWidget {
  const Leaderboard({super.key, required this.title});
  final String title;

  @override
  State<Leaderboard> createState() => _LeaderboardState();
}

class _LeaderboardState extends State<Leaderboard> {
  //Initialise Firebase
  final Future<FirebaseApp> _fbApp = Firebase.initializeApp();

  //Reference to the Firebase Database
  final DatabaseReference _lbRef = FirebaseDatabase.instance.ref("Leaderboard");
  late StreamSubscription _dataStream;

  //List for storing leaderboard data from database
  List leaderboard = [];

  //Create data controllers for input boxes
  final TextEditingController nicknameSetter = TextEditingController();
  final TextEditingController scoreSetter = TextEditingController();

  //Run listener for database changes
  @override
  void initState() {
    super.initState();
    _retrieveData();
  }

  //Listen for database changes and retrieve data
  void _retrieveData() {
    _dataStream = _lbRef.onValue.listen((event) {
      final leaderboardData =
          Map<String, Map>.from(event.snapshot.value as Map);

      //Format data as a list
      for (int i = 0; i < leaderboardData.length; i++) {
        final userData = leaderboardData.values.elementAt(i);
        final nickName = userData.values.elementAt(1) as String;
        final score = userData.values.elementAt(0) as int;
        leaderboard.add(MapEntry(nickName, score));
      }

      //Sort leaderboard data in decsending order by score
      leaderboard.sort((a, b) => b.value.compareTo(a.value));

			//Refresh the widget so that the new data is displayed
      setState(() {});
    });
  }

  //Submit data to the database
  _submitData(nickName, score) {
    _lbRef.child(nickName).set({'Name': nickName, 'Score': int.parse(score)});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Leaderboard"),
      ),
      body: Column(
        children: <Widget>[
          TextField(
            controller: nicknameSetter,
            textAlign: TextAlign.left,
            decoration: const InputDecoration(
              hintText: 'PLEASE ENTER A NICKNAME',
              hintStyle: TextStyle(color: Colors.grey),
            ),
          ),
          TextField(
            controller: scoreSetter,
            textAlign: TextAlign.left,
            decoration: const InputDecoration(
              hintText: 'PLEASE ENTER A SCORE',
              hintStyle: TextStyle(color: Colors.grey),
            ),
          ),
          ElevatedButton(
            child: const Text("SUMBIT"),
            onPressed: () {
              _submitData(nicknameSetter.text, scoreSetter.text);
            },
          ),
          Column(children: [
            for (var name in leaderboard)
              Text(name.key + " " + name.value.toString())
          ])
        ],
      ),
    );
  }

  //When widget gets destroyed, stop listening for database changes
  @override
  void deactivate() {
    _dataStream.cancel();
    super.deactivate();
  }

  //When widget is disposed, clean up controllers
  @override
  void dispose() {
    nicknameSetter.dispose();
    scoreSetter.dispose();
    super.dispose();
  }
}
