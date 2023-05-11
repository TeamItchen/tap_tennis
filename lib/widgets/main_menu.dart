import 'package:flutter/material.dart';
import 'package:tap_tennis/colours.dart' as colours;
import 'package:tap_tennis/widgets/play.dart' as play_page;
import 'package:tap_tennis/widgets/options.dart' as options_page;
import 'package:tap_tennis/widgets/leaderboard.dart' as leaderboard_page;

class MainMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(padding: EdgeInsets.only(top: height / 200)),
            const Text(
              "Tap Tennis",
              style: TextStyle(
                fontFamily: "ArcadeI",
                fontSize: 40,
                color: Colors.white,
              ),
            ),
            Column(children: [
              //PLAY BUTTON
              Padding(
                  padding: EdgeInsets.only(
                      top: height / 100,
                      left: height / 100,
                      right: height / 100),
                  child: Container(
                      height: height / 5,
                      width: width / 1.75,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: colours.Palette.playButtonGreen,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30))),
                          onPressed: () {
                            Navigator.pushNamed(context, '/play');
                          },
                          child: Image.asset("assets/images/icons/Play.png",
                              scale: 25)))),

              //OPTIONS & LB BUTTONS
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //OPTIONS BUTTON
                  Padding(
                      padding: EdgeInsets.only(
                          top: height / 20,
                          left: width / 15,
                          right: width / 90),
                      child: Container(
                          height: height / 5,
                          width: width / 3.65,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: colours.Palette.charcoal,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30))),
                              onPressed: () {
                                Navigator.pushNamed(context, '/options');
                              },
                              child: Image.asset(
                                  "assets/images/icons/Settings.png",
                                  scale: 25)))),

                  //LEADERBOARD BUTTON
                  Padding(
                      padding: EdgeInsets.only(
                          top: height / 20,
                          left: width / 90,
                          right: width / 15),
                      child: Container(
                          height: height / 5,
                          width: width / 3.65,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      colours.Palette.quitButtonRed,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30))),
                              onPressed: () {
                                Navigator.pushNamed(context, '/leaderboard');
                              },
                              child: Image.asset(
                                  "assets/images/icons/Leaderboard.png",
                                  scale: 25))))
                ],
              )
            ])
          ],
        ),
      ),
    );
  }
}
