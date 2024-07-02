import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:home_design_3d/model/image_model.dart';
import 'package:http/http.dart' as http;

enum HouseStyle { all, indian, european, western }

class GalleryProvider with ChangeNotifier {
  int _selectedImage = 0;
  int get selectedImage => _selectedImage;

  Set<HouseStyle> _selectedHouseStyle = {HouseStyle.all};
  Set<HouseStyle> get selectedHouseStyle => _selectedHouseStyle;

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  // Category Information
  int? _categoryId = 0;
  int? _indianId = 0;
  int? _europeanId = 0;
  int? _westernId = 0;

  int? get categoryId => _categoryId;
  int? get indianId => _indianId;
  int? get europeanId => _europeanId;
  int? get westernId => _westernId;

  // Images from API
  List<ImageModel> _images = [];
  List<ImageModel> get images => _images;

  // Change the selected image
  void changeImage(int val) {
    _selectedImage = val;
    notifyListeners();
  }

  // Segmented Button Control
  void changeHouseStyle(Set<HouseStyle> newSelection) {
    _selectedHouseStyle = newSelection;
    notifyListeners();
  }

  // Save the categories in the provider
  void setInformation(
      int? categoryId, int? indianId, int? europeanId, int? westernId) {
    _categoryId = categoryId;
    _indianId = indianId;
    _europeanId = europeanId;
    _westernId = westernId;
    notifyListeners();
  }

  Future<void> fetchImages(id) async {
    _isLoading = true;

    // Fetch Data using REST API request and save that to _images list
    await dotenv.load(fileName: ".env");
    String? baseUrl = dotenv.env['baseUrl'];
    final response = await http.get(Uri.parse(
        '$baseUrl/media?media_category=$id&media_type=image&_fields=id,source_url'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      _images = data.map((item) => ImageModel.fromJson(item)).toList();

      if (_images.isNotEmpty) {
        _isLoading = false;
      }
    } else {
      SnackBar(
        content: const Text('Please check your internet connection!'),
        action: SnackBarAction(
          label: 'Retry',
          onPressed: () {
            fetchImages(id);
          },
        ),
      );
      throw Exception('Failed');
    }
    notifyListeners();
  }
}
