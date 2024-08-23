// Import necessary modules
const express = require("express");
const http = require("http");
const mongoose = require("mongoose");
const Room = require("./models/room");
require('dotenv').config(); // Import and configure dotenv

// Initialize Express app
const app = express();
const port = process.env.PORT || 3000;
const server = http.createServer(app);
const io = require("socket.io")(server);

// Middleware to parse JSON request bodies
app.use(express.json());

// MongoDB connection string from environment variables
const DB = process.env.MONGODB_URI;

// Error-handling middleware
app.use((err, req, res, next) => {
  console.error(err.stack); // Log the error stack to the server console
  res.status(500).json({ message: 'Something went wrong!' }); // Respond with a generic error message
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
    if (!nickname) {
      socket.emit("errorOccurred", "Nickname is required.");
      return;
    }

    try {
      let room = new Room();
      let player = {
        nickname,
        socketId: socket.id,
        playerType: "X",
      };
      room.player.push(player);
      room.turn = player;
      room = await room.save();

      const roomId = room._id.toString();
      socket.join(roomId);
      io.to(roomId).emit("createRoomSuccess", room);
    } catch (error) {
      console.error("Error creating room:", error);
      socket.emit("errorOccurred", "Failed to create room.");
    }
  });

  // Handle the 'joinRoom' event
  socket.on("joinRoom", async ({ nickname, roomId }) => {
    if (!nickname || !roomId) {
      socket.emit("errorOccurred", "Nickname and Room ID are required.");
      return;
    }

    try {
      if (!roomId.match(/^[0-9a-fA-F]{24}$/)) {
        socket.emit("errorOccurred", "Please enter a valid room ID.");
        return;
      }

      let room = await Room.findById(roomId);
      if (!room) {
        socket.emit("errorOccurred", "Room not found.");
        return;
      }

      if (room.isjoin) {
        let player = {
          nickname,
          socketId: socket.id,
          playerType: "O",
        };
        socket.join(roomId);
        room.player.push(player);
        room.isjoin = false;
        room = await room.save();

        io.to(roomId).emit("joinRoomSuccess", room);
        io.to(roomId).emit("updatePlayers", room.player);
        io.to(roomId).emit("updateRoom", room);
      } else {
        socket.emit("errorOccurred", "Game is in progress, try again later.");
      }
    } catch (error) {
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

      let choice = room.turn.playerType;
      room.turn = room.player[room.turnIndex === 0 ? 1 : 0];
      room.turnIndex = room.turnIndex === 0 ? 1 : 0;
      room = await room.save();

      io.to(roomId).emit("tapped", {
        index,
        choice,
        room,
      });
    } catch (error) {
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

      let player = room.player.find(playerr => playerr.socketId === winnerSocketId);
      if (!player) {
        socket.emit("errorOccurred", "Player not found.");
        return;
      }

      player.points += 1;
      room = await room.save();

      if (player.points >= room.maxRound) {
        io.to(roomId).emit("endGame", player);
      } else {
        io.to(roomId).emit("pointIncrease", player);
      }
    } catch (error) {
      console.log("Error in winner event:", error);
      socket.emit("errorOccurred", "Failed to process winner.");
    }
  });
});
