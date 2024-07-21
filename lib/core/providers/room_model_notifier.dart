import 'package:collabpad/core/models/room_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

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

  String addNewUser(ActiveUser activeUser) {
    state = state!.copyWith(
      activeUsers: [...state!.activeUsers!, activeUser],
    );
    return activeUser.userModel!.username!;
  }

  String removeActiveUser(String id) {
    String username=id;
    state = state!.copyWith(
      activeUsers: state!.activeUsers!.where((user) {
        if(user.id==id){
          username=user.userModel!.username??id;
        }
        return user.id != id;
      }).toList(),
    );
    return username;
  }
}
