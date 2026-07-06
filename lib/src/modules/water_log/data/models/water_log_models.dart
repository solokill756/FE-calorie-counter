class WaterTodayDto {
  const WaterTodayDto({
    required this.date,
    required this.amountMl,
    required this.targetMl,
    required this.progressPercent,
  });

  final String date;
  final int amountMl;
  final int targetMl;
  final double progressPercent;

  factory WaterTodayDto.fromJson(Map<String, dynamic> json) {
    return WaterTodayDto(
      date: json['date'] as String? ?? '',
      amountMl: (json['amountMl'] as num?)?.round() ?? 0,
      targetMl: (json['targetMl'] as num?)?.round() ?? 0,
      progressPercent: (json['progressPercent'] as num?)?.toDouble() ?? 0,
    );
  }
}

class AddWaterResultDto {
  const AddWaterResultDto({
    required this.success,
    required this.todayTotalMl,
  });

  final bool success;
  final int todayTotalMl;

  factory AddWaterResultDto.fromJson(Map<String, dynamic> json) {
    return AddWaterResultDto(
      success: json['success'] as bool? ?? false,
      todayTotalMl: (json['todayTotalMl'] as num?)?.round() ?? 0,
    );
  }
}

class WaterHistoryRowDto {
  const WaterHistoryRowDto({
    required this.date,
    required this.amountMl,
  });

  final String date;
  final int amountMl;

  factory WaterHistoryRowDto.fromJson(Map<String, dynamic> json) {
    return WaterHistoryRowDto(
      date: json['date'] as String? ?? '',
      amountMl: (json['amountMl'] as num?)?.round() ?? 0,
    );
  }
}
