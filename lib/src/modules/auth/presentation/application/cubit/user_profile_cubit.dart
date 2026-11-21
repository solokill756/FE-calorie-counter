import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/data/local/storage.dart';
import '../../../../../core/data/remote/base/api_error.dart';
import '../../../data/models/local_user_identity.dart';
import '../../../data/models/user_profile_model.dart';
import '../../../domain/repository/auth_repository.dart';
import 'user_profile_state.dart';

@lazySingleton
class UserProfileCubit extends Cubit<UserProfileState> {
  UserProfileCubit(this._authRepository)
    : super(const UserProfileState.initial());

  final AuthRepository _authRepository;
  int _profileRevision = 0;
  int _sessionRevision = 0;

  UserProfileModel? get profileOrNull => state.maybeWhen(
    loaded: (profile) => profile,
    loading: (previous) => previous,
    error: (_, previous) => previous,
    orElse: () => null,
  );

  Future<void> refresh({bool showLoading = false}) async {
    final revision = ++_profileRevision;
    final previous = profileOrNull;
    if (showLoading) {
      emit(UserProfileState.loading(previous: previous));
    }

    final result = await _authRepository.getUserProfile();
    if (isClosed || revision != _profileRevision) return;
    await result.fold<Future<void>>(
      (profile) async {
        await _persistIdentityFromProfile(profile);
        if (!isClosed && revision == _profileRevision) {
          emit(UserProfileState.loaded(profile));
        }
      },
      (error) async {
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

  Future<ApiError?> saveHealthProfile(Map<String, Object?> changes) async {
    final session = _sessionRevision;
    final result = await _authRepository.patchHealthProfile(changes);
    return result.fold((profile) {
      if (!isClosed && session == _sessionRevision) {
        _profileRevision++;
        emit(UserProfileState.loaded(profile));
      }
      return null;
    }, (error) => error);
  }

  void clear() {
    _sessionRevision++;
    _profileRevision++;
    emit(const UserProfileState.initial());
  }
}
