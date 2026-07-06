import '../models/progress_trends_models.dart';

abstract class ProgressTrendsRepository {
  Future<ProgressTrendsResponse> fetchTrends({
    required String from,
    required String to,
  });
}
