import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:napoleon_quiz_game/models/Functions.dart';
import 'package:napoleon_quiz_game/quiz/quiz_page.dart';

class StartPage extends StatefulWidget {
  const StartPage({super.key});

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          buildBackground(context),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 40),
                    const Text(
                      '?',
                      style: TextStyle(
                        fontSize: 60,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Karma",
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'How to play',
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Karma",
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Napoleon Bonaparte quiz',
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 22,
                        fontWeight: FontWeight.w500,
                        fontFamily: "Karma",
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      '''1. Press the “Start Now” button.
2. The quiz has 7 questions, each with 4 answer options.
3. Read the question carefully.
4. Tap or click on the answer you believe is correct.
5. After viewing the feedback, proceed to the next question by pressing the Next button.
6. Answer all 7 questions to finish the quiz.
7.There is a timer , you need to finish the quiz within 60 seconds. ''',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        height: 1.5,
                        fontFamily: "Karma",
                      ),
                      textAlign: TextAlign.left,
                    ),
                    const SizedBox(height: 40),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          CupertinoPageRoute(
                            builder: (context) => const QuizPage(),
                          ),
                        );
                      },
                      child: Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(
                            vertical: 14, horizontal: 24),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Text(
                          'Start Now',
                          style: TextStyle(
                            color: Color(0xffEEEEEE),
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Karma",
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
