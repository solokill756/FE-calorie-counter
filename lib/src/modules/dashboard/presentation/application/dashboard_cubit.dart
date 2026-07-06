import 'dart:async';
import 'dart:developer' as developer;

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../data/models/dashboard_today_response.dart';
import '../../domain/repository/dashboard_repository.dart';
import 'package:caloriecounter/src/modules/water_log/domain/repository/water_log_repository.dart';

sealed class DashboardViewState {}

class DashboardViewInitial extends DashboardViewState {}

class DashboardViewLoading extends DashboardViewState {}

class DashboardViewLoaded extends DashboardViewState {
  DashboardViewLoaded(this.data, {this.isSuggestionLoading = false});

  final DashboardTodayResponse data;
  final bool isSuggestionLoading;

  DashboardViewLoaded copyWith({
    DashboardTodayResponse? data,
    bool? isSuggestionLoading,
  }) {
    return DashboardViewLoaded(
      data ?? this.data,
      isSuggestionLoading: isSuggestionLoading ?? this.isSuggestionLoading,
    );
  }
}

class DashboardViewError extends DashboardViewState {
  DashboardViewError(this.message);

  final String message;
}

@lazySingleton
class DashboardCubit extends Cubit<DashboardViewState> {
  DashboardCubit(this._repository, this._waterLogRepository)
    : super(DashboardViewInitial());

  final DashboardRepository _repository;
  final WaterLogRepository _waterLogRepository;
  int _suggestionRequestId = 0;

  Future<void> loadTodayDashboard() async {
    emit(DashboardViewLoading());
    try {
      final data = await _repository.getTodayDashboard();
      final suggestionRequestId = ++_suggestionRequestId;
      emit(DashboardViewLoaded(data, isSuggestionLoading: true));
      unawaited(_loadSuggestionFor(data, suggestionRequestId));
    } catch (e) {
      emit(DashboardViewError(e.toString()));
    }
  }

  Future<void> refreshDashboard() async {
    final prev = state;
    try {
      final data = await _repository.getTodayDashboard();
      final suggestionRequestId = ++_suggestionRequestId;

      if (prev is DashboardViewLoaded) {
        emit(prev.copyWith(data: data, isSuggestionLoading: true));
      } else {
        emit(DashboardViewLoaded(data, isSuggestionLoading: true));
      }
      unawaited(_loadSuggestionFor(data, suggestionRequestId));
    } catch (e) {
      if (prev is DashboardViewLoaded) {
        emit(prev);
      } else {
        emit(DashboardViewError(e.toString()));
      }
    }
  }

  Future<void> _loadSuggestionFor(
    DashboardTodayResponse data,
    int requestId,
  ) async {
    try {
      final suggestion = await _repository.getTodaySuggestion();
      if (isClosed || requestId != _suggestionRequestId) return;
      emit(DashboardViewLoaded(data.copyWith(aiSuggestion: suggestion)));
    } catch (e) {
      if (isClosed || requestId != _suggestionRequestId) return;
      developer.log('[DashboardCubit] Suggestion API failed: $e', name: 'dashboard');
      emit(DashboardViewLoaded(data));
    }
  }

  Future<void> addWater(int ml) async {
    final currentState = state;
    if (currentState is! DashboardViewLoaded) return;
    try {
      await _waterLogRepository.addMl(ml);
      await refreshDashboard();
    } catch (e) {
      emit(currentState);
      rethrow;
    }
  }
}
