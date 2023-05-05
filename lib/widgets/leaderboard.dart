import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';

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

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          title: const Text("Leaderboard",
              style: TextStyle(fontFamily: "ArcadeN")),
        ),
        body: Container(
            height: height,
            child: SingleChildScrollView(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                const Padding(
                  padding: EdgeInsets.only(right: 50),
                ),
                //Names
                Expanded(
                  flex: 5,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Padding(padding: EdgeInsets.only(top: 20)),
                        const Text("Name",
                            style: TextStyle(
                              fontFamily: "ArcadeN",
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            )),
                        const Padding(padding: EdgeInsets.only(bottom: 15)),
                        for (var name in leaderboard)
                          Text(name.key,
                              style: const TextStyle(
                                fontFamily: "ArcadeN",
                                fontSize: 25,
                                color: Colors.white,
                              ),
                              overflow: TextOverflow.ellipsis)
                      ]),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 50),
                ),

                //Scores
                Expanded(
                    flex: 5,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(padding: EdgeInsets.only(top: 20)),
                          const Text("Score",
                              style: TextStyle(
                                fontFamily: "ArcadeN",
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              )),
                          const Padding(padding: EdgeInsets.only(bottom: 15)),
                          for (var name in leaderboard)
                            Text(name.value.toString(),
                                style: const TextStyle(
                                  fontFamily: "ArcadeN",
                                  fontSize: 25,
                                  color: Colors.white,
                                ))
                        ])),
                const Padding(
                  padding: EdgeInsets.only(left: 50),
                ),
              ],
            ))));
  }

  //When widget gets destroyed, stop listening for database changes
  @override
  void deactivate() {
    _dataStream.cancel();
    super.deactivate();
  }
}
