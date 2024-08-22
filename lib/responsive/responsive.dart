import 'package:flutter/material.dart';

// A widget that centers its child and applies a maximum width constraint
class Responsive extends StatelessWidget {
  final Widget child; // The child widget to be displayed

  // Constructor to initialize the Responsive widget
  const Responsive({
    super.key,
    required this.child, // Required parameter to pass the child widget
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          maxWidth: 600, // Maximum width constraint for the child widget
        ),
        child: child, // The child widget to be centered and constrained
      ),
    );
  }
}
