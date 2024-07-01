import 'package:flutter/material.dart';

class Category {
  final int? categoryId;
  final String name;
  final String icon;
  final Widget? url;
  final List<Category> subcategories;

  Category({
    this.categoryId,
    required this.name,
    required this.icon,
    this.url,
    this.subcategories = const [],
  });
}
