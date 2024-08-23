// Importing necessary modules
const express = require("express"); // Express framework for creating the server
const http = require("http"); // Core HTTP module to create an HTTP server
const mongoose = require("mongoose"); // Mongoose library for MongoDB interactions

const Room = require("./models/room.js"); // Import the Room model

// Initialize Express app
const app = express(); // Creating an Express application instance
const port = process.env.PORT || 3000; // Port for the server to listen on, default to 3000
const server = http.createServer(app); // Create an HTTP server using Express app
const io = require("socket.io")(server); // Initialize Socket.IO with the HTTP server

app.use(express.json()); // Middleware to parse incoming JSON requests

// MongoDB connection string
const DB =
  "";

// Socket.IO connection event
io.on("connection", (socket) => {
  console.log("Connected!"); // Log when a new socket connection is established

  // Handle 'createRoom' event
  socket.on("createRoom", async ({ nickname }) => {
    console.log(nickname); // Log the nickname of the player creating the room

    try {
      // Create a new Room instance
      let room = new Room();
      // Create a new player object
      let player = {
        nickname, // Shorthand for nickname: nickname
        socketId: socket.id, // Assign the socket ID to the player
        playerType: "X", // Set player type to "X" (could be a game-specific designation)
      };
      room.player.push(player); // Add the player to the room
      room.turn = player; // Set the turn to the newly created player
      room = await room.save(); // Save the room to the database
      console.log(room); // Log the room details

      const roomId = room._id.toString(); // Convert room ID to string
      socket.join(roomId); // Join the socket to the room
      io.to(roomId).emit("createRoomSuccess", room); // Notify all clients in the room about successful room creation
    } catch (error) {
      console.error("Error creating room:", error); // Log errors if room creation fails
    }
  });

  // Handle 'joinRoom' event
  socket.on("joinRoom", async ({ nickname, roomId }) => {
    console.log(`${nickname} roomid is ${roomId}`); // Log the nickname and room ID

    try {
      // Validate the room ID format
      if (!roomId.match(/^[0-9a-fA-F]{24}$/)) {
        socket.emit("errorOccurred", "Please enter valid room ID"); // Notify the client if the room ID is invalid
        return;
      }
      // Find the room by ID
      let room = await Room.findById(roomId);

      // Check if the room is still open for joining
      if (room.isjoin) {
        // Create a new player object
        let player = {
          nickname, // Shorthand for nickname: nickname
          socketId: socket.id, // Assign the socket ID to the player
          playerType: "O", // Set player type to "O" (could be a game-specific designation)
        };
        socket.join(roomId); // Join the socket to the room
        room.player.push(player); // Add the player to the room
        room.isjoin = false; // Mark the room as closed for joining
        room = await room.save(); // Save the updated room to the database
        io.to(roomId).emit("joinRoomSuccess", room); // Notify all clients in the room about the new player
        io.to(roomId).emit("updatePlayers", room.player); // Update all clients with the current list of players
        io.to(roomId).emit("updateRoom", room); // Update all clients with the current room state
      } else {
        socket.emit("errorOccurred", "Game is in progress, try again later."); // Notify the client if the game is in progress
      }
    } catch (error) {
      console.log("Error joining room:", error); // Log errors if joining the room fails
    }
  });

  // Handle 'tap' event (player taps a grid cell)
  socket.on("tap", async ({ index, roomId }) => {
    try {
      let room = await Room.findById(roomId);
      let choice = room.turn.playerType; // 'X' or 'O'
      // Switch turn to the other player
      if (room.turnIndex === 0) {
        room.turn = room.player[1];
        room.turnIndex = 1;
      } else {
        room.turn = room.player[0];
        room.turnIndex = 0;
      }
      room = await room.save();

      io.to(roomId).emit("tapped", {
        index, // Index of the tapped grid cell
        choice, // The player's choice ('X' or 'O')
        room, // Current state of the room
      });
    } catch (error) {
      console.log("Error Occurred in tap Listener.The Error is " + error); // Log errors if the tap event fails
    }
  });

  // Handle 'winner' event (when a player wins)
  socket.on("winner", async ({ winnerSocketId, roomId }) => {
    try {
      let room = await Room.findById(roomId);
      let player = room.players.find(
        (playerr) => playerr.socketId === winnerSocketId
      );
      player.points += 1; // Increase the winner's points
      room = await room.save();

      if (player.points >= room.maxRounds) {
        io.to(roomId).emit("endGame", player); // Notify all clients that the game has ended
      } else {
        io.to(roomId).emit("pointIncrease", player); // Notify all clients of the point increase
      }
    } catch (e) {
      console.log(e); // Log errors if updating the winner fails
    }
  });
});

// Connect to MongoDB
mongoose
  .connect(DB) // Connect to the MongoDB database using the connection string
  .then(() => {
    console.log("Connected to MongoDB successfully!"); // Log success message on successful connection
  })
  .catch((e) => {
    console.error("Failed to connect to MongoDB:", e); // Log error if the connection fails
  });

// Start the HTTP server
server.listen(port, "0.0.0.0", () => {
  console.log("Server started and running on port " + port); // Log message when the server starts
});
