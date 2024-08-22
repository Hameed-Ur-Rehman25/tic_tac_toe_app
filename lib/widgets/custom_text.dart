// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

/// A customizable text widget that allows for advanced styling options.
///
/// This widget extends [StatelessWidget] to provide a text field with customizable
/// styles including shadow effects, font weight, font size, and letter spacing.
class CustomText extends StatelessWidget {
  /// The text content to be displayed.
  final String text;

  /// A list of [Shadow] effects applied to the text.
  ///
  /// Shadows can be used to add depth and visual interest to the text.
  final List<Shadow> shadow;

  /// The weight of the font used to render the text.
  ///
  /// Typical values are [FontWeight.normal], [FontWeight.bold], etc.
  final FontWeight fontWeight;

  /// The size of the font used to render the text.
  ///
  /// This value is in logical pixels.
  final double fontSize;

  /// The spacing between letters in the text.
  ///
  /// A positive value increases the spacing, while a negative value decreases it.
  /// Defaults to `0`.
  final double letterSpace;

  /// Creates a [CustomText] widget.
  ///
  /// [text] is the content to be displayed in the text widget.
  /// [shadow] is the list of shadows applied to the text.
  /// [fontWeight] sets the weight of the font.
  /// [fontSize] sets the size of the font.
  /// [letterSpace] adjusts the spacing between letters. Defaults to `0`.
  const CustomText({
    super.key,
    required this.text,
    required this.shadow,
    required this.fontWeight,
    required this.fontSize,
    this.letterSpace = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontWeight:
            fontWeight, // Sets the weight of the font (e.g., bold, normal).
        fontSize: fontSize, // Sets the size of the font in logical pixels.
        color: Colors.white, // Sets the color of the text.
        shadows: shadow, // Applies shadow effects to the text.
        letterSpacing: letterSpace, // Adjusts the space between letters.
      ),
    );
  }
}
