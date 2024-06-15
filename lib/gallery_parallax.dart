import 'package:flutter/material.dart';

import 'gallery_card.dart';
import 'images.dart';

class GalleryParallax extends StatefulWidget {
  const GalleryParallax({super.key});

  @override
  State<StatefulWidget> createState() => _GalleryParallax();
}

class _GalleryParallax extends State<GalleryParallax> {
  final controller = ScrollController();
  var scrollOffset = 0.0;

  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      setState(() {
        scrollOffset = controller.offset;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      controller: controller,
      child: Container(
        color: Colors.white,
        child: Row(
          children: [
            ...List.generate(images.length, (index) {
              return Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: GalleryCard(
                  screenWidth: width,
                  scrollOffset: scrollOffset,
                  image: images[index],
                  index: index,
                ),
              );
            })
          ],
        ),
      ),
    );
  }
}
