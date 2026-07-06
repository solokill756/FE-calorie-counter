import 'package:bloc/bloc.dart';
import 'package:caloriecounter/src/modules/progress/domain/entities/progress_entity.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/repository/progress_repo.dart';

part 'progress_state.dart';
part 'progress_cubit.freezed.dart';

@singleton
class ProgressCubit extends Cubit<ProgressState> {
  final ProgressRepository progressRepository;

  ProgressCubit(this.progressRepository) : super(const ProgressState.initial());

  Future<void> loadProgressData({
    required int page,
    required int pageSize,
    required String type,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    emit(const ProgressState.loading());
    final result = await progressRepository.fetchProcessData(
      page: page,
      pageSize: pageSize,
      type: type,
      startDate: startDate,
      endDate: endDate,
    );
    result.fold(
      (progressStats) {
        emit(ProgressState.loaded(stats: progressStats));
      },
      (error) {
        debugPrint('Error fetching progress data: ${error.message}');
        emit(ProgressState.error('Failed to load progress data'));
      },
    );
  }

  Future<void> addProgressEntry({
    required Map<String, dynamic> data,
    required String type,
  }) async {
    final currentState = state;
    final page = 1;
    final entriesPerPage =
        currentState is _Loaded && currentState.stats.entries.isNotEmpty
        ? currentState.stats.entries.length + 1
        : 10;

    emit(const ProgressState.adding());
    final result = await progressRepository.addProgressEntry(data, type);
    result.fold(
      (_) {
        emit(
          const ProgressState.addedSuccess('Progress entry added successfully'),
        );
        // Reload the progress data after successful addition
        loadProgressData(page: page, pageSize: entriesPerPage, type: type);
      },
      (error) {
        emit(
          ProgressState.addedFailure(
            'Failed to add progress entry: ${error.message}',
          ),
        );
        loadProgressData(page: page, pageSize: entriesPerPage, type: type);
      },
    );
  }
}
