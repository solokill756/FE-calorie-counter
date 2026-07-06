part of 'edit_profile_cubit.dart';

@freezed
class EditProfileState with _$EditProfileState {
  const factory EditProfileState.idle() = _Idle;
  const factory EditProfileState.saving() = _Saving;
  const factory EditProfileState.success(String message) = _Success;
  const factory EditProfileState.failure(String message) = _Failure;
}
