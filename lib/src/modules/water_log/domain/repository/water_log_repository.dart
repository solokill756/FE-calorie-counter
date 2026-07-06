import '../../data/models/water_log_models.dart';

abstract class WaterLogRepository {
  Future<WaterTodayDto> getToday();

  Future<AddWaterResultDto> addMl(int amountMl);

  Future<AddWaterResultDto> setTodayTotal(int amountMl);

  Future<List<WaterHistoryRowDto>> history({
    required String from,
    required String to,
  });
}
