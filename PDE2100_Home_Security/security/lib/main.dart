//Code References:
//https://www.linkedin.com/learning/flutter-part-07-building-the-ui-or-flutter-part-07-building-uis/bmi-calculator-a-beautiful-health-app?u=42408908
//https://gist.github.com/leeprobert/22c396462e59bc355a441a37e48553c7
//https://milivolt.news/post/electronic-organ-construction-with-hc-05-bluetooth-module
//https://www.youtube.com/watch?v=H46oNd2mjoU&ab_channel=MitchKoko
//https://www.youtube.com/watch?v=yUHP2aLlLc8&ab_channel=MilivoltNet
//https://forum.arduino.cc/t/receiving-data-from-bluetooth-module-hc-05/933934/7
//https://stackoverflow.com/questions/65341929/how-to-receive-data-from-an-arduino-based-bluetooth-device-in-flutter
//https://github.com/edufolly/flutter_bluetooth_serial/blob/master/example/lib/BackgroundCollectingTask.dart
//https://api.flutter.dev/flutter/dart-async/StreamSubscription-class.html
//https://www.fluttercampus.com/guide/220/audio-player-example-flutter/#how-to-play-audio-from-local-file-path
//https://stackoverflow.com/questions/73463000/playing-an-asset-with-audioplayers-package-in-flutter
//https://www.flaticon.com/search?word=drum
//https://www.youtube.com/watch?v=-JWkAcYDQeQ&ab_channel=CodingComics

//This main file code initialises Firebase, creates a MaterialApp, and defines
//routes for the application's pages. The main method ensures that Flutter is
//correctly initialised, while Firebase.initializeApp() activates Firebase services.
//The MaterialApp is set up with a custom dark theme, and routes are specified for each page.
//The initialRoute is set to '/congrats', which means that the CongratsPage (login page)
//will be displayed first when the app is launched.

import 'package:security/game_page.dart';
import 'package:security/input_page.dart';
import 'package:security/first_page.dart';
import 'package:security/congrats.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(InstrumentApp());
}

class InstrumentApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        // making custom dark theme
        primaryColor: Color(0xFF0A0E21),
        scaffoldBackgroundColor: Color(0xFF0A0E21),
      ),
      routes: {
        '/first': (context) => FirstPage(),
        '/input': (context) => InputPage(),
        '/game': (context) => GamePage(),
        '/congrats': (context) => CongratsPage(),
      },
      initialRoute: '/congrats',
    );
  }
}
