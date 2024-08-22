import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tic_tac_toe_app/provider/room_data_provider.dart';
import 'package:tic_tac_toe_app/resources/socket_methods.dart';
import 'package:tic_tac_toe_app/views/scoreboard.dart';
import 'package:tic_tac_toe_app/views/tic_tac_toe_board.dart';
import 'package:tic_tac_toe_app/views/waiting_lobby.dart';

// The GameScreen class represents the main game screen where the Tic Tac Toe game is played.
class GameScreen extends StatefulWidget {
  // Static route name for navigation
  static String routeName = '/game';

  // Constructor for GameScreen
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  // Instance of SocketMethods to handle socket-related operations
  final SocketMethods _socketMethods = SocketMethods();

  @override
  void initState() {
    super.initState();
    // Set up socket event listeners
    _socketMethods.updateRoomListener(context);
    _socketMethods.updatePlayerStateListener(context);
    _socketMethods.pointIncreaseListener(context);
    _socketMethods.endGameListener(context);
  }

  @override
  Widget build(BuildContext context) {
    // Access the RoomDataProvider to get the current state of the room and players
    final roomDataProvider = Provider.of<RoomDataProvider>(context);

    return Scaffold(
      body: roomDataProvider.roomData['isjoin'] == true
          // Display the WaitingLobby if the user is in the waiting room
          ? const WaitingLobby()
          : SafeArea(
              // Use SafeArea to avoid system UI overlaps
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // Display the scoreboard
                  const Scoreboard(),

                  // Display the Tic Tac Toe game board
                  const TicTacToeBoard(),

                  // Display the current player's turn
                  Text(
                    '${roomDataProvider.roomData['turn']['nickname']}\'s turn',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      shadows: [
                        Shadow(
                          color: Colors.white,
                          blurRadius: 40,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
