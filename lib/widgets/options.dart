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
          const Text("Sound Mixer"),
          const Text("Screen Resolution"),
          const Text("Customize Ball"),
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
