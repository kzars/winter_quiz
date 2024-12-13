import 'package:flutter/material.dart';

class ResultsPage extends StatelessWidget {
  const ResultsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Map<String, int> args = (ModalRoute.of(context)?.settings.arguments as Map<String, int>?) ?? {'score': 0, 'total': 5};
    final score = args['score'] ?? 0;
    final total = args['total'] ?? 5;
    final percentage = ((score / total) * 100).round();

    String getMessage() {
      if (percentage == 100) return 'Perfect Score!';
      if (percentage >= 80) return 'Excellent!';
      if (percentage >= 60) return 'Good Job!';
      if (percentage >= 40) return 'Nice Try!';
      return 'Keep Practicing!';
    }

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.lightBlue, Colors.white],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Quiz Complete!',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                getMessage(),
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Your Score: $score/$total',
                style: const TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                ),
              ),
              Text(
                '$percentage%',
                style: const TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    '/',
                    (route) => false,
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                  backgroundColor: Colors.white,
                ),
                child: const Text(
                  'Try Again',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.blue,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
} 