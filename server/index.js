// Import necessary modules
const express = require("express");
const http = require("http");
const mongoose = require("mongoose");
const Room = require("./models/room");

// Initialize Express app
const app = express();
const port = process.env.PORT || 3000;
const server = http.createServer(app);
const io = require("socket.io")(server);

// Middleware to parse JSON request bodies
app.use(express.json());

// MongoDB connection string
const DB = ''; //mongo db path 



// Error-handling middleware
app.use((err, req, res, next) => {
  // Log the error stack to the server console
  console.error(err.stack);
  // Respond with a generic error message
  res.status(500).json({ message: 'Something went wrong!' });
});

// Connect to MongoDB
mongoose.connect(DB)
  .then(() => console.log("Connected to MongoDB successfully!"))
  .catch((e) => console.error("Failed to connect to MongoDB:", e));

// Start the HTTP server
server.listen(port, "0.0.0.0", () => {
  console.log("Server started and running on port " + port);
});


// Socket.IO connection event
io.on("connection", (socket) => {
  console.log("A new user connected");

  // Handle the 'createRoom' event
  socket.on("createRoom", async ({ nickname }) => {
    // Check if the nickname is provided
    if (!nickname) {
      socket.emit("errorOccurred", "Nickname is required.");
      return;
    }

    try {
      // Create a new room
      let room = new Room();
      // Create a new player with the given nickname
      let player = {
        nickname,
        socketId: socket.id,
        playerType: "X", // Player type 'X'
      };
      room.player.push(player); // Add the player to the room
      room.turn = player; // Set the turn to the new player
      room = await room.save(); // Save the room to the database

      // Get the room ID and emit a success message
      const roomId = room._id.toString();
      socket.join(roomId);
      io.to(roomId).emit("createRoomSuccess", room);
    } catch (error) {
      // Log and send an error message if something goes wrong
      console.error("Error creating room:", error);
      socket.emit("errorOccurred", "Failed to create room.");
    }
  });

  // Handle the 'joinRoom' event
  socket.on("joinRoom", async ({ nickname, roomId }) => {
    // Validate input data
    if (!nickname || !roomId) {
      socket.emit("errorOccurred", "Nickname and Room ID are required.");
      return;
    }

    try {
      // Check if the room ID format is valid
      if (!roomId.match(/^[0-9a-fA-F]{24}$/)) {
        socket.emit("errorOccurred", "Please enter a valid room ID.");
        return;
      }

      // Find the room by ID
      let room = await Room.findById(roomId);
      if (!room) {
        socket.emit("errorOccurred", "Room not found.");
        return;
      }

      // Check if the room is open for joining
      if (room.isjoin) {
        // Create a new player for the joining user
        let player = {
          nickname,
          socketId: socket.id,
          playerType: "O", // Player type 'O'
        };
        socket.join(roomId); // Join the socket to the room
        room.player.push(player); // Add the new player to the room
        room.isjoin = false; // Set the room status to 'closed'
        room = await room.save(); // Save the updated room

        // Emit events to notify all clients in the room
        io.to(roomId).emit("joinRoomSuccess", room);
        io.to(roomId).emit("updatePlayers", room.player);
        io.to(roomId).emit("updateRoom", room);
      } else {
        socket.emit("errorOccurred", "Game is in progress, try again later.");
      }
    } catch (error) {
      // Log and send an error message if something goes wrong
      console.log("Error joining room:", error);
      socket.emit("errorOccurred", "Failed to join room.");
    }
  });

  // Handle the 'tap' event
  socket.on("tap", async ({ index, roomId }) => {
    try {
      let room = await Room.findById(roomId);
      if (!room) {
        socket.emit("errorOccurred", "Room not found.");
        return;
      }

      // Determine the current player's choice
      let choice = room.turn.playerType;
      // Switch turns
      room.turn = room.player[room.turnIndex === 0 ? 1 : 0];
      room.turnIndex = room.turnIndex === 0 ? 1 : 0;
      room = await room.save(); // Save the updated room

      // Emit the tapped event to all clients in the room
      io.to(roomId).emit("tapped", {
        index,
        choice,
        room,
      });
    } catch (error) {
      // Log and send an error message if something goes wrong
      console.log("Error in tap listener:", error);
      socket.emit("errorOccurred", "Failed to process tap.");
    }
  });

  // Handle the 'winner' event
  socket.on("winner", async ({ winnerSocketId, roomId }) => {
    try {
      let room = await Room.findById(roomId);
      if (!room) {
        socket.emit("errorOccurred", "Room not found.");
        return;
      }

      // Find the player who won
      let player = room.player.find(playerr => playerr.socketId === winnerSocketId);
      if (!player) {
        socket.emit("errorOccurred", "Player not found.");
        return;
      }

      // Update the player's points
      player.points += 1;
      room = await room.save();

      // Determine if the game should end or continue
      if (player.points >= room.maxRound) {
        io.to(roomId).emit("endGame", player);
      } else {
        io.to(roomId).emit("pointIncrease", player);
      }
    } catch (error) {
      // Log and send an error message if something goes wrong
      console.log("Error in winner event:", error);
      socket.emit("errorOccurred", "Failed to process winner.");
    }
  });
});


