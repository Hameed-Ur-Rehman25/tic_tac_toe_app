import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tic_tac_toe_app/provider/room_data_provider.dart';
import 'package:tic_tac_toe_app/screens/create_room.dart';
import 'package:tic_tac_toe_app/screens/game_screen.dart';
import 'package:tic_tac_toe_app/screens/join_room.dart';
import 'package:tic_tac_toe_app/screens/main_menu_screen.dart';
import 'package:tic_tac_toe_app/utils/pallete.dart';

// Entry point of the Flutter application
void main() {
  runApp(
    const MyApp(), // Run the MyApp widget as the root of the widget tree
  );
}

// Root widget of the application
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      // Provide the RoomDataProvider to the widget tree
      create: (context) => RoomDataProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false, // Disable the debug banner
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor:
              backgroundColor, // Set the background color from a custom palette
          primaryColor: Colors.blue, // Set the primary color for the app
        ),
        routes: {
          // Define the routes for navigation in the app
          MainMenuScreen.routeName: (context) => const MainMenuScreen(),
          CreateRoom.routeName: (context) => const CreateRoom(),
          JoinRoom.routeName: (context) => const JoinRoom(),
          GameScreen.routeName: (context) => const GameScreen(),
        },
        initialRoute: MainMenuScreen
            .routeName, // Set the initial route to the MainMenuScreen
      ),
    );
  }
}
