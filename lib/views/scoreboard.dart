import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tic_tac_toe_app/provider/room_data_provider.dart';
import 'package:tic_tac_toe_app/widgets/player_detail_on_scoreboard.dart';

/// The `Scoreboard` widget displays the scores and details of the players in the Tic-Tac-Toe game.
class Scoreboard extends StatefulWidget {
  const Scoreboard({super.key});

  @override
  State<Scoreboard> createState() => _ScoreboardState();
}

class _ScoreboardState extends State<Scoreboard> {
  @override
  Widget build(BuildContext context) {
    // Access the RoomDataProvider to get player and room data
    final roomDataProvider = Provider.of<RoomDataProvider>(context);

    return Row(
      // Align the player details horizontally at the center
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Display details for player 1
        PlayerDetailOnScoreboard(
          nickname: roomDataProvider.player1.nickname, // Player 1's nickname
          points: roomDataProvider.player1.points
              .toInt()
              .toString(), // Player 1's points
          avatarPath:
              'assets/images/cross.png', // Path to Player 1's avatar image
        ),
        SizedBox(
          // Add spacing between the two player details
          width:
              MediaQuery.of(context).size.width * 0.20, // 20% of screen width
        ),
        // Display details for player 2
        PlayerDetailOnScoreboard(
          nickname: roomDataProvider.player2.nickname, // Player 2's nickname
          points: roomDataProvider.player2.points
              .toInt()
              .toString(), // Player 2's points
          avatarPath:
              'assets/images/circle.png', // Path to Player 2's avatar image
        ),
      ],
    );
  }
}
