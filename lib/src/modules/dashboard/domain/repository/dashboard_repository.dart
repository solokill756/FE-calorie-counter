import '../../data/models/dashboard_today_response.dart';

abstract class DashboardRepository {
  Future<DashboardTodayResponse> getTodayDashboard();
  Future<DashboardAiSuggestion> getTodaySuggestion();
}
