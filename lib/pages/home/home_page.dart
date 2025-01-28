import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:napoleon_quiz_game/appprovider/system.dart';
import 'package:napoleon_quiz_game/models/Functions.dart';
import 'package:napoleon_quiz_game/pages/home/add_personalities.dart';
import 'package:napoleon_quiz_game/pages/home/detail_page.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final coinsProvider = Provider.of<System>(context);
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: buildIntroText(context, 'Historical'),
        backgroundColor: Colors.black,
        actions: [
          Row(
            children: [
              Image(
                image: AssetImage("images/Group 19.png"),
                width: width * 0.04,
                height: height * 0.04,
              ),
              buildWidth(context, 0.02),
              Text(
                '${coinsProvider.coins}',
                style:
                    const TextStyle(color: Colors.white, fontFamily: "Karma"),
              ),
              const SizedBox(width: 16),
            ],
          ),
        ],
      ),
      body: Stack(
        children: [
          buildBackground(context),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemCount: _personalities.length,
                  itemBuilder: (ctx, index) {
                    final personality = _personalities[index];
                    return Card(
                      color: const Color(0xff1D1616),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  DetailPage(personality: personality),
                            ),
                          );
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: width * 0.20,
                              height: width * 0.20,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  image: AssetImage(personality['image']),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Text(
                              personality['name'],
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color(0xff8E1616),
                                fontFamily: "Karma",
                              ),
                            ),
                            Text(
                              personality['power'],
                              style: const TextStyle(
                                fontSize: 14,
                                color: Color(0xffEEEEEE),
                                fontFamily: "Karma",
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        onPressed: () {
          Navigator.push(
              context,
              CupertinoPageRoute(
                  builder: (context) => const AddPersonalities()));
        },
        child: const Icon(Icons.backpack, color: Color(0xffFF5C5C)),
      ),
    );
  }
}

final List<Map<String, dynamic>> _personalities = [
  {
    'name': 'Napoleon Bonaparte',
    'image': 'images/napoleon.jpg',
    'power': 'Supreme Commander',
    'role': 'Commander - The Emperor',
    'price': 150,
  },
  {
    'name': 'Louis-Alexandre',
    'image': 'images/louis.jpeg',
    'power': 'Master of Logistics',
    'role': 'Subcommander - The Organizer',
    'price': 70,
  },
  {
    'name': 'Joachim Murat',
    'image': 'images/Joachim Murat.jpeg',
    'power': 'Cavalry Commander',
    'role': 'Subcommander - The Cavalry King',
    'price': 75,
  },
  {
    'name': 'Michel Ney',
    'image': 'images/Michel Ney.jpeg',
    'power': 'Bravest of the Brave',
    'role': 'Subcommander - The Fearless Warrior',
    'price': 80,
  },
  {
    'name': 'Jean Lannes',
    'image': 'images/Jean Lannes.jpg',
    'power': 'Field Marshal ',
    'role': 'Subcommander - Napoleon’s Friend',
    'price': 85,
  },
  {
    'name': 'André Masséna',
    'image': 'images/André Masséna.jpeg',
    'power': 'Child of Victory',
    'role': 'Subcommander - The Strategic Genius',
    'price': 85,
  },
];
