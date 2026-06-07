import 'package:caloriecounter/src/core/notifications/push_notification_route_mapper.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('maps reminder payloads to route keys', () {
    expect(PushNotificationRouteMapper.routeKeyFor(const {'type': 'water'}), PushNotificationRouteKey.water);
    expect(PushNotificationRouteMapper.routeKeyFor(const {'type': 'meal_log'}), PushNotificationRouteKey.mealLog);
    expect(PushNotificationRouteMapper.routeKeyFor(const {'type': 'weight'}), PushNotificationRouteKey.weight);
    expect(PushNotificationRouteMapper.routeKeyFor(const {'type': 'exercise'}), PushNotificationRouteKey.exercise);
    expect(PushNotificationRouteMapper.routeKeyFor(const {'type': 'system'}), PushNotificationRouteKey.dashboard);
  });
}
