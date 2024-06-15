import 'package:flutter/material.dart';

class GalleryCard extends StatelessWidget {
  final String image;
  final int index;
  final double screenWidth;
  final double scrollOffset;

  const GalleryCard(
      {super.key,
      required this.image,
      required this.index,
      required this.screenWidth,
      required this.scrollOffset});

  @override
  Widget build(BuildContext context) {
    // basic calculations
    final itemWidth = screenWidth / 2.85;
    final itemHeight = itemWidth * 1.5;
    final marginOffset = 8 * (index + 1);
    final lowerRange = (index * itemWidth) + marginOffset;
    final highRange = ((index + 1) * itemWidth) + marginOffset;

    // left side calculations
    final isInLeftSideRange = scrollOffset >= lowerRange && scrollOffset <= highRange;
    final leftSideOffset = highRange - scrollOffset;
    final leftSideDivisor = index > 0 ? (lowerRange - marginOffset) / index : highRange - marginOffset;

    // right side calculations
    final rightSideScrollOffset = lowerRange - scrollOffset;
    final rightSideOffsetThreshold = screenWidth - (itemWidth * 0.85);
    final isInRightSideRange = rightSideScrollOffset > rightSideOffsetThreshold && rightSideScrollOffset < screenWidth;
    final rightSideOffset = rightSideScrollOffset - rightSideOffsetThreshold;
    final rightSideDivisor = screenWidth - rightSideOffsetThreshold + marginOffset;

    // final calculations
    final offset = isInLeftSideRange ? leftSideOffset : rightSideOffset;
    final divisor = isInLeftSideRange ? leftSideDivisor : rightSideDivisor;
    final fractionOffset = (offset < 0 ? 1 : offset) / divisor;
    final leftParallaxPercent = isInLeftSideRange ? (1 - fractionOffset) : 0.0;
    final rightParallaxPercent = isInRightSideRange ? fractionOffset : 1.0;
    final leftPercent = -leftParallaxPercent;
    final rightPercent = rightParallaxPercent;

    return Container(
      width: itemWidth,
      height: itemHeight,
      clipBehavior: Clip.antiAlias,
      decoration: const BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.all(Radius.circular(24))),
      child: Image.asset(
        image,
        fit: BoxFit.cover,
        alignment: Alignment(
            isInLeftSideRange ? leftPercent : (isInRightSideRange ? rightPercent : 0.0),
            0
        ),
      ),
    );
  }
}
