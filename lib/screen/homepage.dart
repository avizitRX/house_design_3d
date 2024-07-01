import 'package:flutter/material.dart';

import '../widget/categories_section.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        body: CategoriesSection(),
      ),
    );
  }
}
