import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:vpn_apk/core/models/user_model.dart';

part "user_model_notifier.g.dart";

@Riverpod(keepAlive: true)
class UserModelNotifier extends _$UserModelNotifier {
  @override
  UserModel? build() {
    return null;
  }

  void addUser(UserModel userModel) {
    state = userModel;
  }
  
  UserModel? getUser() {
    return state;
  }
}
