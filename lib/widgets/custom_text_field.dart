import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final bool isReadOnly;
  const CustomTextField({
    super.key,
    required this.hintText,
    required this.controller,
    this.isReadOnly = false,
  });

  final _border = const OutlineInputBorder(
    borderSide: BorderSide(
      color: Colors.black,
    ),
    borderRadius: BorderRadius.all(
      Radius.circular(50),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 350,
      child: TextField(
        readOnly: isReadOnly,
        controller: controller,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(15),
          enabledBorder: _border,
          focusedBorder: _border,
          hintText: hintText,
          filled: true,
        ),
      ),
    );
  }
}
