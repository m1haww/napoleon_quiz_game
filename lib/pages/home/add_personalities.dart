import 'package:flutter/material.dart';
import 'package:napoleon_quiz_game/appprovider/system.dart';
import 'package:napoleon_quiz_game/models/Functions.dart';
import 'package:provider/provider.dart';

class AddPersonalities extends StatefulWidget {
  const AddPersonalities({super.key});

  @override
  State<AddPersonalities> createState() => _AddPersonalitiesState();
}

class _AddPersonalitiesState extends State<AddPersonalities> {
  Map<String, dynamic>?
      selectedPersonality; // Store selected personality details
  Offset? overlayPosition; // Store position for floating container
  final double containerWidth = 250; // Floating container dimensions
  final double containerHeight = 250;

  @override
  Widget build(BuildContext context) {
    final systemProvider = Provider.of<System>(context);
    final purchasedPersonalities = systemProvider.purchasedPersonalities;
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final height = MediaQuery.of(context).size.height;
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
            title: buildIntroText(context, "Inventory"),
            leading: buildback(context, () {
              Navigator.pop(context);
            }),
          ),
          body: Stack(
            children: [
              SafeArea(
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Center(
                              child: Container(
                                height: height * 0.7,
                                decoration: BoxDecoration(
                                  color: const Color.fromARGB(255, 29, 28, 28),
                                  borderRadius: BorderRadius.circular(16),
                                  border:
                                      Border.all(color: Colors.red, width: 2),
                                ),
                                padding: const EdgeInsets.all(12.0),
                                child: GridView.builder(
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 4,
                                    crossAxisSpacing: 10,
                                    mainAxisSpacing: 10,
                                    childAspectRatio: 1,
                                  ),
                                  itemCount: 16,
                                  itemBuilder: (context, index) {
                                    if (index < purchasedPersonalities.length) {
                                      final personality =
                                          purchasedPersonalities[index];
                                      return GestureDetector(
                                        onTapDown: (TapDownDetails details) {
                                          setState(() {
                                            selectedPersonality = personality;

                                            // Ensure the floating container fits on the screen
                                            final tapPosition =
                                                details.globalPosition;
                                            double adjustedX = tapPosition.dx;
                                            double adjustedY = tapPosition.dy;

                                            // Prevent the container from overflowing horizontally
                                            if (adjustedX + containerWidth >
                                                screenWidth) {
                                              adjustedX = screenWidth -
                                                  containerWidth -
                                                  10;
                                            } else if (adjustedX < 0) {
                                              adjustedX = 10;
                                            }

                                            // Prevent the container from overflowing vertically
                                            if (adjustedY + containerHeight >
                                                screenHeight) {
                                              adjustedY = screenHeight -
                                                  containerHeight -
                                                  10;
                                            } else if (adjustedY < 0) {
                                              adjustedY = 10;
                                            }

                                            overlayPosition =
                                                Offset(adjustedX, adjustedY);
                                          });
                                        },
                                        child: Card(
                                          color: Colors.white,
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(
                                                8.0), // Asigură-te că imaginea respectă marginile cardului
                                            child: AspectRatio(
                                              aspectRatio:
                                                  1, // Menține imaginea pătrată, la fel ca celelalte carduri
                                              child: Image.asset(
                                                personality['image'],
                                                fit: BoxFit
                                                    .cover, // Face ca imaginea să umple exact containerul, fără să iasă în afară
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    } else {
                                      // Empty slots
                                      return Card(
                                        color: Colors.grey[200],
                                        child: InkWell(
                                          onTap: () {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              const SnackBar(
                                                backgroundColor:
                                                    Color(0xff1D1616),
                                                content: Text(
                                                  "You didn't buy anything yet.",
                                                  style: TextStyle(
                                                      color: Color(
                                                        0xff8E1616,
                                                      ),
                                                      fontFamily: "Karma"),
                                                ),
                                                duration: Duration(seconds: 2),
                                              ),
                                            );
                                          },
                                          child: const Icon(
                                            Icons.add,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      );
                                    }
                                  },
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (selectedPersonality != null && overlayPosition != null)
                      Positioned(
                        left: overlayPosition!.dx,
                        top: overlayPosition!.dy,
                        child: Material(
                          elevation: 8,
                          borderRadius: BorderRadius.circular(16),
                          color: Colors.transparent,
                          child: Container(
                            width: containerWidth,
                            height: containerHeight,
                            padding: const EdgeInsets.all(12.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: Color(0xff1D1616),
                              border: Border.all(
                                  color: Color(0xff8E1616), width: 2),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.asset(
                                    selectedPersonality!['image'],
                                    height: 100,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  selectedPersonality!['name'],
                                  style: const TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xff8E1616),
                                    fontFamily: "Karma",
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  "Power: ${selectedPersonality!['power']}",
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontStyle: FontStyle.italic,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                const SizedBox(height: 10),
                                ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      selectedPersonality =
                                          null; // Clear the selection
                                      overlayPosition = null;
                                    });
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Color(0xff8E1616),
                                  ),
                                  child: const Text(
                                    "Close",
                                    style: TextStyle(
                                        fontFamily: "Karma",
                                        fontSize: 18,
                                        color: Color(0xffEEEEEE)),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
