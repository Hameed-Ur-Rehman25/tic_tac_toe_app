// ignore: library_prefixes
import 'package:socket_io_client/socket_io_client.dart' as IO;

// Singleton class for managing the Socket.IO client connection
class SocketClient {
  IO.Socket? socket; // The Socket.IO socket instance
  static SocketClient? _instance; // Singleton instance of SocketClient

  // Private constructor for initializing the Socket.IO client
  SocketClient._internal() {
    // Create a new Socket.IO client instance with specified options
    socket = IO.io('http://yourIPaddress:3000', <String, dynamic>{
      'transports': ['websocket'], // Use WebSocket for transport
      'autoConnect': false, // Do not automatically connect on instantiation
    });

    // Establish the connection
    socket!.connect();
  }

  // Public method to get the singleton instance of SocketClient
  static SocketClient get instance {
    // Create the singleton instance if it doesn't exist
    _instance ??= SocketClient._internal();
    return _instance!;
  }
}
