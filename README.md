

# Multiplayer Tic Tac Toe

## Overview

Welcome to the Multiplayer Tic Tac Toe project! This real-time multiplayer version of the classic Tic Tac Toe game allows players to create and join rooms to compete against each other. The project uses Node.js, Express, and MongoDB for the backend, with Socket.IO handling real-time communication.

## Features

- **Create and Join Rooms:** Users can create their own game rooms or join existing ones.
- **Real-Time Gameplay:** Utilizes Socket.IO for smooth, real-time updates.
- **User Management:** Basic user session handling for different players in various rooms.
- **Persistent Data:** MongoDB stores game history and user data.

## Technologies Used

- **Node.js**: JavaScript runtime for server-side logic.
- **Express**: Web framework for Node.js.
- **Socket.IO**: Library for real-time, bidirectional communication.
- **MongoDB**: NoSQL database for data storage.

## Installation

To set up the project, follow these steps:

1. **Clone the Repository**

   ```bash
   git clone https://github.com/Hameed-Ur-Rehman25/tic_tac_toe_app.git
   cd tic_tac_toe_app
   ```

2. **Install Dependencies**

   Make sure you have Node.js and npm installed. Install the required packages with:

   ```bash
   npm install
   ```

3. **Configure Environment Variables**

   Create a `.env` file in the root directory with the following content:

   ```plaintext
   MONGO_URI=your_mongodb_connection_string
   PORT=3000
   ```

   Replace `your_mongodb_connection_string` with your actual MongoDB connection URI.

4. **Update MongoDB Path**

   Navigate to the `server` folder and open `index.js`. Ensure that the MongoDB path is correctly linked to your `.env` file. For example:

   ```javascript
   const mongoose = require('mongoose');
   require('dotenv').config();

   mongoose.connect(process.env.MONGO_URI, {
     useNewUrlParser: true,
     useUnifiedTopology: true,
   })
   .then(() => console.log('MongoDB connected'))
   .catch(err => console.log(err));
   ```

5. **Configure Socket.IO Client**

   In the `lib/resources` folder, locate the `socketClient.js` file. Update it to include your server's IP address:

   ```javascript
   const socket = io('http://your_server_ip_address:3000');
   ```

   Replace `your_server_ip_address` with the IP address where your server will be running.

6. **Run the Application**

   Open a terminal, navigate to the `server` directory, and start the server with:

   ```bash
   cd server
   npm run dev
   ```

   The server will start running on `http://localhost:3000`.

## Project Structure

- **`server/`**: Contains the backend logic for the application.
  - **`index.js`**: Main entry point for the server. Configure your MongoDB connection here.

- **`lib/`**: Contains libraries and utilities used by the application.
  - **`resources/`**: Includes resources such as the Socket.IO client and other shared components.
    - **`socketClient.js`**: Update this file with your server’s IP address.

## Usage

1. **Create a Room**

   - Navigate to the homepage.
   - Click "Create Room" to generate a new room with a unique ID.

2. **Join a Room**

   - Enter the room ID you wish to join.
   - Click "Join Room" to participate.

3. **Play the Game**

   - Make your moves on the Tic Tac Toe grid.
   - The game state updates in real-time for all players in the room.

## Contributing

Contributions are welcome! To contribute:

1. **Fork the Repository**
2. **Create a New Branch**
3. **Implement Your Changes**
4. **Submit a Pull Request**

<img width="1680" alt="Screenshot 2024-08-21 at 5 08 25 PM" src="https://github.com/user-attachments/assets/10f67215-2a92-4166-af7a-7d97d7dec420">
