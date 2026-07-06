import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../data/models/user_profile_model.dart';

part 'user_profile_state.freezed.dart';

@freezed
class UserProfileState with _$UserProfileState {
  const factory UserProfileState.initial() = _Initial;

  const factory UserProfileState.loading({UserProfileModel? previous}) = _Loading;

  const factory UserProfileState.loaded(UserProfileModel profile) = _Loaded;

  const factory UserProfileState.error({
    required String message,
    UserProfileModel? previous,
  }) = _Error;
}
