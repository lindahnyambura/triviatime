import 'package:flutter/material.dart';
import 'package:alienquiz/home_screen.dart' as home; // Import home screen
import 'package:alienquiz/quiz_screen.dart'; // Import quiz screen

void main() {
  runApp(MyApp()); // Entry point of the app
}

// Main app widget
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Trivia Time', // App title
      theme: ThemeData(
        primarySwatch: Colors.blue, // Set the primary color
      ),
      initialRoute: '/', // Initial route
      routes: {
        '/': (context) => home.HomeScreen(), // Route for home screen
        '/quiz': (context) => QuizScreen(), // Route for quiz screen
      },
    );
  }
}
