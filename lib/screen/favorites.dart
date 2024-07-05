import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:home_design_3d/provider/favorite_provider.dart';
import 'package:home_design_3d/widget/fullscreen_image_view.dart';
import 'package:provider/provider.dart';

class Favorites extends StatefulWidget {
  const Favorites({super.key});

  @override
  State<Favorites> createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {
  @override
  void initState() {
    super.initState();
    final favoriteProvider =
        Provider.of<FavoriteProvider>(context, listen: false);
    favoriteProvider.syncFavoriteImages();
  }

  @override
  Widget build(BuildContext context) {
    final favoriteProvider =
        Provider.of<FavoriteProvider>(context, listen: false);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Favorites"),
        ),
        body: Consumer<FavoriteProvider>(
          builder: (context, favorite, child) {
            return favoriteProvider.isLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Stack(
                    children: [
                      Expanded(
                        child: GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio: 16 / 12,
                            crossAxisCount: 2,
                            mainAxisSpacing: 8.0,
                            crossAxisSpacing: 8.0,
                          ),
                          padding: const EdgeInsets.all(8.0),
                          itemCount: favoriteProvider.favoriteImages.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => FullscreenImageView(
                                      imageUrl: favoriteProvider
                                          .favoriteImages[index],
                                    ),
                                  ),
                                );
                              },
                              child: Card(
                                child: Center(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: CachedNetworkImageProvider(
                                          favorite.favoriteImages[index],
                                        ),
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),

                      // If there is no favorite item
                      favoriteProvider.favoriteImages.isEmpty
                          ? Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.heart_broken_rounded,
                                    size: 80,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                      "Looks like your favorites list is a bit lonely.",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge),
                                ],
                              ),
                            )
                          : Container(),
                    ],
                  );
          },
        ),
      ),
    );
  }
}
