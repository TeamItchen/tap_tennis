# Tap Tennis
M30819 - Software Engineering Theory & Practice (2022/23)
Team 15


## About
A reimagined version of the classic arcade game 'Pong' built for Android and iOS using Dart's Flutter framework, 'Tap Tennis' is a fast-paced, competitive, retro-style table tennis game. Players must battle against obstacles and recieve power-ups to achieve the highest score possible! Players can track their achievements and compare their score to others through the leaderbaord.


## Technologies Used
Flutter, primarily written in Dart, can be compiled to support numerous platforms, although Tap Tennis is only officially supported on Android and iOS.

Flame game engine has been used for the game itself which handles events such as collision detection and user input.

Firebase, which works very nicely with Flutter, has been used to store the leaderboard data. The app will read realtime leaderboard data from here and submit new nicknames and scores.
