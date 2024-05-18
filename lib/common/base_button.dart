import 'package:mon/common/base_container.dart';
import 'package:mon/common/base_text.dart';
import 'package:mon/theme/colors.dart';
import 'package:mon/theme/fonts.dart';
import 'package:flutter/material.dart';

enum MBButtonType { text, textIcon, elevation, elevationIcon }

class MBButton extends StatelessWidget {
  final String? text;
  final Widget? icon;
  final int? badgeCount;
  final Color? borderColor;
  final double? borderWidth;
  final Color? color;
  final Color? background;
  final double? fontSize;
  final double? radius;
  final FontWeight? fontWeight;
  final String? fontFamily;
  final double? wordSpacing;
  final VoidCallback? onPressed;
  late OutlinedBorder? shape;
  final bool isRounded;

  MBButton({
    super.key,
    this.text,
    this.icon,
    this.badgeCount,
    this.background,
    this.fontSize,
    this.fontWeight,
    this.fontFamily,
    this.color,
    this.wordSpacing,
    this.shape,
    this.radius,
    this.borderWidth,
    this.borderColor,
    this.isRounded = false,
    required this.onPressed,
  }) {
    if (isRounded) {
      shape = const StadiumBorder();
    } else {
      if (radius != null) {
        shape = RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius!), // <-- Radius
        );
      }
    }
  }

  Widget buildButton(BuildContext context) {
    if (text == null && icon != null) {
      if (background != null) {
        return ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            shape: (radius != null && (radius ?? 0) > 0) ? RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(radius ?? 0), // Set the desired corner radius here
            ) : const CircleBorder(),
            padding: const EdgeInsets.all(15),
            backgroundColor: background, // <-- Button color
            foregroundColor: color, // <-- Splash color
          ),
          child: icon!,
        );
      }
      return IconButton(
        onPressed: onPressed,
        icon: icon!,
        color: color,
      );
    }
    final textWidget = MBText(
      text ?? '',
      fontFamily: fontFamily,
      fontWeight: fontWeight,
      color: color,
      fontSize: fontSize,
      wordSpacing: wordSpacing,
    );

    if (borderWidth != null && borderColor != null) {
      return OutlinedButton(
        onPressed: () {},
        style: OutlinedButton.styleFrom(
          backgroundColor: background, // <-- Button color
          foregroundColor: color,
          side: BorderSide(
              width: borderWidth ?? 1.0, color: borderColor ?? Colors.white54),
        ),
        child: textWidget,
      );
    }
    if (background != null) {
      if (icon != null) {
        return ElevatedButton.icon(
            onPressed: onPressed,
            icon: icon!,
            label: textWidget,
            style: ElevatedButton.styleFrom(
              shape: shape,
              backgroundColor: background, // <-- Button color
              foregroundColor: color, // <-- Splash color
            ));
      }
      return ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            shape: shape,
            backgroundColor: background, // <-- Button color
            foregroundColor: color, // <-- Splash color
          ),
          child: textWidget);
    } else {
      if (icon != null) {
        return TextButton.icon(
          onPressed: onPressed,
          icon: icon!,
          label: textWidget,
          style: TextButton.styleFrom(
              shape: shape,
              foregroundColor: color ?? AppColors.primaryColor,
              backgroundColor: background),
        );
      }
      return TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
            shape: shape, foregroundColor: color ?? AppColors.primaryColor),
        child: textWidget,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return (badgeCount != null && (badgeCount ?? 0) > 0)
        ? Stack(
            alignment: Alignment.center,
            children: [
              buildButton(context),
              Positioned(
                top: 0,
                right: 0,
                child: MBContainer(
                  constraints: const BoxConstraints(minWidth: 20),
                  padding: const EdgeInsets.all(2),
                  color: Colors.red,
                  radius: 10,
                  child: MBText(
                    ((badgeCount ?? 0) > 99) ? "+99" : badgeCount.toString(),
                    fontWeight: AppFonts.regular,
                    textAlign: TextAlign.center,
                    color: AppColors.white,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          )
        : buildButton(context);
  }
}
