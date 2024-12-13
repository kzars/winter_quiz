import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/question.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Question> questions = [];
  int currentQuestionIndex = 0;
  int score = 0;
  bool isLoading = true;
  final int numberOfQuestions = 5;

  @override
  void initState() {
    super.initState();
    loadQuestions();
  }

  Future<void> loadQuestions() async {
    try {
      final String jsonString = await rootBundle.loadString('assets/questions.json');
      final List<dynamic> jsonList = json.decode(jsonString);
      final List<Question> allQuestions = jsonList.map((json) => Question.fromJson(json)).toList();
      
      // Randomly select 5 questions
      final random = Random();
      allQuestions.shuffle(random);
      
      setState(() {
        questions = allQuestions.take(numberOfQuestions).toList();
        isLoading = false;
      });
    } catch (e) {
      debugPrint('Error loading questions: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  void answerQuestion(String selectedAnswer) {
    if (selectedAnswer == questions[currentQuestionIndex].answer) {
      setState(() {
        score++;
      });
    }

    if (currentQuestionIndex < questions.length - 1) {
      setState(() {
        currentQuestionIndex++;
      });
    } else {
      Navigator.pushReplacementNamed(
        context, 
        '/results', 
        arguments: {
          'score': score,
          'total': numberOfQuestions,
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (questions.isEmpty) {
      return const Scaffold(
        body: Center(
          child: Text('No questions available'),
        ),
      );
    }

    final currentQuestion = questions[currentQuestionIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text('Question ${currentQuestionIndex + 1}/$numberOfQuestions'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 20),
            Text(
              currentQuestion.question,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            ...currentQuestion.options.map((option) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: ElevatedButton(
                onPressed: () => answerQuestion(option),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(16),
                ),
                child: Text(
                  option,
                  style: const TextStyle(fontSize: 18),
                ),
              ),
            )),
          ],
        ),
      ),
    );
  }
} 