import 'package:flutter/material.dart';
import 'package:napoleon_quiz_game/appprovider/system.dart';
import 'package:napoleon_quiz_game/models/Functions.dart';

import 'package:provider/provider.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    final model = Provider.of<System>(context);
    final width = MediaQuery.of(context).size.width;
    final coinsProvider = Provider.of<System>(context);
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          buildBackground(context),
          AppBar(
            backgroundColor: Colors.transparent,
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
                    style: const TextStyle(
                        color: Colors.white, fontFamily: "Karma"),
                  ),
                  const SizedBox(width: 16),
                ],
              ),
            ],
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Column(
                      children: [
                        const Image(
                          image: AssetImage("images/Frame (1).png"),
                          fit: BoxFit.cover,
                        ),
                        buildHeight(context, 0.01),
                        buildIntroText(context, "Settings"),
                      ],
                    ),
                  ),
                  buildHeight(context, 0.04),
                  buildHeight(context, 0.08),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      buildQuizText(context, "About me", Colors.white),
                      buildWidth(context, 0.04),
                      buildProfileEditbuton(context)
                    ],
                  ),
                  buildHeight(context, 0.1),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          final model =
                              Provider.of<System>(context, listen: false);
                          // Show SnackBar when the profile image is clicked
                        },
                        child: model.profile == null
                            ? ClipOval(
                                child: Image(
                                  image:
                                      const AssetImage("images/image (9).png"),
                                  width: width * 0.30,
                                  height: width * 0.30,
                                  fit: BoxFit.cover,
                                ),
                              )
                            : AnimatedSwitcher(
                                duration: const Duration(milliseconds: 300),
                                child: buildProfileImage(
                                    context, model.profile!.image),
                              ),
                      ),
                      buildWidth(context, 0.02),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment
                              .start, // Aligns text to the left
                          children: [
                            Text(
                              model.profile?.mame ??
                                  "Napoleon", // Displays the profile name
                              style: const TextStyle(
                                color: Colors.red,
                                fontSize:
                                    18, // Adjusted font size for better readability
                                fontWeight: FontWeight
                                    .w600, // Slightly bolder for emphasis
                              ),
                            ),
                            buildHeight(context,
                                0.02), // Adds space between name and age
                            Text(
                              model.profile?.age ??
                                  "34", // Displays the profile age
                              style: const TextStyle(
                                color: Colors.red,
                                fontSize: 16, // Adjusted font size for balance
                                fontWeight: FontWeight
                                    .w400, // Normal weight for age text
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
