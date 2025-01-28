import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:napoleon_quiz_game/appprovider/system.dart';
import 'package:napoleon_quiz_game/models/Functions.dart';
import 'package:napoleon_quiz_game/models/System.dart';

import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late final TextEditingController nameController;
  late final TextEditingController ageController;
  bool _salvat = false;

  File? _selectedImage; // For mobile
  Uint8List? _imageData; // For web
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    ageController = TextEditingController();

    // Add listeners
    nameController.addListener(_updateSaveButtonState);
    ageController.addListener(_updateSaveButtonState);
  }

  @override
  void dispose() {
    // Remove listeners
    nameController.removeListener(_updateSaveButtonState);
    ageController.removeListener(_updateSaveButtonState);

    nameController.dispose();
    ageController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final XFile? pickedImage =
        await _picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      print("Image picked: ${pickedImage.path}");
      setState(() {
        if (kIsWeb) {
          // For Web, we use Uint8List for Image.memory
          pickedImage.readAsBytes().then((bytes) {
            setState(() {
              _imageData = bytes;
              print("Image data loaded for web: ${_imageData!.length} bytes");
            });
          }).catchError((e) {
            print("Error loading image data: $e");
          });
        } else {
          // For mobile, we use File for Image.file
          _selectedImage = File(pickedImage.path);
          print("Mobile image selected: ${_selectedImage!.path}");
        }
      });
    } else {
      print("No image selected.");
    }
  }

  void _updateSaveButtonState() {
    setState(() {
      _salvat = nameController.text.isNotEmpty && ageController.text.isNotEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<System>(context, listen: false);
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
            leading: buildback(context, () {
              Navigator.pop(context);
            }),
            centerTitle: false,
            title: buildIntroText(context, " Edit Profile"),
          ),
          body: Stack(
            children: [
              buildBackground(context),
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(40.0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        buildHeight(context, 0.028),
                        GestureDetector(
                          onTap: _pickImage,
                          child: _selectedImage == null
                              ? ClipOval(
                                  child: Image(
                                      image: const AssetImage(
                                          "images/image (9).png"),
                                      width: width * 0.30,
                                      height: width * 0.30,
                                      fit: BoxFit.cover))
                              : (kIsWeb
                                  ? (_imageData != null
                                      ? ClipOval(
                                          child: Image.memory(_imageData!,
                                              width: width * 0.30,
                                              height: width * 0.30,
                                              fit: BoxFit.cover))
                                      : ClipOval(
                                          child: Image(
                                              image: const AssetImage(
                                                  "images/image (9).png"),
                                              width: width * 0.30,
                                              height: width * 0.30,
                                              fit: BoxFit.cover)))
                                  : ClipOval(
                                      child: Image.file(_selectedImage!,
                                          width: width * 0.30,
                                          height: width * 0.30,
                                          fit: BoxFit.cover))),
                        ),
                        buildHeight(context, 0.04),
                        buildHeight(context, 0.04),
                        buildProfileTextField("Name", nameController),
                        buildHeight(context, 0.01),
                        buildProfileTextField("Age", ageController,
                            isAgeField: true),
                        buildHeight(context, 0.1),
                        GestureDetector(
                          onTap: _salvat
                              ? () {
                                  final model = Provider.of<System>(context,
                                      listen: false);
                                  final imageToSave =
                                      kIsWeb ? _imageData : _selectedImage;
                                  model.addProfile(Profile(
                                    mame: nameController.text,
                                    age: ageController.text,
                                    image: kIsWeb
                                        ? MemoryImage(_imageData!)
                                        : FileImage(_selectedImage!),
                                  ));
                                  Navigator.pop(context);
                                }
                              : () {
                                  // Show a SnackBar if not all fields are filled
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      backgroundColor: Color(0xff1D1616),
                                      content: Text(
                                        'Please complete all fields before confirming!',
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
                          child: buildQuizContainer(
                              context, "Confirm", const Color(0xffF43135)),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
