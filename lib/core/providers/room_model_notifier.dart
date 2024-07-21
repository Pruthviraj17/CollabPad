import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:vpn_apk/core/models/room_model.dart';

part "room_model_notifier.g.dart";

@Riverpod(keepAlive: true)
class RoomModelNotifier extends _$RoomModelNotifier {
  @override
  RoomModel? build() {
    return null;
  }

  void addRoom(RoomModel roomModel) {
    state = roomModel;
  }

  void addNewUser(ActiveUser activeUser) {
    state = state!.copyWith(
      activeUsers: [...state!.activeUsers!, activeUser],
    );
  }

  void removeActiveUser(String id) {
    state = state!.copyWith(
      activeUsers: state!.activeUsers!.where((user) => user.id != id).toList(),
    );
  }
}
