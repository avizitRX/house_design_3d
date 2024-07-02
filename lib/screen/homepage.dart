import 'package:flutter/material.dart';
import 'package:home_design_3d/widget/homepage_ad_slider.dart';

import '../widget/categories_section.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              child: CategoriesSection(),
            ),
            HomepageAdSlider(),
          ],
        ),
      ),
    );
  }
}
