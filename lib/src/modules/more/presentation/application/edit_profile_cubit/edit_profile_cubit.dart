import 'package:bloc/bloc.dart';
import 'package:caloriecounter/src/core/data/local/storage.dart';
import 'package:caloriecounter/src/core/data/remote/base/api_error.dart';
import 'package:caloriecounter/src/core/services/firebase_storage_upload_service.dart';
import 'package:caloriecounter/src/modules/auth/data/models/local_user_identity.dart';
import 'package:caloriecounter/src/modules/auth/data/models/user_profile_model.dart';
import 'package:caloriecounter/src/modules/auth/presentation/application/cubit/user_profile_cubit.dart';
import 'package:caloriecounter/src/common/utils/getit_utils.dart';
import 'package:caloriecounter/src/modules/auth/domain/repository/auth_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../more_cubit/more_cubit.dart';

part 'edit_profile_state.dart';
part 'edit_profile_cubit.freezed.dart';

@injectable
class EditProfileCubit extends Cubit<EditProfileState> {
  EditProfileCubit(this._authRepository, this._moreCubit)
    : super(const EditProfileState.idle());

  final AuthRepository _authRepository;
  final MoreCubit _moreCubit;

  Future<void> submit({
    required String displayName,
    required String email,
    String newPassword = '',
    String? localAvatarFilePath,
  }) async {
    emit(const EditProfileState.saving());
    final pass = newPassword.trim();

    String? avatarUrl;
    if (localAvatarFilePath != null && localAvatarFilePath.isNotEmpty) {
      try {
        avatarUrl = await FirebaseStorageUploadService.uploadImageFile(
          filePath: localAvatarFilePath,
          folder: 'avatar-images',
          ownerId: Storage.userID?.toString(),
        );
      } catch (_) {
        emit(const EditProfileState.failure('Failed to upload avatar image'));
        return;
      }
    }

    final patchResult = await _authRepository.patchProfile(
      displayName: displayName.trim(),
      email: email.trim(),
      newPassword: pass.isEmpty ? null : pass,
      avatarUrl: avatarUrl,
    );
    if (patchResult.isError()) {
      emit(
        EditProfileState.failure(_mapApiError(patchResult.exceptionOrNull()!)),
      );
      return;
    }

    final UserProfileModel remote = patchResult.getOrNull()!;

    await Storage.setUserIdentity(
      LocalUserIdentity(
        email: remote.email,
        displayName: remote.displayName,
        avatarUrl: remote.avatarUrl,
        isProfileComplete: remote.isProfileComplete,
      ),
    );
    await getIt<UserProfileCubit>().refresh();
    await _moreCubit.loadMoreData();
    emit(const EditProfileState.success('Profile updated'));
  }

  String _mapApiError(ApiError e) {
    final code = e.statusCode;
    if (code == 409) {
      return 'This email is already in use';
    }
    final msg = e.message;
    if (msg.isNotEmpty) return msg;
    return 'Update failed';
  }
}
