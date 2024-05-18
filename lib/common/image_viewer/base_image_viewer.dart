import 'package:mon/common/base_button.dart';
import 'package:mon/common/base_image.dart';
import 'package:mon/common/base_screen.dart';
import 'package:mon/common/base_sized_box.dart';
import 'package:mon/common/base_stateless_widget.dart';
import 'package:mon/theme/colors.dart';
import 'package:mon/web_service/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'base_image_viewer_data.dart';

class ImageViewer extends StatefulWidget {
  final List<BaseImageViewerData> items;
  final Widget Function(
      BuildContext context, BaseImageViewerData object, int index)? builder;
  final Function(int index, CarouselPageChangedReason reason)? onPageChanged;
  final double? height;
  final double? aspectRatio;
  final int? initialPage;
  final bool? enableInfiniteScroll;
  final bool? autoPlay;
  final int? autoPlayInterval;
  final Curve? autoPlayCurve;
  final Axis? scrollDirection;
  final CarouselOptions? options;

  static String get id {
    const Type type = ImageViewer;
    return '$type';
  }

  const ImageViewer({
    required this.items,
    required this.height,
    this.aspectRatio,
    this.initialPage,
    this.enableInfiniteScroll,
    this.autoPlayCurve,
    this.options,
    this.autoPlay,
    this.autoPlayInterval,
    this.scrollDirection,
    this.builder, this.onPageChanged, Key? key})
      : super(key: key);

  @override
  State<ImageViewer> createState() => _ImageViewerState();
}

class _ImageViewerState extends State<ImageViewer> {
  bool _isImageVisible = false;
  int _index = 0;

  Widget getImage(BuildContext context, BaseImageViewerData item, int index) {
    if (item.object != null) {
      return widget.builder!(context, item, index);
    } else if (item.url != null) {
      return DefaultImageViewerCell(
        url: item.url,
      );
    } else if (item.image != null) {
      return item.image!;
    }
    return DefaultImageViewerCell(
      url: item.url,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
            items: widget.items
                .asMap()
                .entries
                .map((entry) {
              return Builder(
                builder: (BuildContext context) {
                  final int index = entry.key;
                  final BaseImageViewerData item = entry.value;
                  return InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              ImagePreview(
                                items: widget.items,
                                index: index,
                              )));
                    },
                    child: getImage(context, item, index),
                  );
                },
              );
            }).toList(),
            options: widget.options ?? CarouselOptions(
              height: widget.height ?? 400,
              aspectRatio: widget.aspectRatio ?? 16 / 9,
              viewportFraction: 1,
              initialPage: widget.initialPage ?? 0,
              enableInfiniteScroll: widget.enableInfiniteScroll ?? true,
              reverse: false,
              autoPlay: widget.autoPlay ?? true,
              autoPlayInterval: widget.autoPlayInterval != null ? Duration(
                  seconds: widget.autoPlayInterval!) : const Duration(
                  seconds: 3),
              autoPlayAnimationDuration: const Duration(milliseconds: 800),
              autoPlayCurve: widget.autoPlayCurve ?? Curves.fastOutSlowIn,
              enlargeCenterPage: true,
              enlargeFactor: 0.3,
              onPageChanged: widget.onPageChanged,
              scrollDirection: widget.scrollDirection ?? Axis.horizontal,
            )),
      ],
    );
  }
}

class DefaultImageViewerCell extends StatelessWidget {
  final String? url;

  const DefaultImageViewerCell({this.url, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 5.0),
        // decoration: const BoxDecoration(color: Colors.amber),
        child: MBImage(url, radius: 20,)
      // child: Text('text $i', style: TextStyle(fontSize: 16.0),)
    );
  }
}

class ImagePreview extends MBStatelessWidget {
  final List<BaseImageViewerData> items;
  final int index;

  const ImagePreview({Key? key, required this.items, required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MBScaffold(
      hideAppBar: true,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(top: 20.0),
        child: Transform.scale(
          scale: 0.8,
          child: MBButton(
            icon: const Icon(Icons.close), background: AppColors.gray_50.withAlpha(50), color: AppColors.white, isRounded: true, onPressed: () {
            pop();
          },),
        ),
      ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      body: PhotoViewGallery.builder(
        scrollPhysics: const BouncingScrollPhysics(),
        builder: (BuildContext context, int index) {
          return PhotoViewGalleryPageOptions.customChild(
              child: MBImage(items[index].url, fit: BoxFit.contain));
        },
        itemCount: items.length,
        loadingBuilder: (context, event) =>
            Center(
              child: SizedBox(
                width: 20.0,
                height: 20.0,
                child: CircularProgressIndicator(
                  value: event == null ? 0 : event.cumulativeBytesLoaded / (event.expectedTotalBytes ?? 0),
                ),
              ),
            ),
        pageController: PageController(initialPage: index),
        backgroundDecoration: const BoxDecoration(
            color: AppColors.black
        ),
        // backgroundDecoration: widget.backgroundDecoration,
        // onPageChanged: onPageChanged,
      ), title: localization.imagesViewer,
    );
  }
}