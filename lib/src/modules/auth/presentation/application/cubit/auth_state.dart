part of 'auth_cubit.dart';

@freezed
class AuthState with _$AuthState {
  const factory AuthState.initial() = AuthInitial;
  const factory AuthState.error(String message) = AuthError;
  const factory AuthState.authenticated(String message) = AuthAuthenticated;
  const factory AuthState.registered(String message) = AuthRegistered;
  const factory AuthState.loading() = AuthLoading;
  const factory AuthState.saveProfileSuccess(String message) =
      AuthSaveProfileSuccess;
  const factory AuthState.savingProfileLoading() = AuthSavingProfileLoading;
  const factory AuthState.unauthenticated(String message) = AuthUnauthenticated;
}
