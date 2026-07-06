import 'package:flutter/foundation.dart';

class FridgePlanGenerationNotifier extends ChangeNotifier {
  FridgePlanGenerationNotifier._();
  static final FridgePlanGenerationNotifier instance =
      FridgePlanGenerationNotifier._();

  bool _inProgress = false;
  bool get inProgress => _inProgress;

  void setInProgress(bool value) {
    if (_inProgress == value) return;
    _inProgress = value;
    notifyListeners();
  }
}
