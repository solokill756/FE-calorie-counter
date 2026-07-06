import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../data/models/water_log_models.dart';
import '../../domain/repository/water_log_repository.dart';

sealed class WaterLogViewState {}

class WaterLogViewInitial extends WaterLogViewState {}

class WaterLogViewLoading extends WaterLogViewState {}

class WaterLogViewLoaded extends WaterLogViewState {
  WaterLogViewLoaded(this.rows);

  final List<WaterHistoryRowDto> rows;
}

class WaterLogViewError extends WaterLogViewState {
  WaterLogViewError(this.message);

  final String message;
}

class WaterLogViewAdding extends WaterLogViewState {
  WaterLogViewAdding(this.rows);
  final List<WaterHistoryRowDto> rows;
}

@injectable
class WaterLogCubit extends Cubit<WaterLogViewState> {
  WaterLogCubit(this._repo) : super(WaterLogViewInitial());

  final WaterLogRepository _repo;

  Future<void> loadHistory({required String from, required String to}) async {
    emit(WaterLogViewLoading());
    try {
      final rows = await _repo.history(from: from, to: to);
      emit(WaterLogViewLoaded(rows));
    } catch (e) {
      emit(WaterLogViewError(e.toString()));
    }
  }

  /// Last [days] UTC calendar days ending today (inclusive).
  Future<void> loadLastDays(int days) async {
    if (days < 1) return;
    final now = DateTime.now().toUtc();
    final to = DateTime.utc(now.year, now.month, now.day);
    final from = to.subtract(Duration(days: days - 1));
    final fromStr =
        '${from.year.toString().padLeft(4, '0')}-${from.month.toString().padLeft(2, '0')}-${from.day.toString().padLeft(2, '0')}';
    final toStr =
        '${to.year.toString().padLeft(4, '0')}-${to.month.toString().padLeft(2, '0')}-${to.day.toString().padLeft(2, '0')}';
    await loadHistory(from: fromStr, to: toStr);
  }

  Future<void> addMl(int ml) async {
    final currentRows = state is WaterLogViewLoaded
        ? (state as WaterLogViewLoaded).rows
        : <WaterHistoryRowDto>[];
    emit(WaterLogViewAdding(currentRows));
    try {
      await _repo.addMl(ml);
      await loadLastDays(14);
    } catch (e) {
      if (state is WaterLogViewAdding) {
        emit(WaterLogViewLoaded(currentRows));
      }
      rethrow;
    }
  }
}
