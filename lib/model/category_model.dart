import 'package:flutter/material.dart';

class Category {
  final int? categoryId;
  final int? indianId;
  final int? europeanId;
  final int? westernId;
  final String name;
  final String icon;
  final Widget? url;
  final List<Category> subcategories;

  Category({
    this.categoryId,
    this.indianId,
    this.europeanId,
    this.westernId,
    required this.name,
    required this.icon,
    this.url,
    this.subcategories = const [],
  });
}
