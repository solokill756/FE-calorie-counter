import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'add_cubit.freezed.dart';
part 'add_state.dart';

@singleton
class AddCubit extends Cubit<AddState> {
  AddCubit() : super(const AddState());

  void logFood() {
    // Navigation logic for logging food
    emit(state.copyWith(selectedAction: AddAction.logFood));
  }

  void barcodeScan() {
    // Navigation logic for barcode scan
    emit(state.copyWith(selectedAction: AddAction.barcodeScan));
  }

  void voiceLog() {
    // Navigation logic for voice log
    emit(state.copyWith(selectedAction: AddAction.voiceLog));
  }

  void mealScan() {
    // Navigation logic for meal scan
    emit(state.copyWith(selectedAction: AddAction.mealScan));
  }

  void addWater() {
    // Navigation logic for adding water
    emit(state.copyWith(selectedAction: AddAction.water));
  }

  void addWeight() {
    // Navigation logic for adding weight
    emit(state.copyWith(selectedAction: AddAction.weight));
  }

  void addExercise() {
    // Navigation logic for adding exercise
    emit(state.copyWith(selectedAction: AddAction.exercise));
  }

  void aiSuggestRecipe() {
    emit(state.copyWith(selectedAction: AddAction.aiSuggestRecipe));
  }

  void aiPhotoRecipe() {
    emit(state.copyWith(selectedAction: AddAction.aiPhotoRecipe));
  }
}
