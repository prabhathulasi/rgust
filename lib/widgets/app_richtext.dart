import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppRichTextView extends StatelessWidget {
  final String title;
  final Color? textColor;
  final double fontSize;
  final FontWeight fontWeight;
  final TextAlign? textAlign;
  final TextOverflow? overflow;
  final TextDecoration? textDecoration;
  final int maxLines;
  final FontStyle? fontStyle;

  const AppRichTextView({
    Key? key,
    required this.title,
    this.textColor,
    required this.fontSize,
    required this.fontWeight,
    this.textDecoration,
    this.textAlign,
    this.overflow,
    this.fontStyle,
    this.maxLines = 1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      softWrap: true,
        textAlign: textAlign ?? TextAlign.left,
        
        maxLines: maxLines,
       
        text: TextSpan(
            text: title,
            style: GoogleFonts.roboto(
              fontStyle: fontStyle ??FontStyle.normal ,
                fontSize: fontSize,
                fontWeight: fontWeight,
                color: textColor,
                decoration: textDecoration)));
  }
}
