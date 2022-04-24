import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_trailer/helpers/responsive_helper.dart';

// ignore: must_be_immutable
class CustomTextBox extends StatelessWidget {
  final Function(String)? onChanged;
  final String? value;
  final String placeholder;
  double? height;
  final Alignment alignment;
  final TextAlign textAlign;
  final EdgeInsets padding;
  final EdgeInsets margin;
  final double borderRadius;
  final Color borderColor;
  final Color fillColor;
  final String? labelText;
  final String? prefixText;
  final TextStyle? textStyle;
  final TextInputType textInputType;
  final Widget? label;
  final EdgeInsetsGeometry? contentPadding;
  final String? Function(String?)? validator;

  CustomTextBox({
    Key? key,
    this.onChanged,
    this.validator,
    this.value,
    this.placeholder = '',
    this.height,
    this.borderRadius = 10.0,
    this.borderColor = const Color(0xFFE6E6EB),
    this.fillColor = Colors.white,
    this.alignment = Alignment.centerLeft,
    this.textAlign = TextAlign.left,
    this.padding = const EdgeInsets.only(left: 0.0, right: 0.0, top: 2.0),
    this.margin = const EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.0),
    this.labelText,
    this.prefixText,
    this.textInputType = TextInputType.text,
    this.textStyle,
    this.label,
    this.contentPadding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    height ??= 25.h;
    return Container(
      height: height,
      alignment: alignment,
      padding: padding,
      margin: margin,
      child: TextFormField(
        enabled: onChanged != null,
        initialValue: value,
        textAlign: textAlign,
        onChanged: (text) => onChanged!(text),
        keyboardType: textInputType,
        validator: validator,
        inputFormatters: prefixText != null
            ? [singleCharacterPrefixTextFormatter(prefixText!)]
            : [],
        style: textStyle ??
            TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w300,
              color: Colors.black,
            ),
        decoration: InputDecoration(
          contentPadding: contentPadding ??
              EdgeInsets.fromLTRB(
                40.w,
                0,
                (prefixText != null ? 20.w : 5.w),
                0.w,
              ),
          hintText: placeholder,
          labelText: labelText,
          label: label,
          floatingLabelBehavior: (labelText?.isEmpty ?? false)
              ? null
              : FloatingLabelBehavior.never,
          hintStyle: TextStyle(
            fontSize: smallTextSize,
            fontWeight: FontWeight.w300,
            color: Colors.white,
          ),
          labelStyle: TextStyle(
              color: Colors.white,
              fontSize: smallTextSize,
              fontWeight: FontWeight.w400),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(50.0.w)),
              borderSide: BorderSide(color: Colors.blue, width: 1.0)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(50.0.w)),
              borderSide: BorderSide(color: Colors.blue, width: 1.0)),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(50.0.w)),
            borderSide: BorderSide(color: Colors.blue, width: 1.0),
          ),
          prefixStyle: TextStyle(
            fontSize: smallTextSize,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  singleCharacterPrefixTextFormatter(String prefixText) {
    // Returns an TextInputFormatter configured with a prefix
    return TextInputFormatter.withFunction((oldValue, newValue) {
      // Strip the prefix and add it in the correct place
      String newText = newValue.text.replaceFirst(prefixText, '');
      String value = prefixText + newText;

      // Figure out where the curosor should be
      TextSelection selection = newValue.selection;

      // If we are an empty string
      if (value == prefixText) {
        selection = TextSelection.collapsed(offset: value.length);
      }
      // If the cursor happned to be behind the prefix
      if (value.length == prefixText.length + 1) {
        selection = TextSelection.collapsed(offset: value.length);
      }

      // Return the text with the prefix  & the curosor position
      return TextEditingValue(
        selection: selection,
        text: value,
      );
    });
  }
}
