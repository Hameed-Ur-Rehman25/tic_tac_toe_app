import 'package:flutter/material.dart';
import 'package:tic_tac_toe_app/resources/socket_methods.dart';
import 'package:tic_tac_toe_app/responsive/responsive.dart';
import 'package:tic_tac_toe_app/widgets/custom_button.dart';
import 'package:tic_tac_toe_app/widgets/custom_text.dart';
import 'package:tic_tac_toe_app/widgets/custom_text_field.dart';

class CreateRoom extends StatefulWidget {
  static String routeName = '/create-room';
  const CreateRoom({super.key});

  @override
  State<CreateRoom> createState() => _CreateRoomState();
}

class _CreateRoomState extends State<CreateRoom> {
  final TextEditingController _nameController = TextEditingController();
  final SocketMethods _socketMethods = SocketMethods();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
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
                text: 'Create Room',
                shadow: [
                  Shadow(
                    color: Colors.white,
                    blurRadius: 20,
                    offset: Offset.zero,
                  ),
                ],
                fontWeight: FontWeight.bold,
                fontSize: 70,
              ),
              SizedBox(height: size.height * 0.045),
              CustomTextField(
                controller: _nameController,
                hintText: 'Enter your nickname',
              ),
              SizedBox(height: size.height * 0.045),
              CustomButton(
                onTap: () {
                  _socketMethods.createRoom(_nameController.text);
                  _socketMethods.createRoomSuccessListener(context);
                },
                color: Colors.white,
                text: 'Create',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
