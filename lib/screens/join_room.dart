import 'package:flutter/material.dart';
import 'package:tic_tac_toe_app/resources/socket_methods.dart';
import 'package:tic_tac_toe_app/responsive/responsive.dart';
import 'package:tic_tac_toe_app/widgets/custom_button.dart';
import 'package:tic_tac_toe_app/widgets/custom_text.dart';
import 'package:tic_tac_toe_app/widgets/custom_text_field.dart';

// Screen for joining an existing game room
class JoinRoom extends StatefulWidget {
  // Route name for navigating to this screen
  static String routeName = '/join-room';

  // Constructor for JoinRoom
  const JoinRoom({super.key});

  @override
  State<JoinRoom> createState() => _JoinRoomState();
}

class _JoinRoomState extends State<JoinRoom> {
  // Instance of SocketMethods to handle socket operations
  final SocketMethods _socketClient = SocketMethods();

  // Controllers for text fields
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _idController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Set up socket event listeners
    _socketClient.joinRoomSuccessListener(context);
    _socketClient.errorOccurredListener(context);
    _socketClient.updatePlayerStateListener(context);
  }

  @override
  void dispose() {
    // Clean up the controllers when the widget is removed from the widget tree
    _nameController.dispose();
    _idController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context); // Get screen size

    return Scaffold(
      body: Responsive(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Title of the screen
              const CustomText(
                text: 'Join Room',
                shadow: [
                  Shadow(
                    color: Colors.white,
                    blurRadius: 20,
                    offset: Offset.zero,
                  ),
                ],
                fontWeight: FontWeight.bold,
                fontSize: 80,
              ),
              SizedBox(
                  height: size.height *
                      0.025), // Spacing between title and text fields

              // Text field for entering the nickname
              CustomTextField(
                controller: _nameController,
                hintText: 'Enter your nickname',
              ),
              SizedBox(
                  height: size.height * 0.010), // Spacing between text fields

              // Text field for entering the game ID
              CustomTextField(
                controller: _idController,
                hintText: 'Enter game ID',
              ),
              SizedBox(
                  height: size.height *
                      0.025), // Spacing between text fields and button

              // Button to join the room
              CustomButton(
                onTap: () {
                  // Trigger the join room action
                  _socketClient.joinRoom(
                    _nameController.text,
                    _idController.text,
                  );
                },
                color: Colors.white,
                text: 'Join',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
