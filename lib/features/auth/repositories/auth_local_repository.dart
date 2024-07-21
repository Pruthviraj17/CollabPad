import 'dart:convert';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vpn_apk/core/models/user_model.dart';

part 'auth_local_repository.g.dart';

@Riverpod(keepAlive: true)
AuthLocalRepository authLocalRepository(AuthLocalRepositoryRef ref) {
  return AuthLocalRepository();
}

class AuthLocalRepository {
  late SharedPreferences _sharedPreferences;

  Future<void> init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  bool setUser({UserModel? userInfo}) {
    if (userInfo != null) {
      final userInfoJson = jsonEncode(userInfo.toJson());
      _sharedPreferences.setString("user_info", userInfoJson);
      return true;
    }
    return false;
  }

  Future<UserModel?> getUserInfo() async {
    final prefs = await SharedPreferences.getInstance();
    final userInfoJson = prefs.getString('user_info');
    if (userInfoJson == null) {
      return null;
    }
    final userInfoMap = jsonDecode(userInfoJson);
    return UserModel.fromJson(userInfoMap);
  }
}
