import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:napoleon_quiz_game/pages/home/profile/profile_page.dart';

Widget buildQuizText(BuildContext context, String text, Color color) {
  return Text(
    text,
    style: TextStyle(fontSize: 17, color: color, fontFamily: "Karma"),
  );
}

Widget buildIntroText(BuildContext context, String text) {
  return Text(
    text,
    style: const TextStyle(
        fontSize: 28,
        fontFamily: "Karma",
        color: Color(0xffF40101),
        fontWeight: FontWeight.w400),
  );
}

Widget buildQuizContainer(BuildContext context, String text, Color color) {
  final height = MediaQuery.of(context).size.height;
  return Padding(
    padding: const EdgeInsets.all(10.0),
    child: Container(
      width: double.infinity,
      height: height * 0.06,
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.circular(15)),
      child: Center(
          child: Text(
        text,
        style: const TextStyle(
            fontFamily: "Karma", fontSize: 18, color: Color(0xffEEEEEE)),
      )),
    ),
  );
}

Widget buildQuizImage(BuildContext context, ImageProvider image) {
  final height = MediaQuery.of(context).size.height;
  final width = MediaQuery.of(context).size.width;

  return Image(width: width * 0.4, height: height * 0.4, image: image);
}

Widget buildProfileImage(BuildContext context, ImageProvider image) {
  final width = MediaQuery.of(context).size.width;

  return Container(
    width: width * 0.28,
    height: width * 0.28,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      image: DecorationImage(
        image: image,
        fit: BoxFit.cover,
      ),
    ),
  );
}

Widget buildProfileTextField(String label, TextEditingController controller,
    {bool isAgeField = false}) {
  return Container(
    width: double.infinity,
    decoration: BoxDecoration(
      boxShadow: const [
        BoxShadow(
          color: Colors.black26,
          blurRadius: 6.0,
          offset: Offset(0, 3),
        ),
      ],
      borderRadius: BorderRadius.circular(15.0),
    ),
    child: TextField(
      controller: controller,
      style: const TextStyle(color: Colors.black, fontFamily: "Karma"),
      cursorColor: const Color(0xffF43135), // Change the cursor color here
      inputFormatters: isAgeField
          ? [FilteringTextInputFormatter.digitsOnly] // Only digits for age
          : [], // No restrictions for other fields
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.grey, fontFamily: "Karma"),
        filled: true,
        fillColor: Colors.white,
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red, width: 2.0),
          borderRadius: BorderRadius.circular(15.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide:
              BorderSide(color: Colors.red.withOpacity(0.5), width: 1.5),
          borderRadius: BorderRadius.circular(15.0),
        ),
      ),
    ),
  );
}

Widget buildBackground(BuildContext context) {
  final height = MediaQuery.of(context).size.height;
  final width = MediaQuery.of(context).size.width;

  return Container(
    width: width,
    height: height,
    decoration: const BoxDecoration(
      image: DecorationImage(
        image: AssetImage('images/fundal.jpg'), // Imaginea ta de fundal
        fit: BoxFit.cover, // Asigură-te că imaginea acoperă întregul ecran
      ),
    ),
  );
}

Widget buildHeight(BuildContext context, double percentage) {
  final height = MediaQuery.of(context).size.height;
  return SizedBox(height: height * percentage);
}

Widget buildWidth(BuildContext context, double percentage) {
  final width = MediaQuery.of(context).size.width;
  return SizedBox(width: width * percentage);
}

Widget buildSettingsIcon(BuildContext context) {
  return const Icon(
    Icons.settings,
    size: 30,
    color: Colors.black,
  );
}

Widget buildProfileEditbuton(BuildContext context) {
  final height = MediaQuery.of(context).size.height;
  final width = MediaQuery.of(context).size.width;

  return Container(
    height: height * 0.05,
    width: width * 0.35,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.1),
          blurRadius: 5,
          offset: const Offset(0, 3),
        ),
      ],
    ),
    child: Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            "EDIT PROFILE",
            style: TextStyle(
                fontSize: 12,
                fontFamily: "Karma",
                fontWeight: FontWeight.w400,
                color: Colors.black),
          ),
          GestureDetector(
              onTap: () async {
                final result = await Navigator.push(
                    context,
                    CupertinoPageRoute(
                        builder: (context) => const ProfilePage()));
              },
              child: const Icon(Icons.arrow_drop_down))
        ],
      ),
    ),
  );
}

Widget buildback(BuildContext context, VoidCallback onTap) {
  return GestureDetector(
    onTap: () {
      onTap();
    },
    child: const Padding(
      padding: EdgeInsets.only(left: 15.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.arrow_back_ios,
            color: Color(0xffD84040),
          ),
        ],
      ),
    ),
  );
}
