import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:stirred_app/presentation/providers/current_data.dart';
import 'package:stirred_app/presentation/router.dart';
import 'package:stirred_common_domain/stirred_common_domain.dart';

part 'login_notifier.g.dart';

@riverpod
class LoginNotifier extends _$LoginNotifier {
  @override
  Future<void> build() async {
    return;
  }

  Future<Result<void, StirError>> login({
    required String username,
    required String password,
  }) async {
    final authRepository = ref.read(authRepositoryProvider);

    final result = await authRepository.login(
      {
        'username': username,
        'password': password,
      },
    );

    return result.when(
      success: (response) async {
        await Future.wait([
          authRepository.saveAccessToken(response.access),
          authRepository.saveRefreshToken(response.refresh),
        ]);

        final user = await ref.read(profileRepositoryProvider).getSelfProfile();
        logger.d(user);

        return user.when(
          success: (user) {
            ref.read(currentDataNotifierProvider.notifier).setAuthentifiedUser(user: user);
            router.go(HomeRoute.route(HomeTabConstants.defaultTabIndex));
            return const Result.success(null);
          },
          failure: (error) {
            return Result.failure(error);
          },
        );
      },
      failure: (error) {
        return Result.failure(error);
      },
    );
  }
}