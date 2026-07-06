import 'package:auto_route/auto_route.dart';

import '../../core/data/local/storage.dart';
import '../../modules/app/app_router.dart';

class AuthGuard extends AutoRouteGuard {
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) async {
    final isLoggedIn = Storage.userID;
    final String? token = await Storage.accessToken;
    final checkFinishedUserProfile = Storage.isProfileComplete ?? false;
    if (isLoggedIn != null && token != null && checkFinishedUserProfile) {
      resolver.next(true);
    } else if (isLoggedIn != null &&
        token != null &&
        !checkFinishedUserProfile) {
      router.push(const SignUpFlowRoute());
    } else {
      router.pushAndPopUntil(const WelcomeRoute(), predicate: (route) => false);
    }
  }
}
