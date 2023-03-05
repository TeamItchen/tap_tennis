import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:tap_tennis/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

class Leaderboard extends StatefulWidget {
  const Leaderboard({super.key, required this.title});
  final String title;

  @override
  State<Leaderboard> createState() => _LeaderboardState();
}

class _LeaderboardState extends State<Leaderboard> {
  final Future<FirebaseApp> _fbApp = Firebase.initializeApp();
  final TextEditingController nicknameSetter = TextEditingController();
  final TextEditingController scoreSetter = TextEditingController();

  //Clean up the controller when the widget is disposed.
  @override
  void dispose() {
    nicknameSetter.dispose();
    scoreSetter.dispose();
    super.dispose();
  }

  //Submit data to the database
  _submitData(userName, score) {
    DatabaseReference testRef = FirebaseDatabase.instance.ref().child(userName);
    testRef.set(int.parse(score));
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
        ],
      ),
    );
  }
}
