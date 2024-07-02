import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FullscreenImageView extends StatefulWidget {
  const FullscreenImageView({super.key, this.imageUrl});

  final String? imageUrl;

  @override
  State<FullscreenImageView> createState() => _FullscreenImageViewState();
}

class _FullscreenImageViewState extends State<FullscreenImageView> {
  @override
  void initState() {
    super.initState();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OrientationBuilder(
        builder: (context, orientation) {
          return Center(
            child: InteractiveViewer(
              clipBehavior: Clip.none,
              minScale: 1,
              maxScale: 3,
              child: CachedNetworkImage(
                imageUrl: widget.imageUrl!,
                fit: (orientation == Orientation.portrait)
                    ? BoxFit.fitHeight
                    : BoxFit.fitWidth,
              ),
            ),
          );
        },
        // Image.asset(
        //         'assets/1.png',
        //         fit: (orientation == Orientation.portrait)
        //             ? BoxFit.fitHeight
        //             : BoxFit.fitWidth,
        //       ),
      ),
      floatingActionButton: FloatingActionButton.small(
        child: const Icon(
          Icons.close_rounded,
        ),
        onPressed: () => Navigator.pop(context),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
    );
  }
}
