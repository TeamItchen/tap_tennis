import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

//GETTERS

//Get Nickname value from disk
Future<String> getNickname() async {
  final prefs = await SharedPreferences.getInstance();
  String? nickname = prefs.getString('nickname');
  if (nickname == null) {
    nickname = "";
  }
  return nickname;
}

//Create text field controller and apply initial nickname value
Future<TextEditingController> getNicknameInitial() async {
  TextEditingController nicknameSetter = TextEditingController();
  nicknameSetter.text = await getNickname();
  return nicknameSetter;
}

//Get Ball Speed value from disk
//If no value stored (eg: app opened for first time) set to 5
Future<double> getBallSpeed() async {
  final prefs = await SharedPreferences.getInstance();
  double? ballSpeed = prefs.getDouble('ballSpeed');
  if (ballSpeed == null) {
    ballSpeed = 5;
  }
  return ballSpeed;
}

//Get Paddle Speed value from disk
//If no value stored (eg: app opened for first time) set to 8
Future<double> getPaddleSpeed() async {
  final prefs = await SharedPreferences.getInstance();
  double? paddleSpeed = prefs.getDouble('paddleSpeed');
  if (paddleSpeed == null) {
    paddleSpeed = 8;
  }
  return paddleSpeed;
}

//Get PowerUp Status value from disk
//If no value stored (eg: app opened for first time) set to true
Future<bool> getPowerUpsStatus() async {
  final prefs = await SharedPreferences.getInstance();
  bool? powerUps = prefs.getBool('powerUps');
  if (powerUps == null) {
    powerUps = true;
  }
  return powerUps;
}

//Get Obstacles Status value from disk
//If no value stored (eg: app opened for first time) set to true
Future<bool> getObstaclesStatus() async {
  final prefs = await SharedPreferences.getInstance();
  bool? obstacles = prefs.getBool('obstacles');
  if (obstacles == null) {
    obstacles = true;
  }
  return obstacles;
}

////////////////////////////////////////////////////////////////////////////////

//SETTERS
//These functions are called by the options menu when settings are changed.
//They take the value passed to them and stored it to the persistent storage.

//Set new Nickname value to disk
void setNickname(nickname) async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setString('nickname', nickname);
}

//Set new Ball Speed value to disk
void setBallSpeed(ballSpeed) async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setDouble('ballSpeed', ballSpeed);
}

//Set new Paddle Speed value to disk
void setPaddleSpeed(paddleSpeed) async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setDouble('paddleSpeed', paddleSpeed);
}

//Set new Power Ups value to disk
void setPowerUps(powerUps) async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setBool('powerUps', powerUps);
}

//Set new Obstacles value to disk
void setObstacles(obstacles) async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setBool('obstacles', obstacles);
}
