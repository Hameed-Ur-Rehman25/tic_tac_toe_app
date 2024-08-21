import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tic_tac_toe_app/provider/room_data_provider.dart';
import 'package:tic_tac_toe_app/screens/create_room.dart';
import 'package:tic_tac_toe_app/screens/game_screen.dart';
import 'package:tic_tac_toe_app/screens/join_room.dart';
import 'package:tic_tac_toe_app/screens/main_menu_screen.dart';
import 'package:tic_tac_toe_app/utils/pallete.dart';

void main() {
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => RoomDataProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: backgroundColor,
          primaryColor: Colors.blue,
        ),
        routes: {
          MainMenuScreen.routeName: (context) => const MainMenuScreen(),
          CreateRoom.routeName: (context) => const CreateRoom(),
          JoinRoom.routeName: (context) => const JoinRoom(),
          GameScreen.routeName: (context) => const GameScreen(),
        },
        initialRoute: MainMenuScreen.routeName,
      ),
    );
  }
}
