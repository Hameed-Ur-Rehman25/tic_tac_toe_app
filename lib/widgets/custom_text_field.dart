import 'package:flutter/material.dart';

/// A custom text field widget with customizable hint text, controller, and read-only state.
///
/// This widget uses [TextField] to provide a consistent appearance and behavior
/// for text input fields in the app.
class CustomTextField extends StatelessWidget {
  /// The hint text displayed inside the text field when it is empty.
  final String hintText;

  /// The [TextEditingController] that controls the text being edited.
  final TextEditingController controller;

  /// Indicates whether the text field is read-only.
  ///
  /// When set to `true`, the text field cannot be edited by the user.
  final bool isReadOnly;

  /// Creates a [CustomTextField] widget.
  ///
  /// [hintText] is the placeholder text shown when the text field is empty.
  /// [controller] is the controller for the text field.
  /// [isReadOnly] determines if the text field should be read-only. Defaults to `false`.
  const CustomTextField({
    super.key,
    required this.hintText,
    required this.controller,
    this.isReadOnly = false,
  });

  // Defines the border style for the text field.
  final _border = const OutlineInputBorder(
    borderSide: BorderSide(
      color: Colors.black, // Color of the border.
    ),
    borderRadius: BorderRadius.all(
      Radius.circular(50), // Rounds the corners of the border.
    ),
  );

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 350, // Sets the width of the text field.
      child: TextField(
        readOnly: isReadOnly, // Determines if the text field is read-only.
        controller: controller, // Sets the controller for the text field.
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.all(15), // Adds padding inside the text field.
          enabledBorder:
              _border, // Applies the border when the text field is enabled.
          focusedBorder:
              _border, // Applies the border when the text field is focused.
          hintText:
              hintText, // Sets the hint text displayed when the text field is empty.
          filled: true, // Ensures the background of the text field is filled.
        ),
      ),
    );
  }
}
