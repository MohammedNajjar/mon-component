import 'package:flutter/material.dart';

class MBSizedBox extends SizedBox {
  final double aspectRatio;
  const MBSizedBox({Key? key, required this.aspectRatio, double? height, double? width, Widget? child})
      : assert(aspectRatio > 0),
        super(
        key: key,
        height: height ?? (width != null ? width * aspectRatio : null),
        width: width ?? (height != null ? height / aspectRatio : null),
        child: child,
      );
}