import 'package:flutter/material.dart';
import 'package:tic_tac_toe_app/resources/game_methods.dart';

// Function to show a SnackBar with a given content
void showSnackBar(BuildContext context, String content) {
  // Access the ScaffoldMessenger associated with the given BuildContext
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
          content), // The content of the SnackBar, which is a Text widget displaying the provided content
    ),
  );
}

// Function to show a dialog with a given text
void showGameDialog(BuildContext context, String text) {
  // Display an AlertDialog with the provided text
  showDialog(
      barrierDismissible:
          false, // Prevents dismissing the dialog by tapping outside of it
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
              text), // The title of the dialog displaying the provided text
          actions: [
            TextButton(
              onPressed: () {
                // Action to clear the game board and close the dialog
                GameMethods().clearBoard(context);
                Navigator.pop(context); // Close the dialog
              },
              child: const Text(
                'Play Again', // Text displayed on the button
              ),
            ),
          ],
        );
      });
}
