import 'dart:async';

import 'package:collabpad/core/failure/app_failure.dart';
import 'package:collabpad/core/models/room_model.dart';
import 'package:collabpad/core/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:fpdart/fpdart.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

part 'auth_remote_repository.g.dart';

@riverpod
AuthRemoteRepository authRemoteRepository(AuthRemoteRepositoryRef ref) {
  return AuthRemoteRepository();
}

class AuthRemoteRepository {
  late io.Socket socket;
  late StreamController<ActiveUser> _afterJoinStreamController;
  late StreamController<String> _afterDisconnetStreamController;
  late StreamController<String> onCodeChangeStreamController;

  // Static instance for singleton pattern
  static final AuthRemoteRepository _instance =
      AuthRemoteRepository._internal();

  // Private constructor
  AuthRemoteRepository._internal() {
    // Initialize the socket connection here if needed
  }

  void closeSocketConnection() {
    _afterJoinStreamController.close();
    _afterDisconnetStreamController.close();
    onCodeChangeStreamController.close();
    socket.onDisconnect(
      (data) {
        debugPrint("socketDisconnected");
      },
    );
    socket.dispose();
  }

  // Factory constructor to return the static instance
  factory AuthRemoteRepository() {
    return _instance;
  }

  Future<void> connectSocket() async {
    _afterJoinStreamController = StreamController<ActiveUser>.broadcast();
    _afterDisconnetStreamController = StreamController<String>.broadcast();
    onCodeChangeStreamController = StreamController<String>.broadcast();

    String base = "https://collabpad.onrender.com";
    // String base = "http://127.0.0.1:3000";
    // dotenv.get("BASE");
    socket = io.io(base, <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });

    socket.connect();

    socket.onConnect((data) {
      onDisconnectUser();
      debugPrint("Socket Connected");
    });
  }

  Future<Either<AppFailure, RoomModel>> createRoom({
    required String roomName,
    required String password,
    UserModel? userModel,
  }) async {
    final completer = Completer<Either<AppFailure, RoomModel>>();
    try {
      socket.emit("createRoom", {
        "roomName": roomName,
        "password": password,
        "userModel": userModel,
      });
      socket.on("roomCreated", (data) {
        // debugPrint(data.toString());
        if (!completer.isCompleted) {
          afterJoinRoom();
          completer.complete(Right(RoomModel.fromMap(data)));
        }
      });

      // Add a timeout to handle cases where the server doesn't respond
      Future.delayed(const Duration(seconds: 20), () {
        if (!completer.isCompleted) {
          completer.complete(
              Left(AppFailure("Timeout exceed! failed to created the room")));
        }
      });
    } catch (e) {
      if (!completer.isCompleted) {
        completer.complete(Left(AppFailure(e.toString())));
      }
    }

    return completer.future;
  }

  Future<Either<AppFailure, RoomModel>> joinRoom({
    required String roomId,
    required String password,
    UserModel? userModel,
  }) async {
    final completer = Completer<Either<AppFailure, RoomModel>>();
    try {
      socket.emit("joinRoom", {
        "roomId": roomId,
        "password": password,
        "userModel": userModel,
      });
      socket.on("onJoinRoom", (data) {
        // debugPrint(data.toString());
        if (!completer.isCompleted) {
          afterJoinRoom();
          bool success = data["success"];
          if (success) {
            completer.complete(Right(RoomModel.fromMap(data)));
          } else {
            completer.complete(Left(AppFailure(data["message"])));
          }
        }
      });

      // Add a timeout to handle cases where the server doesn't respond
      Future.delayed(const Duration(seconds: 20), () {
        if (!completer.isCompleted) {
          completer.complete(
              Left(AppFailure("Timeout exceed! failed to join the room")));
        }
      });
    } catch (e) {
      if (!completer.isCompleted) {
        completer.complete(Left(AppFailure(e.toString())));
      }
    }

    return completer.future;
  }

  Stream<String> get afterDisconnectStream =>
      _afterDisconnetStreamController.stream;

  Future<void> onDisconnectUser() async {
    socket.on("disconnected", (data) {
      debugPrint("User disconnected: ${data.toString()}");
      _afterDisconnetStreamController.add(data.toString());
    });
  }

  Stream<ActiveUser> get afterJoinStream => _afterJoinStreamController.stream;

  Future<void> afterJoinRoom() async {
    socket.on("afterJoin", (data) {
      ActiveUser newUser = ActiveUser.fromMap(data["activeUser"]);
      _afterJoinStreamController.add(newUser);
    });
  }

  Stream<String> get onCodeChangeStream => onCodeChangeStreamController.stream;

  Future<void> onCodeChange() async {
    socket.on("codeChange", (data) {
      onCodeChangeStreamController.add(data.toString());
    });
  }

  Future<void> emitCodeChange({
    required String roomId,
    required String code,
  }) async {
    socket.emit("codeChange", {"roomId": roomId, "code": code});
  }
}
