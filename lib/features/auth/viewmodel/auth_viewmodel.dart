import 'package:collabpad/core/models/user_model.dart';
import 'package:collabpad/features/auth/repositories/auth_local_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_viewmodel.g.dart';

@riverpod
class AuthViewmodel extends _$AuthViewmodel {
  late AuthLocalRepository _authLocalRepository;
  @override
  AsyncValue<String>? build() {
    _authLocalRepository = ref.watch(authLocalRepositoryProvider);
    return null;
  }

  Future<void> init() async {
    _authLocalRepository.init();
  }

  bool setUser({UserModel? userInfo}) {
    return _authLocalRepository.setUser(userInfo: userInfo);
  }

  Future<UserModel?> getUser() async {
    return await _authLocalRepository.getUserInfo();
  }
}
