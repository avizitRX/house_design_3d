import 'package:flutter/material.dart';
import 'package:home_design_3d/widget/image_gallery.dart';

class CategoryView extends StatefulWidget {
  const CategoryView({super.key, required this.categoryId, required this.name});

  final int categoryId;
  final String name;

  @override
  State<CategoryView> createState() => _CategoryViewState();
}

class _CategoryViewState extends State<CategoryView> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.name),
        ),
        body: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: [
              ImageGallery(),
            ],
          ),
        ),
      ),
    );
  }
}
