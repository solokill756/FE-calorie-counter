enum PushNotificationRouteKey {
  dashboard,
  water,
  mealLog,
  weight,
  exercise,
}

class PushNotificationRouteMapper {
  const PushNotificationRouteMapper._();

  static PushNotificationRouteKey routeKeyFor(Map<String, dynamic> data) {
    switch (data['type']) {
      case 'water':
        return PushNotificationRouteKey.water;
      case 'meal_log':
        return PushNotificationRouteKey.mealLog;
      case 'weight':
        return PushNotificationRouteKey.weight;
      case 'exercise':
        return PushNotificationRouteKey.exercise;
      case 'system':
      default:
        return PushNotificationRouteKey.dashboard;
    }
  }
}
