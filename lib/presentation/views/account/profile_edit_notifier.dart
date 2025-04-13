import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:stirred_app/presentation/providers/current_data.dart';
import 'package:stirred_common_domain/stirred_common_domain.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart' show kIsWeb;

part 'profile_edit_notifier.g.dart';

@riverpod
class ProfileEditNotifier extends _$ProfileEditNotifier {
  @override
  Future<Profile?> build() async {
    final user = ref.read(currentDataNotifierProvider).value?.when(
          authentified: (user) => user,
          unauthentified: (_) => null,
        );
    return user;
  }

  Future<void> updateName(String newName) async {
    if (newName.isEmpty) {
      throw Exception('Name cannot be empty');
    }

    final currentUser = state.value;
    if (currentUser == null) {
      throw Exception('No user data available');
    }

    try {
      final response = await ref.read(profileRepositoryProvider).updateProfile(id: currentUser.id, name: newName);
      response.when(
        success: (success) {
          ref.read(currentDataNotifierProvider.notifier).setUser(user: currentUser.copyWith(name: newName));
          state = AsyncValue.data(currentUser.copyWith(name: newName));
        },
        failure: (failure) {
          state = AsyncValue.error(failure, StackTrace.current);
        },
      );
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
      rethrow;
    }
  }

  Future<void> updateEmail(String newEmail) async {
    if (newEmail.isEmpty) {
      throw Exception('Email cannot be empty');
    }
    if (!newEmail.contains('@')) {
      throw Exception('Please enter a valid email');
    }

    final currentUser = state.value;
    if (currentUser == null) {
      throw Exception('No user data available');
    }

    try {
      final response = await ref.read(profileRepositoryProvider).updateProfile(id: currentUser.id, email: newEmail);
      response.when(
        success: (success) {
          ref.read(currentDataNotifierProvider.notifier).setUser(user: currentUser.copyWith(email: newEmail));
          state = AsyncValue.data(currentUser.copyWith(email: newEmail));
        },
        failure: (failure) {
          state = AsyncValue.error(failure, StackTrace.current);
        },
      );
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
      rethrow;
    }
  }

  Future<void> updateProfilePicture(String imagePath) async {
    final currentUser = state.value;
    if (currentUser == null) {
      throw Exception('No user data available');
    }

    try {
      http.MultipartFile file;
      if (kIsWeb) {
        // For web platform
        final bytes = await http.get(Uri.parse(imagePath));
        file = http.MultipartFile.fromBytes(
          'picture',
          bytes.bodyBytes,
          filename: 'profile_picture.jpg',
        );
      } else {
        // For mobile platforms
        file = await http.MultipartFile.fromPath('picture', imagePath);
      }

      final response = await ref.read(profileRepositoryProvider).updateProfile(
        id: currentUser.id,
        picture: file,
      );

      response.when(
        success: (success) {
          ref.read(currentDataNotifierProvider.notifier).setUser(
            user: success.profile,
          );
          state = AsyncValue.data(success.profile);
        },
        failure: (failure) {
          state = AsyncValue.error(failure, StackTrace.current);
        },
      );
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
      rethrow;
    }
  }
}
