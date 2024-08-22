import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:tic_tac_toe_app/provider/room_data_provider.dart';
import 'package:tic_tac_toe_app/utils/utlis.dart';

// Class containing methods for managing game logic in a Tic-Tac-Toe game
class GameMethods {
  // Method to check if there is a winner or if the game is a draw
  void checkWinner(BuildContext context, Socket socketClient) {
    // Access the RoomDataProvider to get the current game state
    RoomDataProvider roomDataProvider =
        Provider.of<RoomDataProvider>(context, listen: false);

    String winner = '';

    // Check for a winning condition in the rows
    if (roomDataProvider.displayElement[0] ==
            roomDataProvider.displayElement[1] &&
        roomDataProvider.displayElement[0] ==
            roomDataProvider.displayElement[2] &&
        roomDataProvider.displayElement[0] != '') {
      winner = roomDataProvider.displayElement[0];
    }
    if (roomDataProvider.displayElement[3] ==
            roomDataProvider.displayElement[4] &&
        roomDataProvider.displayElement[3] ==
            roomDataProvider.displayElement[5] &&
        roomDataProvider.displayElement[3] != '') {
      winner = roomDataProvider.displayElement[3];
    }
    if (roomDataProvider.displayElement[6] ==
            roomDataProvider.displayElement[7] &&
        roomDataProvider.displayElement[6] ==
            roomDataProvider.displayElement[8] &&
        roomDataProvider.displayElement[6] != '') {
      winner = roomDataProvider.displayElement[6];
    }

    // Check for a winning condition in the columns
    if (roomDataProvider.displayElement[0] ==
            roomDataProvider.displayElement[3] &&
        roomDataProvider.displayElement[0] ==
            roomDataProvider.displayElement[6] &&
        roomDataProvider.displayElement[0] != '') {
      winner = roomDataProvider.displayElement[0];
    }
    if (roomDataProvider.displayElement[1] ==
            roomDataProvider.displayElement[4] &&
        roomDataProvider.displayElement[1] ==
            roomDataProvider.displayElement[7] &&
        roomDataProvider.displayElement[1] != '') {
      winner = roomDataProvider.displayElement[1];
    }
    if (roomDataProvider.displayElement[2] ==
            roomDataProvider.displayElement[5] &&
        roomDataProvider.displayElement[2] ==
            roomDataProvider.displayElement[8] &&
        roomDataProvider.displayElement[2] != '') {
      winner = roomDataProvider.displayElement[2];
    }

    // Check for a winning condition in the diagonals
    if (roomDataProvider.displayElement[0] ==
            roomDataProvider.displayElement[4] &&
        roomDataProvider.displayElement[0] ==
            roomDataProvider.displayElement[8] &&
        roomDataProvider.displayElement[0] != '') {
      winner = roomDataProvider.displayElement[0];
    }
    if (roomDataProvider.displayElement[2] ==
            roomDataProvider.displayElement[4] &&
        roomDataProvider.displayElement[2] ==
            roomDataProvider.displayElement[6] &&
        roomDataProvider.displayElement[2] != '') {
      winner = roomDataProvider.displayElement[2];
    } else if (roomDataProvider.filledBoxes == 9) {
      // If the board is full and no winner, it's a draw
      winner = '';
      showGameDialog(context, 'Draw'); // Show a dialog indicating a draw
    }

    // Handle the end of the game if there's a winner
    if (winner != '') {
      if (roomDataProvider.player1.playerType == winner) {
        // Player 1 wins
        showGameDialog(context, '${roomDataProvider.player1.nickname} won!');
        socketClient.emit('winner', {
          'winnerSocketId': roomDataProvider.player1.socketID,
          'roomId': roomDataProvider.roomData['_id'],
        });
      } else {
        // Player 2 wins
        showGameDialog(context, '${roomDataProvider.player2.nickname} won!');
        socketClient.emit('winner', {
          'winnerSocketId': roomDataProvider.player2.socketID,
          'roomId': roomDataProvider.roomData['_id'],
        });
      }
    }
  }

  // Method to clear the game board for a new game
  void clearBoard(BuildContext context) {
    // Access the RoomDataProvider to reset the game state
    RoomDataProvider roomDataProvider =
        Provider.of<RoomDataProvider>(context, listen: false);

    // Clear all elements on the board
    for (int i = 0; i < roomDataProvider.displayElement.length; i++) {
      roomDataProvider.updateDisplayElement(i, '');
    }
    // Reset the count of filled boxes to 0
    roomDataProvider.setFilledBoxesTo0();
  }
}
