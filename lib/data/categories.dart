import '../model/category_model.dart';

List<Category> categories = [
  Category(
    name: 'Exterior Designs',
    icon: "",
    subcategories: [
      Category(
        categoryId: 2,
        indianId: 14,
        europeanId: 15,
        westernId: 16,
        name: "Tin Shade House",
        icon: "assets/icon/tin-shade.png",
      ),
      Category(
        categoryId: 3,
        indianId: 11,
        europeanId: 12,
        westernId: 13,
        name: "1 Story House",
        icon: "assets/icon/one-story.png",
      ),
      Category(
        categoryId: 4,
        indianId: 23,
        europeanId: 24,
        westernId: 25,
        name: "Duplex House",
        icon: "assets/icon/duplex.png",
      ),
      Category(
        categoryId: 5,
        indianId: 17,
        europeanId: 18,
        westernId: 19,
        name: "3 Story House",
        icon: "assets/icon/three-story.png",
      ),
      Category(
        categoryId: 6,
        indianId: 20,
        europeanId: 21,
        westernId: 22,
        name: "4 Story House",
        icon: "assets/icon/four-story.png",
      ),
      Category(
        categoryId: 7,
        indianId: 26,
        europeanId: 27,
        westernId: 28,
        name: "High-Rise House",
        icon: "assets/icon/high-rise.png",
      ),
    ],
  ),
  Category(
    name: "Interior Designs",
    icon: "",
    subcategories: [
      Category(
        categoryId: 8,
        name: "Living Room",
        icon: "assets/icon/living-room.png",
      ),
      Category(
        categoryId: 9,
        name: "Kitchen Room",
        icon: "assets/icon/kitchen-room.png",
      ),
      Category(
        categoryId: 10,
        name: "Bed Room",
        icon: "assets/icon/bedroom.png",
      ),
    ],
  ),
];
