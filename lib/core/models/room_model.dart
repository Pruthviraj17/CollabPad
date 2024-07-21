// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:vpn_apk/core/models/user_model.dart';

class ActiveUser {
  final UserModel? userModel;
  final String? id;

  ActiveUser({required this.userModel, required this.id});

  ActiveUser copyWith({
    UserModel? userModel,
    String? id,
  }) {
    return ActiveUser(
      userModel: userModel,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userModel': userModel,
      'id': id,
    };
  }

  factory ActiveUser.fromMap(Map<String, dynamic> map) {
    return ActiveUser(
      userModel: UserModel.fromJson(map['userModel']),
      id: map['id'] ?? "",
    );
  }

  String toJson() => json.encode(toMap());

  factory ActiveUser.fromJson(String source) =>
      ActiveUser.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'ActiveUser(username: $userModel, id: $id)';

  @override
  bool operator ==(covariant ActiveUser other) {
    if (identical(this, other)) return true;

    return other.userModel == userModel && other.id == id;
  }

  @override
  int get hashCode => userModel.hashCode ^ id.hashCode;
}

class RoomModel {
  final String? roomName;
  final String? roomId;
  final List<ActiveUser>? activeUsers;
  final String? password;
  final String? message;
  final bool? success;
  final String? code;

  RoomModel({
    required this.roomName,
    required this.roomId,
    required this.activeUsers,
    required this.password,
    required this.message,
    required this.success,
    required this.code,
  });

  RoomModel copyWith({
    String? roomName,
    String? roomId,
    List<ActiveUser>? activeUsers,
    String? password,
    String? message,
    bool? success,
    String? code,
  }) {
    return RoomModel(
      roomName: roomName ?? this.roomName,
      roomId: roomId ?? this.roomId,
      activeUsers: activeUsers ?? this.activeUsers,
      password: password ?? this.password,
      message: message ?? this.message,
      success: success ?? this.success,
      code: code ?? this.code,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'roomName': roomName,
      'roomId': roomId,
      'activeUsers': activeUsers?.map((x) => x.toMap()).toList(),
      'password': password,
      'message': message,
      'success': success,
      'code': code,
    };
  }

  // Corrected `fromMap` constructor
  factory RoomModel.fromMap(Map<String, dynamic> map) {
    // try {
    return RoomModel(
      roomName: map['roomName'] as String?,
      roomId: map['roomId'] as String?,
      activeUsers: map['activeUsers'] != null
          ? List<ActiveUser>.from(
              (map['activeUsers'] as List<dynamic>).map<ActiveUser>(
                (x) => ActiveUser.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
      password: map['password'] as String?,
      message: map['message'] as String?,
      success: map['success'] as bool?,
      code: map['code'] as String?,
    );
    // } catch (e, stackTrace) {
    //   print('Error in fromMap: $e');
    //   print(stackTrace);
    //   rethrow;
    // }
  }

  String toJson() => json.encode(toMap());

  factory RoomModel.fromJson(String source) =>
      RoomModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'RoomModel(roomName: $roomName, roomId: $roomId, activeUsers: $activeUsers, password: $password, message: $message, success: $success, code: $code)';
  }

  @override
  bool operator ==(covariant RoomModel other) {
    if (identical(this, other)) return true;

    return other.roomName == roomName &&
        other.roomId == roomId &&
        listEquals(other.activeUsers, activeUsers) &&
        other.password == password &&
        other.message == message &&
        other.success == success &&
        other.code == code;
  }

  @override
  int get hashCode {
    return roomName.hashCode ^
        roomId.hashCode ^
        activeUsers.hashCode ^
        password.hashCode ^
        message.hashCode ^
        success.hashCode ^
        code.hashCode;
  }
}
