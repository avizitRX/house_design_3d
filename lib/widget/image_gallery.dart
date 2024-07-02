import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:home_design_3d/provider/gallery_provider.dart';
import 'package:home_design_3d/widget/fullscreen_image_view.dart';
import 'package:infinite_carousel/infinite_carousel.dart';
import 'package:provider/provider.dart';

class ImageGallery extends StatefulWidget {
  const ImageGallery({super.key});

  @override
  State<ImageGallery> createState() => _ImageGalleryState();
}

class _ImageGalleryState extends State<ImageGallery> {
  late InfiniteScrollController imageController;

  @override
  void initState() {
    super.initState();

    imageController = InfiniteScrollController(
      initialItem: 0,
    );
  }

  @override
  void dispose() {
    super.dispose();
    imageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<GalleryProvider>(context, listen: false);

    provider.changeImage(0);

    return Consumer<GalleryProvider>(
      builder: (context, gallery, child) {
        return gallery.isLoading
            ? const Expanded(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              )
            : Column(
                children: [
                  SizedBox(
                    height: 250,
                    child: GestureDetector(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => FullscreenImageView(
                            imageUrl:
                                gallery.images[gallery.selectedImage].sourceUrl,
                          ),
                        ),
                      ),
                      child: CachedNetworkImage(
                        imageUrl:
                            gallery.images[gallery.selectedImage].sourceUrl,
                        fit: BoxFit.contain,
                        progressIndicatorBuilder:
                            (context, url, downloadProgress) => Center(
                          child: CircularProgressIndicator(
                              value: downloadProgress.progress),
                        ),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        color: Theme.of(context).colorScheme.primary,
                        style: ButtonStyle(
                          backgroundColor: WidgetStatePropertyAll(
                            Theme.of(context).colorScheme.primary,
                          ),
                        ),
                        onPressed: () {
                          imageController.previousItem();
                        },
                        icon: const Icon(
                          Icons.arrow_back_ios_new_rounded,
                          size: 30,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      IconButton(
                        color: Theme.of(context).colorScheme.primary,
                        style: ButtonStyle(
                          backgroundColor: WidgetStatePropertyAll(
                            Theme.of(context).colorScheme.primary,
                          ),
                        ),
                        onPressed: () {
                          imageController.nextItem();
                        },
                        icon: const Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: 30,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 80,
                    child: InfiniteCarousel.builder(
                      itemCount: provider.images.length,
                      itemExtent: 140,
                      center: true,
                      anchor: 0.0,
                      velocityFactor: 0.2,
                      scrollBehavior: kIsWeb
                          ? ScrollConfiguration.of(context).copyWith(
                              dragDevices: {
                                // Allows to swipe in web browsers
                                PointerDeviceKind.touch,
                                PointerDeviceKind.mouse
                              },
                            )
                          : null,
                      onIndexChanged: (index) {
                        if (provider.selectedImage != index) {
                          provider.changeImage(index);
                        }
                      },
                      controller: imageController,
                      axisDirection: Axis.horizontal,
                      loop: false,
                      itemBuilder: (context, itemIndex, realIndex) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5.0),
                          child: GestureDetector(
                            onTap: () {
                              imageController.animateToItem(realIndex);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: CachedNetworkImageProvider(
                                    gallery.images[realIndex].sourceUrl,
                                  ),
                                  fit: BoxFit.fill,
                                ),
                              ),
                              child: Stack(
                                children: [
                                  // Show a centered CircularProgressIndicator while image is loading
                                  const Center(
                                    child: CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                          Colors
                                              .grey), // Adjust color as needed
                                    ),
                                  ),
                                  Image(
                                    image: CachedNetworkImageProvider(
                                      gallery.images[realIndex].sourceUrl,
                                    ),
                                    fit: BoxFit.fill,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
      },
    );
  }
}
