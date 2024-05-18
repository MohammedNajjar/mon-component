import 'package:mon/common/base_image.dart';
import 'package:mon/common/base_sized_box.dart';
import 'package:flutter/material.dart';

class MBCircleImage extends ClipRRect {
  final String? url;
  final double? width;
  final BoxFit? fit;
  final Color? borderColor;
  final double? borderWidth;
  final double? elevation;

  MBCircleImage(
    this.url, {
    Key? key,
    this.fit,
    this.width,
    this.borderColor,
    this.borderWidth,
    this.elevation,
    Color? color,
    BoxDecoration? decoration,
  }) : super(
          key: key,
          borderRadius: width != null ? BorderRadius.circular(width / 2) : null,
          child: MBSizedBox(
              width: width ?? 50,
              aspectRatio: 1,
              child: MBImage(
                url,
                fit: fit ?? BoxFit.fill,
              )),
        );
}
