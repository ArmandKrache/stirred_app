import 'dart:async';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:oktoast/oktoast.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:stirred_common_domain/stirred_common_domain.dart';

part 'current_data.freezed.dart';
part 'current_data.g.dart';

/// The AsyncNotifier provider from riverpod to have the current user data.
@riverpod
class CurrentDataNotifier extends _$CurrentDataNotifier {
  /// The subscription to the error events stream.
  StreamSubscription? _errorsSubscription;

  // Initial call to init the current user state at launch.
  @override
  Future<CurrentDataNotifierState> build() async {
    // Indicates that the state should be preserved even if the provider is not
    // listened anymore.
    ref.keepAlive();

    ref.onDispose(_dispose);

    // If the device is registered, we check if the user has an authentification code valid.
    final hasAuthToken = await ref.read(authRepositoryProvider).readAccessToken();

    // If the token isn't valid, then the user needs to log in with credentials.
    if (hasAuthToken == null) {
      return CurrentDataNotifierState.unauthentified();
    }

    final profileRepository = ref.read(profileRepositoryProvider);

    final result = await profileRepository.getSelfProfile();

    return result.when(
      success: (user) async {
        return CurrentDataNotifierState.authentified(
          user: user,
        );
      },
      failure: (_) => CurrentDataNotifierState.unauthentified(),
    );
  }

  void _dispose() {
    _unsubscribeToErrors();
  }

  /// Allows to unsubcribe from the error events stream.
  Future<void> _unsubscribeToErrors() async {
    return _errorsSubscription?.cancel();
  }

  // Function to logout by unsuscribing the device from alert notifications
  // and deleting user's auth token
  Future<void> logout({
    bool automaticLogout = false,
  }) async {

    state = AsyncValue.data(
      CurrentDataNotifierState.unauthentified(),
    );
  }

  Future<void> setAuthentifiedUser({
    required final Profile user,
  }) async {
    state = AsyncValue.data(
      CurrentDataNotifierState.authentified(user: user),
    );
  }
}

/// The state of the current data to check if the user is authenticated.
@freezed
class CurrentDataNotifierState with _$CurrentDataNotifierState {
  factory CurrentDataNotifierState.authentified({
    required final Profile user,
  }) = _Authentified;

  factory CurrentDataNotifierState.unauthentified({
    @Default(false) final bool hasBeenAutomaticallyLoggedOut,
  }) = _Unauthentified;
}
