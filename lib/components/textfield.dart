import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  const MyTextField(
      {super.key,
      required this.hint,
      required this.label,
      this.obsecure = false});
  final String hint, label;
  final bool obsecure;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return (TextField(
        obscureText: obsecure,
        decoration: InputDecoration(
          fillColor: Colors.white,
          hintText: hint,
          hintStyle: const TextStyle(
              fontSize: 17, color: Colors.grey, fontWeight: FontWeight.w400),
          filled: true,
          labelText: label,
          labelStyle: const TextStyle(
              fontSize: 17, color: Colors.grey, fontWeight: FontWeight.w400),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(width: 1, color: Colors.black12)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(width: 0.5, color: Colors.black12)),
          disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(width: 1, color: Colors.black12)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(width: 1, color: Colors.black12)),
        )));
  }
}
