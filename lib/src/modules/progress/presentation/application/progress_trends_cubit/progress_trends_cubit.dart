import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../logfood/helper/log_food_helper.dart';
import '../../../domain/models/progress_trends_models.dart';
import '../../../domain/repository/progress_trends_repository.dart';

part 'progress_trends_cubit.freezed.dart';
part 'progress_trends_state.dart';

@singleton
class ProgressTrendsCubit extends Cubit<ProgressTrendsState> {
  ProgressTrendsCubit(this._repository)
    : super(const ProgressTrendsState.initial());

  final ProgressTrendsRepository _repository;

  Future<void> loadRange({required String from, required String to}) async {
    emit(const ProgressTrendsState.loading());
    try {
      final data = await _repository.fetchTrends(from: from, to: to);
      emit(ProgressTrendsState.loaded(data));
    } catch (e) {
      emit(ProgressTrendsState.error(e.toString()));
    }
  }

  /// Last [days] calendar days (date keys via [LogFoodHelper]) ending today.
  Future<void> loadTrailingDays({int days = 30}) async {
    final helper = LogFoodHelper();
    final today = DateTime.now();
    final toKey = helper.dateKeyFrom(today);
    final fromDay = today.subtract(Duration(days: days - 1));
    final fromKey = helper.dateKeyFrom(fromDay);
    await loadRange(from: fromKey, to: toKey);
  }
}
