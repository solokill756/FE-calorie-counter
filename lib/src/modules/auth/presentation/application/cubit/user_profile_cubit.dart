import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/data/local/storage.dart';
import '../../../data/models/local_user_identity.dart';
import '../../../data/models/user_profile_model.dart';
import '../../../domain/repository/auth_repository.dart';
import 'user_profile_state.dart';

@lazySingleton
class UserProfileCubit extends Cubit<UserProfileState> {
  UserProfileCubit(this._authRepository) : super(const UserProfileState.initial());

  final AuthRepository _authRepository;

  UserProfileModel? get profileOrNull => state.maybeWhen(
        loaded: (profile) => profile,
        loading: (previous) => previous,
        error: (_, previous) => previous,
        orElse: () => null,
      );

  Future<void> refresh({bool showLoading = false}) async {
    final previous = profileOrNull;
    if (showLoading) {
      emit(UserProfileState.loading(previous: previous));
    }

    final result = await _authRepository.getUserProfile();
    result.fold(
      (profile) async {
        await _persistIdentityFromProfile(profile);
        emit(UserProfileState.loaded(profile));
      },
      (error) {
        emit(
          UserProfileState.error(
            message: error.message.isNotEmpty
                ? error.message
                : 'Profile load failed',
            previous: previous,
          ),
        );
      },
    );
  }

  Future<void> _persistIdentityFromProfile(UserProfileModel profile) async {
    await Storage.setUserIdentity(
      LocalUserIdentity(
        email: profile.email,
        displayName: profile.displayName,
        avatarUrl: profile.avatarUrl,
        isProfileComplete: profile.isProfileComplete,
      ),
    );
    await Storage.setIsProfileComplete(profile.isProfileComplete);
  }

  void clear() => emit(const UserProfileState.initial());
}
