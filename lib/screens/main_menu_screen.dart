import 'package:flutter/material.dart';
import 'package:tic_tac_toe_app/responsive/responsive.dart';
import 'package:tic_tac_toe_app/screens/create_room.dart';
import 'package:tic_tac_toe_app/screens/join_room.dart';
import 'package:tic_tac_toe_app/widgets/custom_button.dart';

// Main menu screen where users can create or join a room
class MainMenuScreen extends StatelessWidget {
  // Route name for navigating to this screen
  static String routeName = '/main-menu';

  // Constructor for MainMenuScreen
  const MainMenuScreen({super.key});

  // Method to navigate to the CreateRoom screen
  void createRoom(BuildContext context) {
    Navigator.pushNamed(context, CreateRoom.routeName);
  }

  // Method to navigate to the JoinRoom screen
  void joinRoom(BuildContext context) {
    Navigator.pushNamed(context, JoinRoom.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Responsive(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Image displayed at the top of the main menu
            Image.asset(
              'assets/images/tic-tac-toe-2.png',
              height: 100,
              width: 80,
            ),
            const SizedBox(height: 20), // Spacing between image and buttons

            // Button to create a new room
            CustomButton(
              onTap: () => createRoom(context), // Navigate to CreateRoom screen
              color: Colors.blue, // Button color
              text: 'Create Room', // Button text
            ),
            const SizedBox(height: 20), // Spacing between buttons

            // Button to join an existing room
            CustomButton(
              onTap: () => joinRoom(context), // Navigate to JoinRoom screen
              color: Colors.blue, // Button color
              text: 'Join Room', // Button text
            ),
          ],
        ),
      ),
    );
  }
}
