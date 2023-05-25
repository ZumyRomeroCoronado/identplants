class Result {
  String label;
  double confidence;

  Result({
    required this.label,
    required this.confidence,
  });

  factory Result.fromMap(Map data) {
    return Result(
      label: data['label'],
      confidence: data['confidence'],
    );
  }
}
