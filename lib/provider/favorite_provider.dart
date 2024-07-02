import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoriteProvider with ChangeNotifier {
  List<String> _favoriteImages = [];
  List<String> get favoriteImages => _favoriteImages;

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  Future<void> syncFavoriteImages() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    _favoriteImages = prefs.getStringList('favoriteImages') ?? [];

    _isLoading = false;
    notifyListeners();
  }

  Future<void> favoriteController(String imageUrl) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    _favoriteImages = prefs.getStringList('favoriteImages') ?? [];

    if (favoriteImages.contains(imageUrl)) {
      favoriteImages.remove(imageUrl);
      await prefs.setStringList('favoriteImages', favoriteImages);
    } else {
      favoriteImages.add(imageUrl);
    }

    await prefs.setStringList('favoriteImages', favoriteImages);

    notifyListeners();
  }

  Future<List<String>> viewFavorites() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final List<String>? items = prefs.getStringList('favoriteImages');

    return items!;
  }
}
