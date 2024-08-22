import 'package:flutter/material.dart';
import 'package:tic_tac_toe_app/resources/socket_methods.dart';
import 'package:tic_tac_toe_app/responsive/responsive.dart';
import 'package:tic_tac_toe_app/widgets/custom_button.dart';
import 'package:tic_tac_toe_app/widgets/custom_text.dart';
import 'package:tic_tac_toe_app/widgets/custom_text_field.dart';

class JoinRoom extends StatefulWidget {
  static String routeName = '/join-room';
  const JoinRoom({super.key});

  @override
  State<JoinRoom> createState() => _JoinRoomState();
}

class _JoinRoomState extends State<JoinRoom> {
  final SocketMethods _socketClient = SocketMethods();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _idController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Ensure listeners are set up once
    _socketClient.joinRoomSuccessListener(context);
    _socketClient.errorOccurredListener(context);
    _socketClient.updatePlayerStateListener(context);
  }

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _idController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      body: Responsive(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CustomText(
                text: 'Join Room',
                shadow: [
                  Shadow(
                    color: Colors.white,
                    blurRadius: 20,
                    offset: Offset.zero,
                  ),
                ],
                fontWeight: FontWeight.bold,
                fontSize: 80,
              ),
              SizedBox(height: size.height * 0.025),
              CustomTextField(
                controller: _nameController,
                hintText: 'Enter your nickname',
              ),
              SizedBox(height: size.height * 0.010),
              CustomTextField(
                controller: _idController,
                hintText: 'Enter game ID',
              ),
              SizedBox(height: size.height * 0.025),
              CustomButton(
                onTap: () {
                  _socketClient.joinRoom(
                    _nameController.text,
                    _idController.text,
                  );
                },
                color: Colors.white,
                text: 'Join',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
