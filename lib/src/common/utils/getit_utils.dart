import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import '../../modules/app/app_router.dart';
import 'getit_utils.config.dart';

final getIt = GetIt.instance;

@injectableInit
void configureDependencies() {
  getIt.init();
  if (!getIt.isRegistered<AppRouter>()) {
    getIt.registerSingleton<AppRouter>(AppRouter());
  }
}

class GetItUtils {
  static setup() async => configureDependencies();
}
