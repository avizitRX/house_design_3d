import 'package:flutter/material.dart';
import 'package:home_design_3d/widget/homepage_ad_slider.dart';
import 'package:ripple_effect/ripple_widget.dart';

import '../widget/categories_section.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            const Image(
              image: AssetImage('assets/up.jpg'),
            ),
            RippleEffect(
              dampening: 0.97,
              child: Container(
                padding: const EdgeInsets.only(top: 30, bottom: 40),
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/down.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),

            // Categories Section
            const Expanded(
              child: CategoriesSection(),
            ),

            // Ad Slider
            const HomepageAdSlider(),
          ],
        ),
      ),
    );
  }
}
