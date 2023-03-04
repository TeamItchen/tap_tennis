import 'package:flutter/material.dart';

class Leaderboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Leaderboard"),
      ),
      body: Column(
        children: <Widget>[
          ElevatedButton(
            child: const Text("Back"),
            onPressed: () {
              Navigator.pop(context);
            },
          )
        ],
      ),
    );
  }
}
