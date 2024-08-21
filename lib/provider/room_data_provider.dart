// Import necessary packages
import 'package:flutter/material.dart';
import 'package:tic_tac_toe_app/models/player.dart';

// Define a class to manage room data and notify listeners when data changes
class RoomDataProvider extends ChangeNotifier {
  // Initialize an empty map to store room data
  Map<String, dynamic> _roomData = {};

  // Initialize two player objects with default values
  Player _player1 = Player(
    nickname: '', // Player 1's nickname
    playerType: 'X', // Player 1's type (X or O)
    socketID: '', // Player 1's socket ID
    points: 0, // Player 1's points
  );

  Player _player2 = Player(
    nickname: '', // Player 2's nickname
    playerType: 'O', // Player 2's type (X or O)
    socketID: '', // Player 2's socket ID
    points: 0, // Player 2's points
  );

  // Getters to access room data and player objects
  Map<String, dynamic> get roomData => _roomData;
  Player get player1 => _player1;
  Player get player2 => _player2;

  // Update room data and notify listeners
  void updateRoomData(Map<String, dynamic> data) {
    _roomData = data;
    notifyListeners(); // Notify listeners that data has changed
  }

  // Update player 1 data and notify listeners
  void updatePlayer1(Map<String, dynamic> player1Data) {
    try {
      print('Updating player1 with data: $player1Data');
      _player1 = Player.fromMap(player1Data);
      notifyListeners();
    } catch (e) {
      print('Error updating player1: $e');
    }
  }

  // Update player 2 data and notify listeners
  void updatePlayer2(Map<String, dynamic> player2Data) {
    try {
      print('Updating player2 with data: $player2Data');
      _player2 = Player.fromMap(player2Data);
      notifyListeners();
    } catch (e) {
      print('Error updating player2: $e');
    }
  }
}
