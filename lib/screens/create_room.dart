import 'package:flutter/material.dart';
import 'package:tic_tac_toe_app/resources/socket_methods.dart';
import 'package:tic_tac_toe_app/responsive/responsive.dart';
import 'package:tic_tac_toe_app/widgets/custom_button.dart';
import 'package:tic_tac_toe_app/widgets/custom_text.dart';
import 'package:tic_tac_toe_app/widgets/custom_text_field.dart';

// The CreateRoom class represents the screen where users can create a new game room.
class CreateRoom extends StatefulWidget {
  // Static route name for navigation purposes
  static String routeName = '/create-room';

  // Constructor for CreateRoom
  const CreateRoom({super.key});

  @override
  State<CreateRoom> createState() => _CreateRoomState();
}

class _CreateRoomState extends State<CreateRoom> {
  // Controller to manage the input for the nickname text field
  final TextEditingController _nameController = TextEditingController();

  // Instance of SocketMethods to handle socket communication
  final SocketMethods _socketMethods = SocketMethods();

  @override
  void initState() {
    super.initState();
    // No specific initialization for socket listeners in this screen
  }

  @override
  void dispose() {
    super.dispose();
    // Dispose of the controller when the widget is removed from the tree
    _nameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Get the size of the screen
    final size = MediaQuery.sizeOf(context);

    return Scaffold(
      body: Responsive(
        // Responsive layout to center the content with constraints
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Title text for the screen
              const CustomText(
                text: 'Create Room',
                shadow: [
                  Shadow(
                    color: Colors.white,
                    blurRadius: 20,
                    offset: Offset.zero,
                  ),
                ],
                fontWeight: FontWeight.bold,
                fontSize: 70,
              ),
              SizedBox(height: size.height * 0.045),
              // Text field for entering nickname
              CustomTextField(
                controller: _nameController,
                hintText: 'Enter your nickname',
              ),
              SizedBox(height: size.height * 0.045),
              // Button to create the room
              CustomButton(
                onTap: () {
                  // Emit the createRoom event when the button is tapped
                  _socketMethods.createRoom(_nameController.text);

                  // Set up a listener for room creation success
                  _socketMethods.createRoomSuccessListener(context);
                },
                color: Colors.white,
                text: 'Create',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
