import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final String hint;
  final TextEditingController controller;
  final bool obscure;
  final FormFieldValidator<String>? validator;
  final TextInputType keyboardType;
  final Icon prefixIcon;
  final bool isSignInScreen;

  MyTextField(
      {required this.hint,
      required this.controller,
      this.obscure = false,
      this.validator,
      this.isSignInScreen = false,
      this.keyboardType = TextInputType.text,
      this.prefixIcon = const Icon(Icons.abc_outlined)});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscure,
      decoration: InputDecoration(
        prefixIcon: isSignInScreen ? null : prefixIcon,
        fillColor: Colors.black12,
        hintText: hint,
        hintStyle: const TextStyle(
          fontSize: 17,
          color: Colors.white54,
          fontWeight: FontWeight.w400,
        ),
        filled: true,
        labelStyle: const TextStyle(
          fontSize: 17,
          color: Colors.black,
          fontWeight: FontWeight.w400,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(width: 1, color: Colors.white12),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(width: 0.5, color: Colors.white12),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(width: 1, color: Colors.white12),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(width: 1, color: Colors.white12),
        ),
      ),
      validator: validator,
      keyboardType: keyboardType,
    );
  }
}
