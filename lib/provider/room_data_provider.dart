// Import necessary packages
import 'package:flutter/material.dart';
import 'package:tic_tac_toe_app/models/player.dart';

// Define a class to manage room data and notify listeners when data changes
class RoomDataProvider extends ChangeNotifier {
  // Private fields to store room and player data
  Map<String, dynamic> _roomData = {}; // Stores room-related data
  List<String> _displayElements = [
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    ''
  ]; // Represents the Tic-Tac-Toe board
  int _filledBoxes = 0; // Tracks the number of filled boxes on the board

  // Getter for the number of filled boxes
  int get filledBoxes => _filledBoxes;

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
  Map<String, dynamic> get roomData =>
      _roomData; // Provides access to room data
  List<String> get displayElement =>
      _displayElements; // Provides access to the board state
  Player get player1 => _player1; // Provides access to player 1's data
  Player get player2 => _player2; // Provides access to player 2's data

  // Update room data and notify listeners
  void updateRoomData(Map<String, dynamic> data) {
    _roomData = data; // Set the new room data
    notifyListeners(); // Notify listeners that room data has changed
  }

  // Update player 1 data and notify listeners
  void updatePlayer1(Map<String, dynamic> player1Data) {
    try {
      _player1 = Player.fromMap(player1Data); // Update player 1 with new data
      notifyListeners(); // Notify listeners that player 1 data has changed
    } catch (e) {
      // Handle any errors during update
    }
  }

  // Update player 2 data and notify listeners
  void updatePlayer2(Map<String, dynamic> player2Data) {
    try {
      _player2 = Player.fromMap(player2Data); // Update player 2 with new data
      notifyListeners(); // Notify listeners that player 2 data has changed
    } catch (e) {
      // Handle any errors during update
    }
  }

  // Update a specific element on the board and notify listeners
  void updateDisplayElement(int index, String choice) {
    _displayElements[index] = choice; // Set the choice at the specified index
    _filledBoxes += 1; // Increment the count of filled boxes
    notifyListeners(); // Notify listeners that the board state has changed
  }

  // Reset the count of filled boxes to 0
  void setFilledBoxesTo0() {
    _filledBoxes = 0; // Reset filled boxes count
  }
}
