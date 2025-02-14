import 'dart:async';

import 'package:collabpad/core/models/room_model.dart';
import 'package:collabpad/core/models/user_model.dart';
import 'package:collabpad/core/providers/user_model_notifier.dart';
import 'package:collabpad/features/auth/repositories/auth_local_repository.dart';
import 'package:collabpad/features/auth/repositories/auth_remote_repository.dart';
import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_viewmodel.g.dart';

@riverpod
class AuthViewmodel extends _$AuthViewmodel {
  late AuthLocalRepository _authLocalRepository;
  late AuthRemoteRepository _authRemoteRepository;

  @override
  AsyncValue<RoomModel>? build() {
    _authLocalRepository = ref.watch(authLocalRepositoryProvider);
    _authRemoteRepository = ref.watch(authRemoteRepositoryProvider);
    return null;
  }

  Future<void> init() async {
    _authLocalRepository.init();
  }

  Future<void> createRoom({
    required String roomName,
    required String password,
    UserModel? userModel,
  }) async {

    state = const AsyncValue.loading();
    _authRemoteRepository.connectSocket();
    final res = await _authRemoteRepository.createRoom(
        roomName: roomName, password: password, userModel: userModel);
    final val = switch (res) {
      Left(value: final l) => state =
          AsyncValue.error(l.message, StackTrace.current),
      Right(value: final r) => state = AsyncValue.data(r),
    };

  }

  Future<void> joinRoom({
   required String roomId,
    required String password,
    UserModel? userModel,
  }) async {

    state = const AsyncValue.loading();
    _authRemoteRepository.connectSocket();
    final res = await _authRemoteRepository.joinRoom(
        roomId: roomId, password: password, userModel: userModel);
    final val = switch (res) {
      Left(value: final l) => state =
          AsyncValue.error(l.message, StackTrace.current),
      Right(value: final r) => state = AsyncValue.data(r),
    };
    
  }

  bool setUser({UserModel? userInfo}) {
    return _authLocalRepository.setUser(userInfo: userInfo);
  }

  Future<UserModel?> getUser() async {
    return await _authLocalRepository.getUserInfo();
  }

  Future<bool> removeUser() async {
    bool sucess = await _authLocalRepository.removeUser();
    if (sucess) {
      ref.read(userModelNotifierProvider.notifier).removeuser();
    }
    return sucess;
  }

  bool setThemeColor(Color color) {
    return _authLocalRepository.setThemeColor(color);
  }

  bool resetTheme() {
    return _authLocalRepository.removeThemeData();
  }

  Future<Color?> getThemeColor() async {
    return await _authLocalRepository.getThemeColor();
  }
}
