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
  socket.on("createRoom", ({ roomName, password, userModel }) => {
    const roomId = helper.generateRoomId();

    if (userModel === null) {
      userModel = new User.UserModel("Admin", null, null);
    }

    if (userModel.image === "null") {
      userModel.image = null;
    }

    const user = new User.User(userModel, socket.id);

    activeRooms[roomId] = {
      roomName,
      password,
      code: "// write here",
      users: [user],
    };

    console.log(activeRooms[roomId].users[0].userModel.username);

    socket.join(roomId);

    socket.emit("roomCreated", {
      roomName,
      activeUsers: activeRooms[roomId].users,
      roomId,
      password,
      code: activeRooms[roomId].code,
      message: "Successfully created the room",
      success: true,
    });
  });

  // join the room
  socket.on("joinRoom", ({ roomId, password, userModel }) => {
    const isRoomPresent = activeRooms[roomId];
    if (isRoomPresent) {
      const roomDetails = activeRooms[roomId];
      if (roomDetails["password"] === password) {
        if (userModel === null) {
          userModel = new User.UserModel(
            `Guest ${activeRooms[roomId].users.length}`,
            null,
            null
          );
        }

        if (userModel.image === "null") {
          userModel.image = null;
        }

        const user = new User.User(userModel, socket.id);

        activeRooms[roomId].users.push(user);

        io.to(roomId).emit("afterJoin", { activeUser: user });

        socket.join(roomId);

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
    console.log(code);
    socket.in(roomId).emit("codeChange", code);
  });

  // room user disconnected
  socket.on("disconnect", async () => {
    for (const roomId in activeRooms) {
      const users = activeRooms[roomId]["users"];
      for (let index = 0; index < users.length; index++) {
        const user = users[index];
        if (user.id == socket.id) {
          activeRooms[roomId].users.splice(index, 1);
          if (activeRooms[roomId].users.length == 0) {
            delete activeRooms[roomId];
          }
          io.to(roomId).emit("disconnected", socket.id);
        }
      }
    }
  });
});

app.get("/clearRooms", (req, res, next) => {
  activeRooms = {};
  res.send(
    `<div style="text-align: center; margin-top: 20%; width: 100%; font-family: monospace;">
    <h2>All active rooms have been cleared</h2>
    </div>`
  );
});

app.get("/", (req, res, next) => {
  res.send(
    `<div style="text-align: center; margin-top: 20%; width: 100%; font-family: monospace;">
    <h2>Welcome to CollabPAD!</h2>
    <h3>This api base url, Please use CollabPad web app.</h3>
    </div>`
  );
});

const PORT = process.env.PORT | 3000;

server.listen(PORT, () => {
  console.log(`Server Listening on port no ${PORT}`);
});
