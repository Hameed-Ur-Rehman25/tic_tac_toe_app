const { default: mongoose } = require("mongoose");

// Define the schema for player data
const playerSchema = new mongoose.Schema({
  // Nickname of the player
  nickname: {
    type: String,
    trim: true, // Remove whitespace from both ends
  },
  // Unique identifier for the player's connection, provided by the MongoDB
  socketId: {
    type: String,
    unique: true, // Ensures that each socketId is unique in the collection
  },
  // Points associated with the player
  points: {
    type: Number,
    default: 0, // Default value if no points are specified
  },
  // Type/category of the player (e.g., "beginner", "advanced")
  playerType: {
    type: String,
    required: true, // This field must be provided
  },
});

// Export the schema for use in other parts of the application
module.exports = playerSchema;
