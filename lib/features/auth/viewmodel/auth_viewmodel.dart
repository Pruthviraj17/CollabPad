import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:vpn_apk/features/auth/repositories/auth_local_repository.dart';

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
}
