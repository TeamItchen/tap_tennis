import 'package:flutter/material.dart';
import 'package:tap_tennis/colours.dart' as colours;
import '../components/tap_tennis_game.dart';

//Game Over Pop-Up - Activates when user loses the game
class GameOver extends StatefulWidget {
  final TapTennisGame game;
  GameOver({Key? key, required this.game}) : super(key: key);

  bool gameOver = false;

  @override
  _GameOverState createState() => _GameOverState();
}

class _GameOverState extends State<GameOver> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              color: colours.Palette.charcoal,
            ),
            child: Padding(
                padding: EdgeInsets.only(
                    top: height / 15,
                    left: width / 50,
                    right: width / 50,
                    bottom: height / 15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Game Over",
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.only(
                            top: height / 15,
                            left: height / 100,
                            right: height / 100),
                        child: Container(
                            height: height / 5,
                            width: width / 1.75,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        colours.Palette.playButtonGreen,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(30))),
                                onPressed: () {
                                  setState(() {
                                    Navigator.pop(context);
                                    Navigator.pushNamed(context, '/play');
                                  });
                                },
                                child: Image.asset(
                                    "assets/images/icons/Play.png",
                                    scale: 25)))),
                    Row(children: [
                      Padding(
                          padding: EdgeInsets.only(
                              top: height / 15, right: height / 30),
                          child: Container(
                            height: height / 5,
                            width: width / 3.75,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      colours.Palette.aboutButtonBlue,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30))),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Image.asset("assets/images/icons/Home.png",
                                  scale: 25),
                            ),
                          )),
                      Padding(
                          padding: EdgeInsets.only(
                              top: height / 15, left: height / 30),
                          child: Container(
                            height: height / 5,
                            width: width / 3.75,
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
                                  scale: 25),
                            ),
                          ))
                    ]),
                  ],
                )))
      ])
    ]);
  }
}
