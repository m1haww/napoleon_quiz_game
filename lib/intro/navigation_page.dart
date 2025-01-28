import 'package:flutter/material.dart';
import 'package:napoleon_quiz_game/pages/home/home_page.dart';
import 'package:napoleon_quiz_game/pages/home/profile/settings_page.dart';
import 'package:napoleon_quiz_game/quiz/start_page.dart';

class NavigationPage extends StatefulWidget {
  const NavigationPage({super.key});

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  int _currentIndex = 0;

  // Listă de pagini pentru navigare
  final List<Widget> _pages = [
    const HomePage(),
    const StartPage(),
    const SettingsPage()
  ];

  @override
  Widget build(BuildContext context) {
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
          body: Stack(
            children: [
              _pages[_currentIndex],
            ],
          ),
          // Bara de navigare
          bottomNavigationBar: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: BottomNavigationBar(
              backgroundColor: const Color(0xff1D1616),
              selectedItemColor: Colors.red,
              unselectedItemColor: Colors.white,
              currentIndex: _currentIndex,
              showSelectedLabels: false,
              showUnselectedLabels: false,
              onTap: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.cabin),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.help_outline),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.settings),
                  label: '',
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
