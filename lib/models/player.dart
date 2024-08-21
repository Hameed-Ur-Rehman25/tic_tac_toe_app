class Player {
  final String nickname; // Player's nickname
  final String socketID; // Player's socket ID
  final String playerType; // Player's type (X or O)
  final double points; // Player's points

  Player({
    required this.nickname,
    required this.playerType,
    required this.socketID,
    required this.points,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'nickname': nickname,
      'socketID': socketID,
      'playerType': playerType,
      'points': points,
    };
  }

  factory Player.fromMap(Map<String, dynamic> map) {
    return Player(
      nickname: map['nickname'] ?? '', // Handle null values
      socketID: map['socketId'] ?? '', // Handle null values
      playerType: map['playerType'] ?? '', // Handle null values
      points: map['points']?.toDouble() ?? 0.0, // Handle null values
    );
  }

  Player copyWith({
    String? nickname,
    String? socketID,
    String? playerType,
    double? points,
  }) {
    return Player(
      nickname: nickname ?? this.nickname,
      socketID: socketID ?? this.socketID,
      playerType: playerType ?? this.playerType,
      points: points ?? this.points,
    );
  }
}
