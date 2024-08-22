const mongoose = require("mongoose"); // Import Mongoose library
const playerSchema = require("./player"); // Import the player schema

// Define the schema for room data
const roomSchema = new mongoose.Schema({
  // Number of players allowed in the room (default is 2)
  occupancy: {
    type: Number, // Data type for the occupancy field
    default: 2, // Default value if not explicitly set
  },
  // Maximum number of rounds that can be played in the room
  maxRound: {
    type: Number, // Data type for the maxRound field
    default: 5, // Default value if not explicitly set
  },
  // The current round number
  currentRound: {
    type: Number, // Data type for the currentRound field
    required: true, // This field must be provided
    default: 1, // Default value if not explicitly set
  },
  // List of players in the room (using the playerSchema)
  player: [playerSchema], // Array of player documents based on playerSchema
  // Indicates if the second player has joined the room (default is true)
  isjoin: {
    type: Boolean, // Data type for the isjoin field
    default: true, // Default value if not explicitly set
  },
  // The player whose turn it is (uses playerSchema)
  turn: playerSchema, // Single player document based on playerSchema
  // Index of the player whose turn it is (default is 0)
  turnIndex: {
    type: Number, // Data type for the turnIndex field
    default: 0, // Default value if not explicitly set
  },
});

// Create and export the Room model based on roomSchema
const roomModel = mongoose.model("Room", roomSchema); // Create a Mongoose model named "Room"
module.exports = roomModel; // Export the Room model for use in other parts of the application
