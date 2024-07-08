import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:vpn_apk/features/auth/repositories/auth_local_repository.dart';
import 'package:vpn_apk/features/auth/repositories/auth_remote_repository.dart';

part 'auth_viewmodel.g.dart';

@riverpod
class AuthViewmodel extends _$AuthViewmodel {
  late AuthRemoteRepository _authRemoteRepository;
  late AuthLocalRepository _authLocalRepository;
  @override
  AsyncValue<String>? build() {
    _authRemoteRepository = ref.watch(authRemoteRepositoryProvider);
    _authLocalRepository = ref.watch(authLocalRepositoryProvider);
    return null;
  }

  Future<void> init() async {
    _authLocalRepository.init();
  }

  Future<void> registerUser({
    required String name,
    required String email,
    required String password,
  }) async {
    state = const AsyncValue.loading();
    final res = await _authRemoteRepository.registerUser(
      name: name,
      email: email,
      password: password,
    );

    final val = switch (res) {
      Left(value: final l) => state =
          AsyncValue.error(l.message, StackTrace.current),
      Right(value: final r) => state = AsyncValue.data(r),
    };
  }

  Future<void> loginUser({
    required String email,
    required String password,
  }) async {
    state = const AsyncValue.loading();
    final res = await _authRemoteRepository.loginUser(
      email: email,
      password: password,
    );

    final val = switch (res) {
      Left(value: final l) => state =
          AsyncValue.error(l.message, StackTrace.current),
      Right(value: final r) => state = AsyncValue.data(r),
    };
  }

  void _authSuccess({required String token, required dynamic data}) {
    _authLocalRepository.setToken(token: token);
    state = AsyncValue.data(data);
  }

  Future<void> getData() async {
    // String? token = _authLocalRepository.getToken();

    // if (token != null) {}
  }
}
