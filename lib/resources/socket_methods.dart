import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tic_tac_toe_app/provider/room_data_provider.dart';
import 'package:tic_tac_toe_app/resources/socket_client.dart';
import 'package:tic_tac_toe_app/screens/game_screen.dart';
import 'package:tic_tac_toe_app/utils/utlis.dart';

class SocketMethods {
  // Instance of the socket client to manage socket communications
  final _socketClient = SocketClient.instance.socket!;

  // Method to emit a request to create a new room
  void createRoom(String nickname) {
    // Ensure nickname is not empty before emitting the event
    if (nickname.isNotEmpty) {
      _socketClient.emit('createRoom', {
        'nickname': nickname,
      });
    }
  }

  // Method to emit a request to join an existing room
  void joinRoom(String nickname, String roomId) {
    // Ensure both nickname and roomId are not empty before emitting the event
    if (nickname.isNotEmpty && roomId.isNotEmpty) {
      _socketClient.emit('joinRoom', {
        'nickname': nickname,
        'roomId': roomId,
      });
    }
  }

  // Listener for when room creation is successful
  void createRoomSuccessListener(BuildContext context) {
    _socketClient.on('createRoomSuccess', (room) {
      // Update the room data in the provider
      Provider.of<RoomDataProvider>(context, listen: false)
          .updateRoomData(room);
      // Navigate to the GameScreen
      Navigator.pushNamed(context, GameScreen.routeName);
    });
  }

  // Listener for when joining a room is successful
  void joinRoomSuccessListener(BuildContext context) {
    _socketClient.on("joinRoomSuccess", (room) {
      // Update the room data in the provider
      Provider.of<RoomDataProvider>(context, listen: false)
          .updateRoomData(room);
      // Navigate to the GameScreen
      Navigator.pushNamed(context, GameScreen.routeName);
    });
  }

  // Listener for when an error occurs
  void errorOccurredListener(BuildContext context) {
    _socketClient.on("errorOccurred", (data) {
      // Show a SnackBar with the error message
      showSnackBar(context, data);
    });
  }

  // Listener for updating the player states
  void updatePlayerStateListener(BuildContext context) {
    print("inside update player");
    _socketClient.on('updatePlayers', (playerData) {
      print('Received player data: $playerData');
      // Update player data in the provider
      Provider.of<RoomDataProvider>(context, listen: false)
          .updatePlayer1(playerData[0]);
      print('player 1 updated');
      Provider.of<RoomDataProvider>(context, listen: false)
          .updatePlayer2(playerData[1]);
    });
  }
}
