import 'package:flutter/material.dart';
import 'package:home_design_3d/provider/gallery_provider.dart';
import 'package:home_design_3d/widget/image_gallery.dart';
import 'package:provider/provider.dart';

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

              // Image Gallery
              const ImageGallery(),
            ],
          ),
        ),
      ),
    );
  }
}
