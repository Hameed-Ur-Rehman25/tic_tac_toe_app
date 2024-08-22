import 'package:flutter/material.dart';
import 'package:tic_tac_toe_app/widgets/custom_text.dart';

/// A widget that displays the details of a player on the scoreboard.
///
/// This widget includes the player's avatar, nickname, and points.
/// It is used to show individual player details in a visually appealing format.
class PlayerDetailOnScoreboard extends StatefulWidget {
  /// The nickname of the player.
  final String nickname;

  /// The number of points the player has.
  final String points;

  /// The path to the player's avatar image.
  final String avatarPath;

  /// Creates a [PlayerDetailOnScoreboard] widget.
  ///
  /// [nickname] is the player's nickname.
  /// [points] is the player's score in points.
  /// [avatarPath] is the path to the player's avatar image.
  const PlayerDetailOnScoreboard({
    super.key,
    required this.nickname,
    required this.points,
    required this.avatarPath,
  });

  @override
  State<PlayerDetailOnScoreboard> createState() =>
      _PlayerDetailOnScoreboardState();
}

class _PlayerDetailOnScoreboardState extends State<PlayerDetailOnScoreboard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30.0), // Padding around the entire column.
      child: Column(
        mainAxisAlignment:
            MainAxisAlignment.center, // Center align the children vertically.
        children: [
          Stack(
            children: [
              // Player avatar image.
              Image.asset(
                widget.avatarPath,
                height: 70, // Height of the avatar image.
                // width: 50, // Width is commented out; height is used for size.
              ),
              // Circular background behind the avatar.
              Container(
                decoration: BoxDecoration(
                  color:
                      Colors.blueAccent, // Background color behind the avatar.
                  borderRadius: BorderRadius.circular(
                      50), // Makes the container circular.
                ),
                height:
                    70, // Ensures the background has the same height as the avatar.
                width: 70, // Same width as the height for a perfect circle.
              ),
            ],
          ),
          const SizedBox(height: 10), // Spacer between avatar and text.
          CustomText(
            text: widget.nickname, // Display player's nickname.
            shadow: const [], // No shadow applied.
            fontWeight: FontWeight.bold, // Bold font weight for prominence.
            fontSize: 20, // Font size for the nickname.
            letterSpace: 3, // Space between letters for the nickname.
          ),
          CustomText(
            text: widget.points, // Display player's points.
            shadow: const [], // No shadow applied.
            fontWeight: FontWeight.bold, // Bold font weight for points.
            fontSize: 18, // Font size for the points.
          ),
        ],
      ),
    );
  }
}
