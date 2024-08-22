const { default: mongoose } = require("mongoose");

// Define the schema for player data
const playerSchema = new mongoose.Schema({
  // Nickname of the player
  nickname: {
    type: String, // Data type for nickname
    trim: true, // Automatically removes whitespace from both ends of the string
  },
  // Unique identifier for the player's connection, provided by the MongoDB
  socketId: {
    type: String, // Data type for socketId
    unique: true, // Ensures that each socketId is unique in the collection to prevent duplicates
  },
  // Points associated with the player
  points: {
    type: Number, // Data type for points
    default: 0, // Default value is 0 if no points are specified
  },
  // Type/category of the player (e.g., "X" or "O" in a Tic-Tac-Toe game)
  playerType: {
    type: String, // Data type for playerType
    required: true, // This field is mandatory; must be provided
  },
});

// Export the schema for use in other parts of the application
module.exports = playerSchema;
