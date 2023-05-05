import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:tap_tennis/data_persistence.dart' as data;
import '../components/tap_tennis_game.dart' as game;

final Future<FirebaseApp> _fbApp = Firebase.initializeApp();

//Reference to the Firebase Database
final DatabaseReference _lbRef = FirebaseDatabase.instance.ref("Leaderboard");

//List for storing leaderboard data from database
List leaderboard = [];

//Listen for database changes and retrieve data
void retrieveData() async {
  final ref = FirebaseDatabase.instance.ref();
  final String nickName = await data.getNickname();
  final storedScoreRaw = await ref.child('Leaderboard/$nickName/Score').get();
  final storedScore = int.tryParse((storedScoreRaw.value).toString());

	//Check if the user has set a nickname in settings
  if (nickName != "") {
    //Check if there is an entry for the user in the database
    if (storedScoreRaw.exists) {
      //If the score from the latest round is higher than the user's stored score, overwrite the database entry to contain the new high score
      if (game.score > storedScore!) {
        _submitData(nickName, game.score);
      }
    }

    //If there is no entry for the user in the database, insert the name and score
    else {
      _submitData(nickName, game.score);
    }
  }
}

//Submit data to the database
_submitData(nickName, score) {
  _lbRef.child(nickName).set({'Name': nickName, 'Score': score});
}
