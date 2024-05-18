import 'package:flutter/material.dart';

class MBChip extends Chip {
  final double? radius;

  MBChip({
    Key? key,
    this.radius,
    required super.label,
    super.labelPadding,
    super.deleteIcon,
    super.onDeleted,
    super.deleteIconColor,
    super.deleteButtonTooltipMessage,
    super.side,
    // super.shape,
    super.clipBehavior = Clip.none,
    super.focusNode,
    super.autofocus = false,
    super.backgroundColor,
    super.padding,
    super.visualDensity,
    super.materialTapTargetSize,
    super.elevation,
    super.shadowColor,
    super.surfaceTintColor,
    super.iconTheme,
    RoundedRectangleBorder? shape,
    TextStyle? style,
    Color? color,
  }) : super(
    key: key,
    shape: radius != null && radius > 0
        ? RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(radius),
    ) : shape,
    labelStyle: style ?? TextStyle(color: color),
  );
}