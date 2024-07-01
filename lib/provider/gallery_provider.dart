import 'package:flutter/material.dart';

class GalleryProvider with ChangeNotifier {
  int _selectedImage = 0;
  int get selectedImage => _selectedImage;

  void changeImage(int val) {
    _selectedImage = val;
    notifyListeners();
  }
}
