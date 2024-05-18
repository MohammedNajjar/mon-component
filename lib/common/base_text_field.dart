import 'package:mon/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart' as intl;

//https://dev.to/chinmaykb/advanced-form-handling-with-vanilla-flutter-3e20
class MBTextField extends StatefulWidget {
  String? text;
  String? initialValue;
  String hintText;
  String? labelHint;
  EdgeInsetsGeometry? contentPadding;
  Widget? prefixIcon;
  Widget? suffixIcon;
  TextInputType textInputType;
  bool obscureText;
  TextAlign? textAlign;
  TextEditingController? controller;
  TextInputAction textInputAction;
  bool enabled;
  bool hideCounter;
  bool readOnly;
  int? maxLine = 1;
  int? minLines = 1;
  int? maxLength;
  Function(String)? searchPress;
  String? fontFamily;
  FormFieldValidator<String>? validator;
  GestureTapCallback? onTap;
  TextDirection? textDirection;
  ValueChanged<String>? onChanged;
  FocusNode? focusNode;
  BoxConstraints? prefixIconConstraints;
  BoxConstraints? suffixIconConstraints;
  List<TextInputFormatter>? inputFormatters;

  MBTextField(
      {Key? key,
        this.hintText = '',
        this.text,
        this.focusNode,
        this.inputFormatters,
        this.labelHint,
        this.initialValue,
        this.maxLength,
        this.contentPadding,
        this.textAlign,
        this.suffixIcon,
        this.suffixIconConstraints,
        this.prefixIcon,
        this.prefixIconConstraints,
        this.onTap,
        this.textDirection,
        this.maxLine = 1,
        this.minLines = 1,
        this.searchPress,
        this.textInputType = TextInputType.text,
        this.obscureText = false,
        this.controller,
        this.textInputAction = TextInputAction.next,
        this.enabled = true,
        this.readOnly = false,
        this.fontFamily = "medium",
        this.validator,
        this.hideCounter = false,
        this.onChanged})
      : super(key: key);

  @override
  State<MBTextField> createState() => _MBTextFieldState();
}

class _MBTextFieldState extends State<MBTextField> {
  late String? labelHint = widget.labelHint;
  bool hasFocus = false;

  // @override
  // void didUpdateWidget(MBTextField oldWidget) {
    // if (isRTL(oldWidget.text) != isRTL(widget.text)) {
    //   WidgetsBinding.instance.addPostFrameCallback((_) => isRTL(widget.text));
    // }
    // super.didUpdateWidget(oldWidget);
  // }

  bool isRTL(String? text) {
    if (text == null || text.isEmpty) {
      return Directionality.of(context) == TextDirection.rtl;
    }
    return intl.Bidi.detectRtlDirectionality(text);
  }

  @override
  Widget build(BuildContext context) {
    return Focus(
      onFocusChange: (hasFocus) {
        setState(() {
          hasFocus = hasFocus;
        });
      },
      child: TextFormField(
        focusNode: widget.focusNode,
        onTap: widget.onTap,
        maxLength: widget.maxLength,
        readOnly: widget.readOnly,
        enabled: widget.enabled,
        initialValue: widget.initialValue,
        onFieldSubmitted: (value) {
          if (widget.searchPress == null) {} else
            widget.searchPress!(value);
        },
        inputFormatters: widget.inputFormatters,
        validator: widget.validator,
        onChanged: (str) {
          setState(() {
            widget.text = str;
            if (widget.onChanged != null) widget.onChanged!(str);
            // labelHint=(widget.text?.isEmpty??true)?null:widget.labelHint;
          });
        },
        controller: widget.controller,
        obscureText: widget.obscureText,
        keyboardType: widget.textInputType,
        textInputAction: widget.textInputAction,
        textAlign: widget.textAlign != null
            ? widget.textAlign == TextAlign.start
            ? isRTL(widget.text)
            ? TextAlign.start
            : TextAlign.end
            : widget.textAlign == TextAlign.end
            ? isRTL(widget.text)
            ? TextAlign.end
            : TextAlign.start
            : widget.textAlign!
            : TextAlign.start
        ,
        style: TextStyle(
          fontSize: AppFonts.formTextSize,
          fontFamily: AppFonts.fontFamily,
          fontWeight: AppFonts.bold,
          color: AppColors.neutrals_900,
        ),
        maxLines: widget.maxLine,
        minLines: widget.minLines,
        textDirection: widget.textDirection ??
            (isRTL(widget.text) ? TextDirection.rtl : TextDirection.ltr),
        textAlignVertical: TextAlignVertical.center,
        decoration: InputDecoration(
          counter: widget.hideCounter ? const Offstage() : null,

          isDense: false,
          // label: labelHint!=null?Padding(padding: EdgeInsetsDirectional.only(start: 5.w,end: 5.w),child: Text(hasFocus?(labelHint??""):((widget.text?.isNotEmpty??false)||(widget.initialValue?.isNotEmpty??false))?(labelHint??""):widget.hintText),):null,
          label: labelHint != null
              ? Padding(
            padding: EdgeInsetsDirectional.only(start: 1.w, end: 1.w),
            child: Text(
              labelHint ?? "",
            ),
          )
              : null,
          hintText: widget.hintText,

          contentPadding: widget.contentPadding ??
              EdgeInsetsDirectional.only(
                  start: 15.w, end: 10.w, top: 0.h, bottom: 0.h),
          hintTextDirection: widget.textDirection ??
              (isRTL(widget.text) ? TextDirection.rtl : TextDirection.ltr),
          filled: true,

          prefixIcon: widget.prefixIcon,
          suffixIcon: widget.textInputType == TextInputType.visiblePassword
              ? InkWell(
              onTap: () {
                setState(() {
                  widget.obscureText = !widget.obscureText;
                });
              },
              child: Icon(
                widget.obscureText
                    ? Icons.visibility
                    : Icons.visibility_off,
              ))
              : widget.suffixIcon,
          prefixIconConstraints: widget.prefixIconConstraints ??
              BoxConstraints(minWidth: 40.w, maxHeight: 25.h, maxWidth: 40.w),
          suffixIconConstraints: widget.suffixIconConstraints ??
              BoxConstraints(minWidth: 40.w, maxHeight: 25.h, maxWidth: 40.w),
        ),
      ),
    );
  }
}