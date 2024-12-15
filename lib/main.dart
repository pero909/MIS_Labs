import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/joke_type_screen.dart';
import 'screens/random_joke_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Joke App (191553)',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
      routes: {
        '/randomJoke': (context) => RandomJokeScreen(),
      },
    );
  }
}
