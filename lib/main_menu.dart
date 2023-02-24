import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tap_tennis/play.dart' as play_page;
import 'package:tap_tennis/options.dart' as options_page;

class MainMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Main Menu"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            //Play Page Button
            ElevatedButton(
              child: Text("Play"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => play_page.main()),
                );
              },
            ),

            //Settings Page Button
            ElevatedButton(
              child: Text("Options"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => options_page.Options()),
                );
              },
            ),

            //Quit Game
            ElevatedButton(
              child: Text("Quit"),
              onPressed: () {
                SystemNavigator.pop();
              },
            ),
          ],
        ),
      ),
    );
  }
}
