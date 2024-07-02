import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:home_design_3d/provider/gallery_provider.dart';
import 'package:home_design_3d/widget/image_gallery.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:share_plus/share_plus.dart';

class CategoryView extends StatefulWidget {
  const CategoryView(
      {super.key,
      required this.categoryId,
      this.indianId,
      this.europeanId,
      this.westernId,
      required this.name});

  final int categoryId;
  final int? indianId;
  final int? europeanId;
  final int? westernId;
  final String name;

  @override
  State<CategoryView> createState() => _CategoryViewState();
}

class _CategoryViewState extends State<CategoryView> {
  @override
  void initState() {
    super.initState();

    final provider = Provider.of<GalleryProvider>(context, listen: false);
    provider.fetchImages(widget.categoryId);
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<GalleryProvider>(context, listen: false);

    provider.setInformation(
      widget.categoryId,
      widget.indianId,
      widget.europeanId,
      widget.westernId,
    );

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.name),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              // Premium Version Notice
              const Text(
                "Buy the Premium version to get ad-free experience!",
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              // Category Selection
              widget.indianId != null
                  ? Consumer<GalleryProvider>(
                      builder: (context, gallery, child) {
                        return SegmentedButton<HouseStyle>(
                          segments: const <ButtonSegment<HouseStyle>>[
                            ButtonSegment<HouseStyle>(
                              value: HouseStyle.all,
                              label: Text('All'),
                            ),
                            ButtonSegment<HouseStyle>(
                              value: HouseStyle.indian,
                              label: Text('Indian'),
                            ),
                            ButtonSegment<HouseStyle>(
                              value: HouseStyle.european,
                              label: Text('European'),
                            ),
                            ButtonSegment<HouseStyle>(
                              value: HouseStyle.western,
                              label: Text('Western'),
                            ),
                          ],
                          selected: gallery.selectedHouseStyle,
                          onSelectionChanged: (Set<HouseStyle> newSelection) {
                            gallery.changeHouseStyle(newSelection);
                            gallery.changeImage(0);

                            if (newSelection.first == HouseStyle.all) {
                              gallery.fetchImages(provider.categoryId);
                            } else if (newSelection.first ==
                                HouseStyle.indian) {
                              gallery.fetchImages(provider.indianId);
                            } else if (newSelection.first ==
                                HouseStyle.european) {
                              gallery.fetchImages(provider.europeanId);
                            } else if (newSelection.first ==
                                HouseStyle.western) {
                              gallery.fetchImages(provider.westernId);
                            }
                          },
                        );
                      },
                    )
                  : const SizedBox(),

              // Image Control Buttons
              const SizedBox(
                height: 20,
              ),

              // Download Button
              Consumer<GalleryProvider>(
                builder: (context, gallery, child) {
                  return gallery.isLoading
                      ? Container()
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            IconButton(
                              icon: const Icon(
                                Icons.download_rounded,
                                size: 30,
                                color: Colors.white,
                              ),
                              color: Theme.of(context).colorScheme.primary,
                              style: ButtonStyle(
                                backgroundColor: WidgetStatePropertyAll(
                                  Theme.of(context).colorScheme.primary,
                                ),
                              ),
                              onPressed: () async {
                                String url = provider
                                    .images[provider.selectedImage].sourceUrl;
                                final response = await http.get(Uri.parse(url));
                                if (response.statusCode == 200) {
                                  final result =
                                      await ImageGallerySaver.saveImage(
                                    Uint8List.fromList(response.bodyBytes),
                                    name: provider
                                        .images[provider.selectedImage].id
                                        .toString(),
                                  );

                                  if (result['isSuccess']) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text('Image Downloaded!'),
                                      ),
                                    );
                                  }
                                } else {
                                  debugPrint(
                                      "Error downloading image: ${response.statusCode}");
                                }
                              },
                            ),

                            // Share Button
                            IconButton(
                              icon: const Icon(
                                Icons.share_rounded,
                                size: 30,
                                color: Colors.white,
                              ),
                              color: Theme.of(context).colorScheme.primary,
                              style: ButtonStyle(
                                backgroundColor: WidgetStatePropertyAll(
                                  Theme.of(context).colorScheme.primary,
                                ),
                              ),
                              onPressed: () async {
                                final url = Uri.parse(provider
                                    .images[provider.selectedImage].sourceUrl);
                                final response = await http.get(url);
                                final bytes = response.bodyBytes;

                                final temp = await getTemporaryDirectory();
                                final path = "${temp.path}/image.jpg";
                                File(path).writeAsBytesSync(bytes);
                                await Share.shareXFiles([XFile(path)],
                                    text:
                                        "Checkout more beautiful images in House Design 3D by Ovijaan. Download now from Play Store!");
                              },
                            ),

                            // Favorite Button
                            IconButton(
                              icon: const Icon(
                                Icons.favorite_outline_rounded,
                                size: 30,
                                color: Colors.white,
                              ),
                              color: Theme.of(context).colorScheme.primary,
                              style: ButtonStyle(
                                backgroundColor: WidgetStatePropertyAll(
                                  Theme.of(context).colorScheme.primary,
                                ),
                              ),
                              onPressed: () {},
                            ),

                            // Premium Button
                            IconButton(
                              icon: const Icon(
                                Icons.workspace_premium_rounded,
                                size: 30,
                                color: Colors.white,
                              ),
                              color: Theme.of(context).colorScheme.primary,
                              style: ButtonStyle(
                                backgroundColor: WidgetStatePropertyAll(
                                  Theme.of(context).colorScheme.primary,
                                ),
                              ),
                              onPressed: () {},
                            ),
                          ],
                        );
                },
              ),

              const SizedBox(
                height: 10,
              ),

              // Image Gallery
              const ImageGallery(),
            ],
          ),
        ),
      ),
    );
  }
}
