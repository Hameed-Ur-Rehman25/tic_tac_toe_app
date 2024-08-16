import 'package:flutter/material.dart';
import 'package:tic_tac_toe_app/screens/create_room.dart';
import 'package:tic_tac_toe_app/screens/join_room.dart';
import 'package:tic_tac_toe_app/widgets/custom_button.dart';

class MainMenuScreen extends StatelessWidget {
  static String routeName = '/main-menu';
  const MainMenuScreen({super.key});

  void createRoom(BuildContext context) {
    Navigator.pushNamed(context, CreateRoom.routeName);
  }

  void joinRoom(BuildContext context) {
    Navigator.pushNamed(context, JoinRoom.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //Main Menu Image
            Image.asset(
              'assets/images/tic-tac-toe-2.png',
              height: 100,
              width: 80,
            ),
            const SizedBox(height: 20),

            //Create room Button
            CustomButton(
              onTap: () => createRoom(context),
              color: Colors.blue,
              text: 'Create Room',
            ),
            const SizedBox(height: 20),

            //Join Room Button
            CustomButton(
              onTap: () => joinRoom(context),
              color: Colors.blue,
              text: 'Join Room',
            ),
          ],
        ),
      ),
    );
  }
}
