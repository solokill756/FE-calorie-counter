import 'package:caloriecounter/src/core/services/firebase_storage_upload_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../data/model/weightForm_model.dart';
import '../../../domain/repository/weightForm_repo.dart';
import '../weight_form_event_bus.dart';

part 'weightForm_state.dart';
part 'weightForm_cubit.freezed.dart';

@singleton
class WeightFormCubit extends Cubit<WeightFormState> {
  final WeightFormRepository weightFormRepository;
  final WeightFormEventBus _eventBus;

  WeightFormCubit({
    required this.weightFormRepository,
    required WeightFormEventBus eventBus,
  }) : _eventBus = eventBus, super(WeightFormState.initial());

  Future<void> saveWeightEntry({
    required double weight,
    required DateTime date,
    String? progressPhotoPath,
  }) async {
    emit(const WeightFormState.savingLoading());

    String? photoUrl;
    if (progressPhotoPath != null) {
      try {
        photoUrl = await FirebaseStorageUploadService.uploadImageFile(
          filePath: progressPhotoPath,
          folder: 'weight',
        );
      } catch (e) {
        emit(
          WeightFormState.saveFailure(
            'Failed to upload image to Firebase: ${e.toString()}',
          ),
        );
        return;
      }
    }

    final result = await weightFormRepository.saveWeightEntry(
      WeightFormModel(
        weightKg: weight,
        recordedAt: date,
        photoUrl: photoUrl,
      ),
    );
    if (result.isError()) {
      final err = result.exceptionOrNull();
      emit(
        WeightFormState.saveFailure(
          'Failed to save weight entry: ${err?.message ?? 'Unknown error'}',
        ),
      );
      return;
    }
    _eventBus.notifyWeightSaved();
    emit(WeightFormState.saveSuccess('Weight entry saved successfully'));
  }

  Future<void> updateWeightEntry({
    required String entryId,
    required double weight,
    required DateTime date,
    String? progressPhotoPath,
  }) async {
    emit(const WeightFormState.savingLoading());

    String? photoUrl;
    if (progressPhotoPath != null) {
      try {
        photoUrl = await FirebaseStorageUploadService.uploadImageFile(
          filePath: progressPhotoPath,
          folder: 'weight',
        );
      } catch (e) {
        emit(
          WeightFormState.saveFailure(
            'Failed to upload image to Firebase: ${e.toString()}',
          ),
        );
        return;
      }
    }

    final result = await weightFormRepository.updateWeightEntry(
      entryId: entryId,
      weightModel: WeightFormModel(
        weightKg: weight,
        recordedAt: date,
        photoUrl: photoUrl,
      ),
    );
    if (result.isError()) {
      final err = result.exceptionOrNull();
      emit(
        WeightFormState.saveFailure(
          'Failed to update weight entry: ${err?.message ?? 'Unknown error'}',
        ),
      );
      return;
    }
    _eventBus.notifyWeightSaved();
    emit(WeightFormState.saveSuccess('Weight entry updated successfully'));
  }

  Future<void> loadWeightEntry({required String entryId}) async {
    emit(const WeightFormState.loading());
    final result = await weightFormRepository.getWeightEntry(entryId: entryId);
    try {
      result.fold(
        (weightEntry) {
          emit(WeightFormState.loaded(weightEntry));
        },
        (error) {
          emit(
            WeightFormState.error(
              'Failed to load weight entry: ${error.message}',
            ),
          );
        },
      );
    } catch (e) {
      emit(WeightFormState.error('Failed to load data: ${e.toString()}'));
    }
  }

  /// Reset form to initial state (for adding new entry)
  void resetForm() {
    emit(const WeightFormState.initial());
  }
}
