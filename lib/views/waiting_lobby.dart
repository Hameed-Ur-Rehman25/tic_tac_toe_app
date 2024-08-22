import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tic_tac_toe_app/provider/room_data_provider.dart';
import 'package:tic_tac_toe_app/widgets/custom_text.dart';
import 'package:tic_tac_toe_app/widgets/custom_text_field.dart';

/// The `WaitingLobby` widget is displayed when the player is waiting for
/// another player to join their room. It shows the room ID for the player
/// to share with others.
class WaitingLobby extends StatefulWidget {
  const WaitingLobby({super.key});

  @override
  State<WaitingLobby> createState() => _WaitingLobbyState();
}

class _WaitingLobbyState extends State<WaitingLobby> {
  late TextEditingController _textEditingController;

  @override
  void initState() {
    super.initState();
    // Initialize the TextEditingController with the room ID from the provider
    _textEditingController = TextEditingController(
      text:
          Provider.of<RoomDataProvider>(context, listen: false).roomData['_id'],
    );
  }

  @override
  void dispose() {
    super.dispose();
    // Dispose of the TextEditingController to free up resources
    _textEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Display a message indicating that the player is waiting for another player
          const CustomText(
            text: 'Waiting for a player to join...\nYour room id:',
            shadow: [],
            fontWeight: FontWeight.w500,
            fontSize: 16,
          ),
          const SizedBox(
            height: 20, // Spacing between the message and the text field
          ),
          // Display the room ID in a read-only text field
          CustomTextField(
            isReadOnly: true, // Make the text field read-only
            hintText: '', // No hint text required as room ID is shown directly
            controller:
                _textEditingController, // Controller to display the room ID
          ),
        ],
      ),
    );
  }
}
