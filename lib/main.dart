import 'package:flutter/material.dart';
import 'screens/start_page.dart';
import 'screens/quiz_page.dart';
import 'screens/results_page.dart';

void main() {
  runApp(const WinterQuizApp());
}

class WinterQuizApp extends StatelessWidget {
  const WinterQuizApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Winter Quiz',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const StartPage(),
        '/quiz': (context) => const QuizPage(),
        '/results': (context) => const ResultsPage(),
      },
    );
  }
} 