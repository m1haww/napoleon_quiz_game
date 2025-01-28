import 'package:flutter/material.dart';
import 'package:napoleon_quiz_game/models/System.dart';

class System extends ChangeNotifier {
  Profile? profile;
  int _coins = 0;
  final List<Map<String, dynamic>> _purchasedPersonalities = [];

  void addProfile(Profile prof) {
    profile = prof;
    notifyListeners();
  }

  int get coins => _coins;
  List<Map<String, dynamic>> get purchasedPersonalities =>
      _purchasedPersonalities;
  void addCoins(int amount) {
    _coins += amount;
    notifyListeners();
  }

  void deductCoins(int amount) {
    if (_coins >= amount) {
      _coins -= amount;
      notifyListeners();
    }
  }

  bool purchasePersonality(Map<String, dynamic> personality) {
    final price = personality['price'] as int;
    if (_coins >= price) {
      // Check if the user has enough coins
      _coins -= price; // Deduct the price
      _purchasedPersonalities.add(personality); // Add the purchased personality
      notifyListeners(); // Notify listeners of state changes
      return true; // Indicate the purchase was successful
    } else {
      return false; // Indicate the purchase failed due to insufficient coins
    }
  }
}
