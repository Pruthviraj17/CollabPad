import 'dart:convert';
import 'dart:ui';
import 'package:collabpad/core/models/user_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  bool setThemeColor(Color color) {
    _sharedPreferences.setString("theme_color", colorToHex(color));
    return true;
  }

  bool removeThemeData() {
    _sharedPreferences.remove("theme_color");
    return true;
  }

  Future<Color?> getThemeColor() async{
      final prefs = await SharedPreferences.getInstance();
    String? hexCode = prefs.getString("theme_color");
    if (hexCode != null) {
      return hexToColor(hexCode);
    }
    return null;
  }

  String colorToHex(Color color) {
    return '#${color.value.toRadixString(16).padLeft(8, '0').toUpperCase()}';
  }

  Color hexToColor(String hexCode) {
    hexCode = hexCode.replaceAll('#', '');
    if (hexCode.length == 6) {
      hexCode = 'FF$hexCode';
    }
    return Color(int.parse(hexCode, radix: 16));
  }
}
