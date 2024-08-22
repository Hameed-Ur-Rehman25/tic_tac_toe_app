// Class representing a player in the game
class Player {
  final String nickname; // Player's nickname
  final String
      socketID; // Player's socket ID (used for identifying the player in a networked environment)
  final String playerType; // Player's type (X or O in a Tic-Tac-Toe game)
  final double points; // Player's accumulated points

  // Constructor to create a Player instance
  Player({
    required this.nickname,
    required this.playerType,
    required this.socketID,
    required this.points,
  });

  // Converts a Player instance to a map
  // Useful for serialization (e.g., saving to a database)
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'nickname': nickname,
      'socketID': socketID,
      'playerType': playerType,
      'points': points,
    };
  }

  // Factory constructor to create a Player instance from a map
  // Useful for deserialization (e.g., loading from a database)
  factory Player.fromMap(Map<String, dynamic> map) {
    return Player(
      nickname: map['nickname'] ??
          '', // Provide a default empty string if value is null
      socketID: map['socketID'] ??
          '', // Provide a default empty string if value is null
      playerType: map['playerType'] ??
          '', // Provide a default empty string if value is null
      points: map['points']?.toDouble() ??
          0.0, // Convert to double and provide default value if null
    );
  }

  // Creates a copy of the current Player instance with optional modifications
  // Allows for easy updates of Player instances without modifying the original
  Player copyWith({
    String? nickname,
    String? socketID,
    String? playerType,
    double? points,
  }) {
    return Player(
      nickname: nickname ??
          this.nickname, // Use provided value or keep the current value
      socketID: socketID ??
          this.socketID, // Use provided value or keep the current value
      playerType: playerType ??
          this.playerType, // Use provided value or keep the current value
      points:
          points ?? this.points, // Use provided value or keep the current value
    );
  }
}
