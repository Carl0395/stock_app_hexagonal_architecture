import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomInput extends StatelessWidget {
  final void Function(String text)? onChanged;
  final void Function(String text)? onSubmitted;
  final String? hintText;
  final FocusNode? focusNode;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;
  final TextEditingController? controller;

  const CustomInput({
    super.key,
    this.onChanged,
    this.hintText,
    this.onSubmitted,
    this.focusNode,
    this.inputFormatters,
    this.keyboardType,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      autofocus: true,
      focusNode: focusNode,
      textCapitalization: TextCapitalization.words,
      onSubmitted:
          onSubmitted ??
          (value) {
            Navigator.of(context).pop();
          },
      decoration: InputDecoration(
        hintText: hintText ?? '',
        hintStyle: TextStyle(
          color: Colors.grey[500],
          fontWeight: FontWeight.w300,
        ),
        isDense: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),

          borderSide: BorderSide(color: Colors.red, width: 0.5),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade500, width: 0.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: BorderSide(color: Color(0xFF4780FF), width: 2),
        ),
      ),
      onChanged: onChanged,
      inputFormatters: inputFormatters,
      keyboardType: keyboardType,
    );
  }
}
