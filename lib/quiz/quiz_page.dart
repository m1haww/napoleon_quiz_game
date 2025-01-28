import 'package:flutter/material.dart';
import 'package:napoleon_quiz_game/appprovider/system.dart';
import 'package:napoleon_quiz_game/models/Functions.dart';
import 'dart:async';

import 'package:provider/provider.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  final List<Map<String, Object>> _questions = [
    {
      'question': 'When was Napoleon Bonaparte born?',
      'answers': ['1765', '1769', '1775', '1781'],
      'correct': '1769',
      'image': 'images/image (9).png',
    },
    {
      'question': 'Where was Napoleon Bonaparte born?',
      'answers': ['Corsica', 'Paris', 'Rome', 'Vienna'],
      'correct': 'Corsica',
      'image': 'images/image (10).png',
    },
    {
      'question': 'Which battle marked Napoleon’s final defeat?',
      'answers': ['Austerlitz', 'Waterloo', 'Trafalgar', 'Borodino'],
      'correct': 'Waterloo',
      'image': 'images/image (11).png',
    },
    {
      'question': 'In which year did Napoleon crown himself emperor?',
      'answers': ['1800', '1802', '1804', '1812'],
      'correct': '1804',
      'image': 'images/image (12).png',
    },
    {
      'question': 'What was the name of Napoleon’s first wife?',
      'answers': ['Josephine', 'Marie Louise', 'Eleanor', 'Charlotte'],
      'correct': 'Josephine',
      'image': 'images/wife.jpeg',
    },
    {
      'question': 'Where was Napoleon exiled after his first abdication?',
      'answers': ['Elba', 'Saint Helena', 'Corsica', 'Malta'],
      'correct': 'Elba',
      'image': 'images/image (14).png',
    },
    {
      'question': 'In which year did Napoleon die?',
      'answers': ['1815', '1818', '1821', '1825'],
      'correct': '1821',
      'image': 'images/image (15).png',
    },
  ];

  int _currentQuestionIndex = 0;
  int _score = 0;
  int _timeLeft = 60;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_timeLeft > 0) {
        setState(() {
          _timeLeft--;
        });
      } else {
        _endQuiz(false);
        _timer.cancel();
      }
    });
  }

  void _answerQuestion(String selectedAnswer) {
    if (_questions[_currentQuestionIndex]['correct'] == selectedAnswer) {
      _score++;

      // Add coins for a correct answer
      Provider.of<System>(context, listen: false).addCoins(10);
    }
    if (_currentQuestionIndex < _questions.length - 1) {
      setState(() {
        _currentQuestionIndex++;
      });
    } else {
      _endQuiz(true);
      _timer.cancel();
    }
  }

  void _endQuiz(bool completed) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20), // Smooth dialog corners
        ),
        backgroundColor: const Color(0xff1D1616), // Dialog background
        title: Row(
          children: [
            Icon(
              completed ? Icons.check_circle : Icons.warning, // Dynamic icon
              color: completed ? Colors.green : Colors.red,
            ),
            const SizedBox(width: 10), // Space between icon and title
            Text(
              completed ? 'Quiz Completed!' : 'Time\'s Up!',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: completed ? Colors.green : Colors.red, // Dynamic color
              ),
            ),
          ],
        ),
        content: Text(
          completed
              ? 'You finished the quiz with a score of $_score/${_questions.length}!'
              : 'You couldn\'t complete the quiz in time.',
          style: const TextStyle(
            fontSize: 16,
            color: Color(0xffEEEEEE),
            height: 1.5, // Adjust line height
          ),
          textAlign: TextAlign.center,
        ),
        actionsAlignment: MainAxisAlignment.center, // Center the button(s)
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              Navigator.of(ctx).pop();
              setState(() {
                _resetQuiz();
              });
            },
            style: ElevatedButton.styleFrom(
              backgroundColor:
                  completed ? Colors.green : Colors.red, // Dynamic color
              foregroundColor: const Color(0xff1D1616), // Text color
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
              shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(25), // Smooth rounded corners
              ),
              elevation: 6, // Shadow effect
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min, // Adjust width to content
              children: [
                Icon(
                  completed ? Icons.celebration : Icons.refresh, // Dynamic icon
                  size: 20,
                  color: Colors.white, // Icon color
                ),
                const SizedBox(width: 8), // Space between icon and text
                Text(
                  completed ? 'Celebrate!' : 'Try Again',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.1,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _resetQuiz() {
    setState(() {
      _currentQuestionIndex = 0;
      _score = 0;
      _timeLeft = 60;
      _startTimer();
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final questionData = _questions[_currentQuestionIndex];
    double progress =
        (_currentQuestionIndex + 1) / _questions.length; // Calculate progress

    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        Positioned.fill(
          child: Image.asset(
            'images/fundal.jpg',
            fit: BoxFit.cover,
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: buildback(context, () {
              Navigator.pop(context);
            }),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                buildIntroText(context, "Quiz"),
                Consumer<System>(
                  builder: (context, system, _) => Row(
                    children: [
                      Image(
                        image: AssetImage("images/Group 19.png"),
                        width: width * 0.04,
                        height: height * 0.04,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '${system.coins}', // Display coins
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontFamily: "Karma"),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(22.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Image.asset(
                    questionData['image'] as String,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(height: 20),
                  LinearProgressIndicator(
                    value: progress, // Progress value
                    backgroundColor: Colors.grey[800],
                    color: Colors.red,
                    minHeight: 8,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    questionData['question'] as String,
                    style: const TextStyle(
                        color: Color(0xFFF43135),
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                        fontFamily: "Karma"),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  ...(questionData['answers'] as List<String>).map((answer) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: ElevatedButton(
                        onPressed: () => _answerQuestion(answer),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xff1D1616),
                          foregroundColor: const Color(0xffEEEEEE),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding: const EdgeInsets.symmetric(
                              vertical: 14, horizontal: 30),
                          elevation: 5, // Shadow effect
                        ),
                        child: Text(
                          answer,
                          style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 1.2,
                              fontFamily: "Karma"),
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              // Add the action you need for the button here, like starting a timer
            },
            backgroundColor: Colors
                .transparent, // Transparent background for custom decoration
            elevation: 0, // No shadow, custom design will stand out
            child: Container(
              constraints: const BoxConstraints(
                maxWidth: 100, // Ensure it doesn't exceed a max width
                maxHeight: 100, // Ensure it doesn't exceed a max height
              ),
              decoration: BoxDecoration(
                color: const Color(0xff8E1616),
                borderRadius: BorderRadius.circular(50), // Fully rounded button
                boxShadow: [
                  BoxShadow(
                    color: Colors.black
                        .withOpacity(0.15), // Softer shadow for subtle depth
                    blurRadius: 10,
                    offset: const Offset(0, 5), // More balanced shadow offset
                  ),
                ],
              ),
              padding: const EdgeInsets.all(
                  12), // Padding inside the FAB for better spacing
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "$_timeLeft", // Display the countdown time
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20, // Adjusted size to avoid overflow
                        fontWeight: FontWeight.bold,
                        fontFamily: "Karma",
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
