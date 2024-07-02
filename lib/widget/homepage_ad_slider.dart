import 'dart:async';
import 'dart:math';

import 'package:banner_carousel/banner_carousel.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HomepageAdSlider extends StatefulWidget {
  const HomepageAdSlider({super.key});

  @override
  State<HomepageAdSlider> createState() => _HomepageAdSliderState();
}

class _HomepageAdSliderState extends State<HomepageAdSlider> {
  List<BannerModel> listAds = [
    BannerModel(imagePath: 'assets/images/ad/ad1.png', id: "1"),
    BannerModel(imagePath: 'assets/images/ad/ad2.png', id: "2"),
  ];

  Future<void> _launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $url');
    }
  }

  PageController? _pageController;
  var _timer;

  @override
  void initState() {
    super.initState();
    int adNumber = Random().nextInt(2);

    _pageController = PageController(
      initialPage: adNumber,
    );
    _timer = Timer.periodic(
      const Duration(seconds: 10),
      (Timer timer) {
        if (_pageController?.page == 1.0) {
          _pageController?.animateTo(
            0,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeIn,
          );
        } else {
          _pageController?.nextPage(
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeIn,
          );
        }
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    Uri toLaunch;

    return SizedBox(
      height: 100,
      child: BannerCarousel(
        pageController: _pageController,
        showIndicator: false,
        customizedBanners: [
          GestureDetector(
            onTap: () async {
              toLaunch = Uri(
                scheme: 'https',
                host: 'avizitrx.com',
              );
              _launchInBrowser(toLaunch);
            },
            child: Image.asset(
              'assets/ad/ad1.png',
              fit: BoxFit.contain,
            ),
          ),
          GestureDetector(
            onTap: () async {
              toLaunch = Uri(
                scheme: 'https',
                host: 'www.youtube.com',
                path: '@dreamhomebd',
              );
              _launchInBrowser(toLaunch);
            },
            child: Image.asset(
              'assets/ad/ad2.png',
              fit: BoxFit.contain,
            ),
          ),
        ],
      ),
    );
  }
}
