import 'package:flutter/material.dart';
import 'package:tic_tac_toe_app/widgets/custom_text.dart';

class PlayerDetailOnScoreboard extends StatelessWidget {
  final String nickname;
  final String points;
  final String avatarPath;
  const PlayerDetailOnScoreboard({
    super.key,
    required this.nickname,
    required this.points,
    required this.avatarPath,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            children: [
              Image.asset(
                avatarPath,
                height: 70,
                // width: 50,
              ),
              Container(
                // height: 100,
                // width: 100,
                decoration: BoxDecoration(
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          CustomText(
            text: nickname,
            shadow: const [],
            fontWeight: FontWeight.bold,
            fontSize: 20,
            letterSpace: 3,
          ),
          CustomText(
            text: points,
            shadow: const [],
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ],
      ),
    );
  }
}
