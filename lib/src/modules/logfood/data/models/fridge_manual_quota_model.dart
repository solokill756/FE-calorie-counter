class FridgeGenerationStatus {
  const FridgeGenerationStatus({required this.inProgress});

  final bool inProgress;

  factory FridgeGenerationStatus.fromJson(Map<String, dynamic> json) {
    return FridgeGenerationStatus(
      inProgress: json['inProgress'] == true,
    );
  }
}
