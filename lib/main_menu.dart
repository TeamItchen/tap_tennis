import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tap_tennis/colours.dart' as colours;
import 'package:tap_tennis/play.dart' as play_page;
import 'package:tap_tennis/options.dart' as options_page;
import 'package:tap_tennis/leaderboard.dart' as leaderboard_page;

class MainMenu extends StatelessWidget {
  final ButtonStyle btn_Style = ButtonStyle(
      backgroundColor: MaterialStateProperty.all<Color>(
          const Color.fromARGB(255, 94, 215, 12)),
      foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
      textStyle: MaterialStateProperty.all<TextStyle>(const TextStyle(
          fontSize: 24, fontWeight: FontWeight.bold, fontFamily: "Monospace")),
      shape: MaterialStateProperty.all<OutlinedBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            const Text(
              "Tap Tennis",
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            ),

						//PLAY BUTTON
            ElevatedButton(
                style: btn_Style,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => play_page.main()),
                  );
                },
                child: const Text("Start Game")),

						//OPTIONS & LB BUTTONS
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [

								//OPTIONS BUTTON
                ElevatedButton(
                    style: btn_Style,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => options_page.Options()),
                      );
                    },
                    child: const Text("Options")),

								//LEADERBOARD BUTTON
                ElevatedButton(
                    style: btn_Style,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => leaderboard_page.Leaderboard()),
                      );
                    },
                    child: const Text("Leadboard")),
              ],
            )
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
