import 'package:flutter/material.dart';
import 'package:tap_tennis/colours.dart' as colours;
import 'package:tap_tennis/data_persistence.dart' as data;

class Options extends StatefulWidget {
  @override
  _OptionsState createState() => _OptionsState();
}

class _OptionsState extends State<Options> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          title: const Text("Options", style: TextStyle(fontFamily: "ArcadeN")),
        ),
        body: FutureBuilder(
            future: Future.wait([
              data.getNicknameInitial(),
              data.getBallSpeed(),
              data.getPaddleSpeed(),
              data.getPowerUpsStatus(),
              data.getObstaclesStatus(),
            ]),
            builder: (
              context,
              AsyncSnapshot<List<dynamic>> snapshot,
            ) {
              if (snapshot.hasData) {
                return Center(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                      Column(children: [
                        //NICKNAME INPUT
                        Container(
                            width: width / 1.1,
                            child: TextField(
                              controller: snapshot.data![0],
															style: const TextStyle(color: Colors.grey),
                              decoration: InputDecoration(
                                border: const UnderlineInputBorder(),
                                hintText: 'PLEASE ENTER A NICKNAME',
                                hintStyle: const TextStyle(color: Colors.grey),
                                suffixIcon: IconButton(
                                  icon: const Icon(Icons.send),
																	color: Colors.grey,
                                  onPressed: () {
                                    data.setNickname(snapshot.data![0].text);
                                  },
                                ),
                              ),
                            )),

                        //SPEED SLIDERS
                        Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              //BALL SPEED SLIDER
                              Column(children: [
                                Padding(
                                    padding: EdgeInsets.only(top: height / 15),
                                    child: const Text(
                                      "Ball Speed",
                                      style: TextStyle(
																					color: Colors.grey,
                                          fontSize: 20),
                                    )),
                                Padding(
                                    padding: EdgeInsets.only(
                                        left: height / 100,
                                        right: height / 100),
                                    child: Container(
                                      height: height / 5,
                                      width: width / 2.1,
                                      child: Slider(
                                        value: snapshot.data![1],
                                        min: 1,
                                        max: 15,
                                        divisions: 14,
                                        label: snapshot.data![1]
                                            .round()
                                            .toString(),
                                        onChanged: (double newBallSpeed) {
                                          setState(() {
                                            data.setBallSpeed(newBallSpeed);
                                          });
                                        },
                                      ),
                                    )),
                              ]),

                              //PADDLE SPEED SLIDER
                              Column(children: [
                                Padding(
                                    padding: EdgeInsets.only(top: height / 15),
                                    child: const Text(
                                      "Paddle Speed",
                                      style: TextStyle(
																					color: Colors.grey,
                                          fontSize: 20,),
                                    )),
                                Padding(
                                    padding: EdgeInsets.only(
                                        left: height / 100,
                                        right: height / 100),
                                    child: Container(
                                      height: height / 5,
                                      width: width / 2.1,
                                      child: Slider(
                                        value: snapshot.data![2],
                                        min: 1,
                                        max: 15,
                                        divisions: 14,
                                        label: snapshot.data![2]
                                            .round()
                                            .toString(),
                                        onChanged: (double newPaddleSpeed) {
                                          setState(() {
                                            data.setPaddleSpeed(newPaddleSpeed);
                                          });
                                        },
                                      ),
                                    )),
                              ])
                            ]),

                        //POWER-UPS AND OBSTACLES TOGGLE BUTTONS
                        Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              //POWER-UPS BUTTON
                              Padding(
                                  padding: EdgeInsets.only(
                                      top: height / 500,
                                      right: width / 10),
                                  child: Container(
                                      height: height / 5,
                                      width: width / 3.65,
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor: snapshot.data![3]
                                                ? colours
                                                    .Palette.playButtonGreen
                                                : colours.Palette.quitButtonRed,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(30))),
                                        onPressed: () {
                                          setState(() {
                                            data.setPowerUps(
                                                !snapshot.data![3]);
                                          });
                                        },
                                        child: snapshot.data![3]
                                            ? const Text("Power Ups:\nOn",
                                                textAlign: TextAlign.center)
                                            : const Text("Power Ups:\nOff",
                                                textAlign: TextAlign.center),
                                      ))),

                              //OBSTACLES BUTTON
                              Padding(
                                  padding: EdgeInsets.only(
                                      top: height / 500,
                                      left: width / 10),
                                  child: Container(
                                      height: height / 5,
                                      width: width / 3.65,
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor: snapshot.data![4]
                                                ? colours
                                                    .Palette.playButtonGreen
                                                : colours.Palette.quitButtonRed,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(30))),
                                        onPressed: () {
                                          setState(() {
                                            data.setObstacles(
                                                !snapshot.data![4]);
                                          });
                                        },
                                        child: snapshot.data![4]
                                            ? const Text("Obstacles:\nOn",
                                                textAlign: TextAlign.center)
                                            : const Text("Obstacles:\nOff",
                                                textAlign: TextAlign.center),
                                      ))),
                            ]),
                      ])
                    ]));
              } else {
                return const CircularProgressIndicator();
              }
            }));
  }
}
