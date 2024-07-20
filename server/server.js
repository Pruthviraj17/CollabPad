const express = require("express");
const app = express();
const http = require("http");
const cors = require("cors");
const { Server } = require("socket.io");

const server = http.createServer(app);
const io = new Server(server);

// from local
const helper = require("./utils/helper");
const User = require("./models/user");

app.use(cors());
app.use(express.json());

const activeRooms = {};

// create room function
io.on("connection", (socket) => {
  // create the room
  socket.on("createRoom", ({ roomName, password, userDetails }) => {
    const roomId = helper.generateRoomId();

    userName = userDetails === undefined ? `Admin` : userDetails;
    const user = new User(userName, socket.id);

    activeRooms[roomId] = { roomName, password, users: [user] };

    socket.join(roomId);

    socket.emit("roomCreated", {
      roomName,
      activeUsers: activeRooms[roomId].users,
      roomId,
      password,
      message: "Successfully created the room",
      success: true,
    });
  });

  // join the room
  socket.on("joinRoom", ({ roomId, password, userDetails }) => {
    const isRoomPresent = activeRooms[roomId];
    if (isRoomPresent) {
      const roomDetails = activeRooms[roomId];
      if (roomDetails["password"] === password) {
        userName = userDetails === undefined ? `Guest` : userDetails;
        const user = new User(userName, socket.id);

        console.log(`UserDetails: ${userDetails}`);
        activeRooms[roomId].users.push(user);

        console.log(activeRooms);

        io.to(roomId).emit("userJoined", { userDetails });

        socket.join(roomId);

        socket.broadcast.emit("afterJoin", {
          activeUser: user,
        });

        socket.emit("onJoinRoom", {
          roomName: activeRooms[roomId]["roomName"],
          activeUsers: activeRooms[roomId].users,
          roomId,
          password,
          code: activeRooms[roomId].code,
          message: "Successfully joined the room",
          success: true,
        });
      } else {
        socket.emit("onJoinRoom", {
          message: "Incorrect password",
          success: false,
        });
      }
    } else {
      // users = activeRooms;
      socket.emit("onJoinRoom", {
        message: `Room ${roomId} does not exist`,
        success: false,
      });
    }
  });

  socket.on("codeChange", ({ roomId, code }) => {
    activeRooms[roomId].code = code;
    console.log(`code change ${code}`);
    socket.in(roomId).emit("codeChange", { code });
  });

  // room user disconnected
  socket.on("disconnect", async () => {
    console.log("A user disconnected:", socket.id);
    // for (const roomId in activeRooms) {
    //   const room = activeRooms[roomId];

    //   // Ensure room has users
    //   if (room.users) {
    //     // Iterate over each user in the users map
    //     for (const username in room.users) {
    //       const user = room.users[username];

    //       // Check if the user's id matches the socket.id
    //       if (user.id === socket.id) {
    //         console.log(`User found: ${username}`);
    //         delete room.users[username];
    //         // Optionally, perform additional actions here
    //         break; // Exit the loop if the user is found
    //       }
    //     }
    //   }
    // }

    for (const roomId in activeRooms) {
      const users = activeRooms[roomId]["users"];
      for (let index = 0; index < users.length; index++) {
        const user = users[index];
        if (user.id == socket.id) {
          console.log("user found at index: " + index);
          activeRooms[roomId].users.splice(index, 1);
        }
      }
    }

    socket.broadcast.emit("disconnected", socket.id);
  });
});

app.get("/roomid", (req, res, next) => {
  res.json({
    message: "Server Running Successfully",
    roomId: helper.generateRoomId(),
  });
});

const PORT = process.env.PORT | 3000;

server.listen(PORT, () => {
  console.log(`Server Listening on port no ${PORT}`);
});
