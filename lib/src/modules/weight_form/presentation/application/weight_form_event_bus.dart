import 'dart:async';

import 'package:injectable/injectable.dart';

import 'weight_saved_refresh.dart';

@injectable
class WeightFormEventBus {
  void notifyWeightSaved() {
    unawaited(refreshWeightDependentData());
  }
}
