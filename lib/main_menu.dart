import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tap_tennis/colours.dart' as colours;
import 'package:tap_tennis/play.dart' as play_page;
import 'package:tap_tennis/options.dart' as options_page;

class MainMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text("Main Menu"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            //Play Button
            Padding(
              padding: EdgeInsets.only(
                  top: height / 15, left: height / 100, right: height / 100),
              child: Container(
                height: height / 10,
                width: width / 1.33,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: colours.Palette.playButtonGreen,
                      foregroundColor: colours.Palette.snow,
                      textStyle: const TextStyle(fontSize: 45),
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero)),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => play_page.main()),
                    );
                  },
                  child: const Text(
                    "Play",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontFamily: "AdamCGPro"),
                  ),
                ),
              ),
            ),

            //Settings Button
            Padding(
              padding: EdgeInsets.only(
                  top: height / 100, left: height / 100, right: height / 100),
              child: Container(
                height: height / 10,
                width: width / 1.33,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: colours.Palette.aboutButtonBlue,
                      foregroundColor: colours.Palette.snow,
                      textStyle: const TextStyle(fontSize: 45),
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero)),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => options_page.Options()),
                    );
                  },
                  child: const Text(
                    "Options",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontFamily: "AdamCGPro"),
                  ),
                ),
              ),
            ),

            //Quit Game
//Play Button
            Padding(
              padding: EdgeInsets.only(
                  top: height / 100, left: height / 100, right: height / 100),
              child: Container(
                height: height / 10,
                width: width / 1.33,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: colours.Palette.quitButtonRed,
                      foregroundColor: colours.Palette.snow,
                      textStyle: const TextStyle(fontSize: 45),
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero)),
                  onPressed: () {
                    SystemNavigator.pop();
                  },
                  child: const Text(
                    "Quit",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontFamily: "AdamCGPro"),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
