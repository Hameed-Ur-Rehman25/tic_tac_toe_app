// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';

/// A custom button widget with customizable tap callback, color, and text.
///
/// This widget uses [ElevatedButton] to provide a consistent look and feel
/// while allowing customization of its appearance and behavior.
class CustomButton extends StatelessWidget {
  /// Callback function to be executed when the button is tapped.
  final VoidCallback onTap;

  /// The color of the button's background.
  final Color color;

  /// The text displayed on the button.
  final String text;

  /// Creates a [CustomButton] widget.
  ///
  /// [onTap] is a required callback function executed when the button is pressed.
  /// [color] is the background color of the button.
  /// [text] is the label displayed on the button.
  const CustomButton({
    super.key,
    required this.onTap,
    required this.color,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap, // Sets the callback function for button tap.
      style: ElevatedButton.styleFrom(
        backgroundColor: color, // Sets the background color of the button.
        minimumSize: const Size(
            350, 50), // Sets the minimum width and height of the button.
        elevation: 10, // Adds shadow to the button to give it a raised effect.
      ),
      child: Padding(
        padding: const EdgeInsets.all(
            15.0), // Adds padding around the button's text.
        child: Text(
          text, // Displays the text on the button.
          style: const TextStyle(
            color: Colors.white, // Sets the text color.
            letterSpacing: 3, // Adds spacing between letters.
          ),
        ),
      ),
    );
  }
}
