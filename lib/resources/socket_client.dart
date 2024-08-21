// Import the socket.io client package with a prefix for easier reference
import 'package:socket_io_client/socket_io_client.dart' as IO;

// Class to handle Socket.IO client functionality
class SocketClient {
  IO.Socket? socket; // Socket.IO socket instance
  static SocketClient? _instance; // Singleton instance of SocketClient

  // Private constructor to initialize the SocketClient instance
  SocketClient._internal() {
    // Initialize the Socket.IO client with server URL and options
    socket = IO.io(
      'http://192.168.100.248:3000', // URL of the Socket.IO server
      IO.OptionBuilder().setTransports(
              ['websocket']) // Use WebSocket as the transport protocol
          .build(), // Build the options
    );

    // Define event handlers for different socket events
    socket!.on('connect', (_) {
      // Callback for when the socket successfully connects
      print('Socket connected');
    });

    socket!.on('connect_error', (error) {
      // Callback for when there is a connection error
      print('Socket connection error: $error');
    });

    socket!.on('disconnect', (_) {
      // Callback for when the socket disconnects
      print('Socket disconnected');
    });

    // Establish a connection to the server
    socket!.connect();
  }

  // Singleton pattern implementation to ensure only one instance of SocketClient exists
  static SocketClient get instance {
    // If the instance does not exist, create a new one
    _instance ??= SocketClient._internal();
    // Return the single instance of SocketClient
    return _instance!;
  }
}
