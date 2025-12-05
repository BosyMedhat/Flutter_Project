import 'package:flutter/material.dart';

class CustomFiled extends StatelessWidget {
  const CustomFiled({
    super.key,
    required this.controller,
    required this.focusNode,
    this.onFieldSubmitted,
    required this.validator,
    required this.prefixIcon,
    required this.labelText,
    this.obscureText=false,
  });

  final TextEditingController controller;
  final FocusNode? focusNode;
  final Function(String)? onFieldSubmitted;
  final String? Function(String?)? validator;
  final Widget? prefixIcon;
  final String? labelText;
 final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      obscureText: obscureText,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: const TextStyle(color: Colors.white60),
        prefixIcon: prefixIcon,
        filled: true,
        fillColor: Colors.white.withOpacity(0.1),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide.none,
        ),
      ),
      validator: validator,
      onFieldSubmitted:onFieldSubmitted,
    );
  }
}
