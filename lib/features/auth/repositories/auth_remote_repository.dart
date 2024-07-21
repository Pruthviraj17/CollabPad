import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:fpdart/fpdart.dart';
import 'package:vpn_apk/core/failure/app_failure.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;
import 'package:vpn_apk/core/models/room_model.dart';
import 'package:vpn_apk/core/models/user_model.dart';
part 'auth_remote_repository.g.dart';

@riverpod
AuthRemoteRepository authRemoteRepository(AuthRemoteRepositoryRef ref) {
  return AuthRemoteRepository();
}

final codeStateProvider = StateProvider<String>((ref) => '//write here');

class AuthRemoteRepository {
  late io.Socket socket;
  final _afterJoinStreamController = StreamController<ActiveUser>.broadcast();
  final _afterDisconnetStreamController = StreamController<String>.broadcast();
  final _onCodeChangeStreamController = StreamController<String>.broadcast();

  // Static instance for singleton pattern
  static final AuthRemoteRepository _instance =
      AuthRemoteRepository._internal();

  // Private constructor
  AuthRemoteRepository._internal() {
    // Initialize the socket connection here if needed
    _connectSocket();
  }

  void closeSocketConnection() {
    _afterJoinStreamController.close();
    _afterDisconnetStreamController.close();
    _onCodeChangeStreamController.close();
    socket.disconnect();
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

  Future<void> _connectSocket() async {
    String base = dotenv.get("BASE");
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
        debugPrint(data.toString());
        if (!completer.isCompleted) {
          afterJoinRoom();
          completer.complete(Right(RoomModel.fromMap(data)));
        }
      });

      // Add a timeout to handle cases where the server doesn't respond
      Future.delayed(const Duration(seconds: 10), () {
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
        debugPrint(data.toString());
        if (!completer.isCompleted) {
          afterJoinRoom();
          completer.complete(Right(RoomModel.fromMap(data)));
        }
      });

      // Add a timeout to handle cases where the server doesn't respond
      Future.delayed(const Duration(seconds: 10), () {
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
      debugPrint("New user joined room: ${newUser.toString()}");
      _afterJoinStreamController.add(newUser);
    });
  }

  Stream<String> get onCodeChangeStream => _onCodeChangeStreamController.stream;

  Future<void> onCodeChange() async {
    socket.on("codeChange", (data) {
      debugPrint(data.toString());
      _onCodeChangeStreamController.add(data.toString());
      // ref.read(codeStateProvider.notifier).state = data["code"].toString();
    });
  }

  Future<void> emitCodeChange({
    required String roomId,
    required String code,
  }) async {
    socket.emit("codeChange", {"roomId": roomId, "code": code});
  }
}
