import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:napoleon_quiz_game/appprovider/system.dart';
import 'package:napoleon_quiz_game/models/Functions.dart';

class DetailPage extends StatelessWidget {
  final Map<String, dynamic> personality;

  const DetailPage({required this.personality, super.key});

  @override
  Widget build(BuildContext context) {
    final systemProvider = Provider.of<System>(context, listen: false);

    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Stack(children: [
      Positioned.fill(
        child: Image.asset(
          'images/fundal.jpg',
          fit: BoxFit.cover,
        ),
      ),
      Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          leading: buildback(context, () {
            Navigator.pop(context);
          }),
          title: Text(
            personality['name'],
            style: const TextStyle(
                fontSize: 28,
                fontFamily: "Karma",
                color: Color(0xffF40101),
                fontWeight: FontWeight.w400),
          ),
          backgroundColor: Colors.transparent,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.6,
                height: MediaQuery.of(context).size.width * 0.6,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: AssetImage(personality['image']),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                personality['name'],
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff8E1616),
                  fontFamily: "Karma",
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              Text(
                personality['power'],
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontFamily: "Karma",
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              Text(
                personality['role'],
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                  fontFamily: "Karma",
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text(
                  'Price: ${personality['price']} ',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xffFF5C5C),
                    fontFamily: "Karma",
                  ),
                  textAlign: TextAlign.center,
                ),
                buildWidth(context, 0.02),
                Image(
                  image: AssetImage("images/Group 19.png"),
                  width: width * 0.04,
                  height: height * 0.04,
                )
              ]),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  final model = systemProvider.purchasePersonality(personality);
                  Navigator.pop(context);
                  // Show feedback based on success or failure
                  final snackBar = SnackBar(
                    backgroundColor: Color(0xff1D1616),
                    content: Text(
                      model
                          ? '${personality['name']} has been purchased!'
                          : 'Not enough coins to purchase ${personality['name']}.',
                      style: TextStyle(
                          color: Color(
                            0xff8E1616,
                          ),
                          fontFamily: "Karma"),
                    ),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 32.0, vertical: 12.0),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0)),
                ),
                child: const Text(
                  'Buy',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Karma",
                      color: Color(0xffEEEEEE)),
                ),
              ),
            ],
          ),
        ),
      ),
    ]);
  }
}
