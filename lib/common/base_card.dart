import 'package:flutter/material.dart';

class MBCard extends Card {
  final double? radius;

  MBCard({
    Key? key,
    this.radius,
    super.color,
    super.shadowColor,
    super.surfaceTintColor,
    super.elevation,
    super.borderOnForeground = true,
    super.margin,
    super.clipBehavior,
    super.semanticContainer = true,
    double? height,
    double? width,
    ShapeBorder? shape,
    Widget? child,
  }) : super(
    key: key,
    shape: radius != null && radius > 0
        ? RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(radius),
    )
        : shape,
    child: child,
  );
}