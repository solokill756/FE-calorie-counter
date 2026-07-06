part of 'more_cubit.dart';

@freezed
class MoreState with _$MoreState {
  const factory MoreState.initial() = _Initial;
  const factory MoreState.loading() = _Loading;
  const factory MoreState.loaded({
    required String? imageUser,
    required String? nameUser,
    required int steakDays,
    required double weightLost,
  }) = _Loaded;
  const factory MoreState.error(String message) = _Error;
  const factory MoreState.logOutLoading() = _LogOutLoading;
  const factory MoreState.logOutSuccess() = _LogOutSuccess;
  const factory MoreState.logOutError(String message) = _LogOutError;
  const factory MoreState.deleteAccountLoading() = _DeleteAccountLoading;
  const factory MoreState.deleteAccountError(String message) =
      _DeleteAccountError;
  const factory MoreState.accountDeletedSuccess() = _AccountDeletedSuccess;
}
