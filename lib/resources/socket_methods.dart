import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:tic_tac_toe_app/provider/room_data_provider.dart';
import 'package:tic_tac_toe_app/resources/game_methods.dart';
import 'package:tic_tac_toe_app/resources/socket_client.dart';
import 'package:tic_tac_toe_app/screens/game_screen.dart';
import 'package:tic_tac_toe_app/utils/utlis.dart';

// Class for managing socket communications related to the game
class SocketMethods {
  // Instance of the socket client to manage socket communications
  final _socketClient = SocketClient.instance.socket!;
  Socket get socketClient => _socketClient;

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

  // Method to emit a request when a grid cell is tapped
  void tapGrid(int index, String roomId, List<String> displayElement) {
    // Emit tap event only if the cell is empty
    if (displayElement[index] == '') {
      _socketClient.emit('tap', {
        'index': index,
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

  // Listener for updating player states
  void updatePlayerStateListener(BuildContext context) {
    _socketClient.on('updatePlayers', (playerData) {
      // Update player data in the provider
      Provider.of<RoomDataProvider>(context, listen: false)
          .updatePlayer1(playerData[0]);
      Provider.of<RoomDataProvider>(context, listen: false)
          .updatePlayer2(playerData[1]);
    });
  }

  // Listener for updating room data
  void updateRoomListener(BuildContext context) {
    _socketClient.on('updateRoom', (data) {
      // Update the room data in the provider
      Provider.of<RoomDataProvider>(context, listen: false)
          .updateRoomData(data);
    });
  }

  // Listener for handling grid cell taps from other clients
  void tappedListener(BuildContext context) {
    _socketClient.on('tapped', (data) {
      RoomDataProvider roomDataProvider =
          Provider.of<RoomDataProvider>(context, listen: false);
      // Update the board with the new move
      roomDataProvider.updateDisplayElement(
        data['index'],
        data['choice'],
      );
      // Update the room data
      roomDataProvider.updateRoomData(data['room']);
      // Check if there is a winner
      GameMethods().checkWinner(context, _socketClient);
    });
  }

  // Listener for increasing player points
  void pointIncreaseListener(BuildContext context) {
    _socketClient.on('pointIncrease', (playerData) {
      var roomDataProvider =
          Provider.of<RoomDataProvider>(context, listen: false);
      // Update the points for the correct player
      if (playerData['socketId'] == roomDataProvider.player1.socketID) {
        roomDataProvider.updatePlayer1(playerData);
      } else {
        roomDataProvider.updatePlayer2(playerData);
      }
    });
  }

  // Listener for handling end-of-game events
  void endGameListener(BuildContext context) {
    _socketClient.on('endGame', (playerData) {
      // Show a dialog with the winner's information
      showGameDialog(context, '${playerData['nickname']} won the game!');
      // Navigate back to the initial screen
      Navigator.popUntil(context, (route) => false);
    });
  }
}
