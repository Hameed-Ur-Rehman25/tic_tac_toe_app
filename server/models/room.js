const mongoose = require("mongoose");
const playerSchema = require("./player");

// Define the schema for room data
const roomSchema = new mongoose.Schema({
  // Number of players allowed in the room (default is 2)
  occupancy: {
    type: Number,
    default: 2, // Default value if not explicitly set
  },
  // Maximum number of rounds that can be played in the room
  maxRound: {
    type: Number,
    default: 5, // Default value if not explicitly set
  },
  // The current round number
  currentRound: {
    type: Number,
    required: true, // This field must be provided
    default: 1, // Default value if not explicitly set
  },
  // List of players in the room (using the playerSchema)
  player: [playerSchema],
  // Indicates if the second player has joined the room (default is true)
  isjoin: {
    type: Boolean,
    default: true, // Default value if not explicitly set
  },
  // The player whose turn it is (uses playerSchema)
  turn: playerSchema,
  // Index of the player whose turn it is (default is 0)
  turnIndex: {
    type: Number,
    default: 0, // Default value if not explicitly set
  },
});

// Create and export the Room model based on roomSchema
const roomModel = mongoose.model("Room", roomSchema);
module.exports = roomModel;
