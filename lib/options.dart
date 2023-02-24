import 'package:flutter/material.dart';

class Options extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Options"),
      ),
      body: Column(
        children: <Widget>[
          Text("Sound Mixer"),
          Text("Screen Resolution"),
          Text("Customize Ball"),
          ElevatedButton(
            child: Text("Go back"),
            onPressed: () {
              Navigator.pop(context);
            },
          )
        ],
      ),
    );
  }
}
