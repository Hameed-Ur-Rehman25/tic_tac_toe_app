// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;
  final List<Shadow> shadow;
  final FontWeight fontWeight;
  final double fontSize;
  const CustomText({
    super.key,
    required this.text,
    required this.shadow,
    required this.fontWeight,
    required this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontWeight: fontWeight,
        fontSize: fontSize,
        color: Colors.white,
        shadows: shadow,
      ),
    );
  }
}
