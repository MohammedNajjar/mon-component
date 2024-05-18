import 'dart:ffi';

import 'package:flutter/material.dart';

class MBContainer extends Container {
  final double? radius;
  final bool isRounded;
  final Color? borderColor;
  final double? borderWidth;
  final double? spreadRadius;
  final double? blurRadius;
  final Color? shadowColor;
  final Offset? shadowOffset;

  MBContainer({
    Key? key,
    this.radius,
    this.isRounded = false,
    this.borderColor,
    this.spreadRadius,
    this.blurRadius,
    this.shadowColor,
    this.shadowOffset,
    this.borderWidth,
    super.alignment,
    super.padding,
    // super.color,
    super.foregroundDecoration,
    super.width,
    super.height,
    super.constraints,
    super.margin,
    super.transform,
    super.transformAlignment,
    super.child,
    super.clipBehavior = Clip.none,
    Color? color,
    BoxDecoration? decoration,
  }) : super(
    key: key,
    color: (radius != null || isRounded) ? null: color,
    decoration: ((radius != null && radius > 0) || isRounded || ((shadowColor != null && shadowOffset != null && spreadRadius != null && blurRadius != null)))
        ? BoxDecoration(
      color: color,
      boxShadow: (shadowColor != null && shadowOffset != null && spreadRadius != null && blurRadius != null) ? [
        BoxShadow(
          color: shadowColor,
          spreadRadius: spreadRadius,
          blurRadius: blurRadius,
          offset: shadowOffset, // adjust the offset to control the shadow position
        ),
      ] : [],
      // border: Border.all(
      //   color: Colors.black,
      //   width: 2,
      // ),
      border: ((borderWidth != null) && (borderColor != null)) ? Border.all(
        color: borderColor,
        width: borderWidth,
      ) : null,
        shape: (isRounded == true) ? BoxShape.circle : BoxShape.rectangle,
      borderRadius: (isRounded == true) ? null : BorderRadius.circular(radius ?? 0),
    ) : decoration,
  );
}