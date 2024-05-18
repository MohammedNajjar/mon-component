import 'package:mon/theme/colors.dart';
import 'package:mon/theme/fonts.dart';
import 'package:flutter/material.dart';

class MBText extends StatelessWidget {
  final String? text;
  final int? maxLines;
  final double? fontSize;
  final FontWeight? fontWeight;
  final String? fontFamily;
  final Color? color;
  final double? wordSpacing;
  final VoidCallback? onClick;
  final TextAlign? textAlign;
  final TextOverflow? overflow;
  final BoxFit? fit;

  const MBText(
    this.text, {
    super.key,
    this.fontSize,
    this.textAlign,
    this.fontWeight,
    this.fontFamily,
    this.color,
    this.wordSpacing,
    this.maxLines,
    this.overflow,
    this.fit,
    this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // fit: fit ?? BoxFit.scaleDown,
      child: onClick == null
          ? Text(
              text ?? "",
              textAlign: textAlign,
              overflow: overflow ?? TextOverflow.visible,
              style: TextStyle(
                fontSize: fontSize,
                fontWeight: fontWeight,
                fontFamily: fontFamily ?? AppFonts.fontFamily,
                color: color,
                wordSpacing: wordSpacing,
              ),
            )
          : TextButton(
              onPressed: () {
                onClick?.call();
              },
              child: Text(
                text ?? "",
                textAlign: textAlign,
                overflow: overflow ?? TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: fontSize,
                  fontWeight: fontWeight,
                  fontFamily: fontFamily ?? AppFonts.fontFamily,
                  color: color,
                  wordSpacing: wordSpacing,
                ),
              ),
            ),
    );
  }
}
