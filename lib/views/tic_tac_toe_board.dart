import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tic_tac_toe_app/provider/room_data_provider.dart';
import 'package:tic_tac_toe_app/resources/socket_methods.dart';

/// The `TicTacToeBoard` widget represents the game board for Tic-Tac-Toe,
/// where players can tap on grid cells to make a move.
class TicTacToeBoard extends StatefulWidget {
  const TicTacToeBoard({super.key});

  @override
  State<TicTacToeBoard> createState() => _TicTacToeBoardState();
}

class _TicTacToeBoardState extends State<TicTacToeBoard> {
  final SocketMethods _socketMethods = SocketMethods();

  /// Handles the grid cell tap event by notifying the server about the move.
  void tapped(int index, RoomDataProvider roomDataProvider) {
    _socketMethods.tapGrid(index, roomDataProvider.roomData['_id'],
        roomDataProvider.displayElement);
  }

  @override
  void initState() {
    super.initState();
    // Set up listeners for socket events related to grid tapping
    _socketMethods.tappedListener(context);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    // Access the RoomDataProvider to get the current game state
    RoomDataProvider roomDataProvider = Provider.of<RoomDataProvider>(context);

    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: size.height * 0.65, // Set a maximum height for the board
        maxWidth: 500, // Set a fixed maximum width for the board
      ),
      child: AbsorbPointer(
        // Prevent interaction if it's not the current player's turn
        absorbing: roomDataProvider.roomData['turn']['socketId'] !=
            _socketMethods.socketClient.id,
        child: GridView.builder(
          itemCount: 9, // There are 9 cells in the Tic-Tac-Toe board
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, // 3 cells per row
          ),
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () => tapped(index, roomDataProvider),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.white54, // Border color for each cell
                    width: 5, // Border width
                    style: BorderStyle.solid, // Solid border style
                    strokeAlign: BorderSide.strokeAlignCenter,
                  ),
                ),
                child: Center(
                  child: AnimatedSize(
                    duration: const Duration(
                      microseconds: 600, // Animation duration for size change
                    ),
                    child: Text(
                      roomDataProvider.displayElement[
                          index], // Display the symbol in the cell
                      style: TextStyle(
                        fontWeight: FontWeight.bold, // Bold text style
                        fontSize: 80, // Large font size for symbols
                        shadows: [
                          Shadow(
                            color: roomDataProvider.displayElement[index] == '0'
                                ? Colors.blue // Blue shadow for '0'
                                : Colors.red, // Red shadow for 'X'
                            blurRadius: 40, // Shadow blur radius
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
