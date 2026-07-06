import 'package:freezed_annotation/freezed_annotation.dart';

part 'weightForm_model.freezed.dart';
part 'weightForm_model.g.dart';

@freezed
class WeightFormModel with _$WeightFormModel {
  const factory WeightFormModel({
    int? id,
    required double weightKg,
    // Use a JsonConverter to serialize DateTime as ISO8601 string
    @DateTimeIso8601Converter() required DateTime recordedAt,
    String? photoUrl,
  }) = _WeightFormModel;

  const WeightFormModel._();

  factory WeightFormModel.fromJson(Map<String, dynamic> json) =>
      _$WeightFormModelFromJson(json);
}

/// Converter that maps DateTime <-> ISO8601 string for json_serializable
class DateTimeIso8601Converter implements JsonConverter<DateTime, String> {
  const DateTimeIso8601Converter();

  @override
  DateTime fromJson(String json) => DateTime.parse(json);

  @override
  String toJson(DateTime object) => object.toUtc().toIso8601String();
}
