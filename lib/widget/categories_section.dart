import 'package:flutter/material.dart';
import 'package:home_design_3d/screen/category_view.dart';

import '../data/categories.dart';

class CategoriesSection extends StatefulWidget {
  const CategoriesSection({super.key});

  @override
  State<CategoriesSection> createState() => _CategoriesSectionState();
}

class _CategoriesSectionState extends State<CategoriesSection> {
  // InterstitialAd? _interstitialAd;

  @override
  void initState() {
    super.initState();
    // _createInterstitialAd();
  }

  // void _createInterstitialAd() {
  //   InterstitialAd.load(
  //     adUnitId: AdmobServices.interstitialAdUnitId!,
  //     request: const AdRequest(),
  //     adLoadCallback: InterstitialAdLoadCallback(
  //       onAdLoaded: (ad) => _interstitialAd = ad,
  //       onAdFailedToLoad: (LoadAdError error) => _interstitialAd = null,
  //     ),
  //   );
  // }

  // void _showInterstitialAd(url) {
  //   if (_interstitialAd != null) {
  //     _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
  //       onAdDismissedFullScreenContent: (ad) {
  //         ad.dispose();
  //         _createInterstitialAd();

  //         Navigator.push(
  //           context,
  //           MaterialPageRoute(
  //             builder: (context) => url,
  //           ),
  //         );
  //       },
  //       onAdFailedToShowFullScreenContent: (ad, error) {
  //         ad.dispose();
  //         _createInterstitialAd();
  //       },
  //     );
  //     _interstitialAd!.show();
  //     _interstitialAd = null;
  //   }
  // }

  @override
  void dispose() {
    super.dispose();
    // _interstitialAd!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: categories.length,
      itemBuilder: (_, index) {
        var category = categories[index];
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                category.name,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),

              const SizedBox(
                height: 5,
              ),

              // Sub Category
              Column(
                children: [
                  LayoutBuilder(
                    builder: (context, constraints) {
                      int crossAxisCount = 3; // Default to 3 columns

                      if (constraints.maxWidth < 350) {
                        crossAxisCount =
                            2; // Change to 2 columns for smaller screens
                      }
                      return GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: crossAxisCount,
                          crossAxisSpacing: 20,
                          mainAxisSpacing: 20,
                        ),
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: category.subcategories.length,
                        itemBuilder: (context, subIndex) {
                          final subcategory = category.subcategories[subIndex];
                          return GestureDetector(
                            onTap: () {
                              // _showInterstitialAd(subcategory.url);
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //       builder: (context) => subcategory.url!),
                              // );
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CategoryView(
                                    categoryId: subcategory.categoryId!,
                                    indianId: subcategory.indianId,
                                    europeanId: subcategory.europeanId,
                                    westernId: subcategory.westernId,
                                    name: subcategory.name,
                                  ),
                                ),
                              );
                            },
                            child: Column(
                              children: [
                                Card(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .primaryContainer,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                        width: double.infinity,
                                        height: 50,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: AssetImage(subcategory.icon),
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                    ],
                                  ),
                                ),
                                Text(
                                  subcategory.name,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
