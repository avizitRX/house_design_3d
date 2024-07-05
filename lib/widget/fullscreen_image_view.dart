import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:home_design_3d/provider/favorite_provider.dart';
import 'package:provider/provider.dart';

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
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Consumer<FavoriteProvider>(
              builder: (context, favorite, child) {
                return FloatingActionButton.small(
                  onPressed: () async {
                    await favorite.favoriteController(widget.imageUrl ?? "");
                  },
                  child: Icon(
                    favorite.favoriteImages.contains(widget.imageUrl)
                        ? Icons.favorite_rounded
                        : Icons.favorite_outline_rounded,
                    size: 30,
                    color: Colors.deepOrange,
                  ),
                );
              },
            ),
            FloatingActionButton.small(
              onPressed: () => Navigator.pop(context),
              child: const Icon(Icons.close_rounded),
            )
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
    );
  }
}


// const Icon(
//           Icons.close_rounded,
//         ),