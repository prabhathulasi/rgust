import 'package:flutter/material.dart';

class AppTextFormFieldWidget extends StatelessWidget {
  final String? initialValue;
  final TextStyle? textStyle;
  final bool enable;
  final TextInputType keyboardType;
  final bool obscureText;
  final Function(String)? onChanged;
  final void Function(String?)? onSaved;
final String? Function(String?)? validator;
  final InputDecoration? inputDecoration;
  final int? maxLines;

  const AppTextFormFieldWidget({
    super.key,
    this.initialValue,
    this.enable = true,
    this.inputDecoration,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.onChanged,
    this.onSaved,
    this.maxLines,
    this.textStyle,
    this.validator
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      
      validator:validator ,
      style: textStyle,
      initialValue: initialValue,
      keyboardType: keyboardType,
      obscureText: obscureText,
      onChanged: onChanged,
      onSaved: onSaved,
      maxLines: maxLines ?? 1,
      decoration: inputDecoration,
      enabled: enable,
    );
  }
}
