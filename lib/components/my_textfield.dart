import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController? controller;
  final bool obscureText;
  final void Function()? onDoubleTap;
  final Widget? suffixIcon;
  final List<TextInputFormatter>? inputFormatters;
  TextInputType? keyboardType;

  MyTextField({
    super.key,
    required this.hintText,
    this.controller,
    required this.obscureText,
    this.onDoubleTap,
    this.suffixIcon,
    this.inputFormatters,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTap: onDoubleTap,
      child: TextField(
        keyboardType: keyboardType,
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey.shade500,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade400),
          ),
          fillColor: Colors.grey.shade200,
          filled: true,
          hintText: hintText,
          suffixIcon: suffixIcon,
        ),
        inputFormatters: inputFormatters,
      ),
    );
  }
}
