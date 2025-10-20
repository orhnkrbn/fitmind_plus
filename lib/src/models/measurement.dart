class Measurement {
  final DateTime date;
  final double weight;
  final double waist;
  final double chest;

  Measurement({required this.date, required this.weight, required this.waist, required this.chest});

  Map<String, dynamic> toJson() => {
    'date': date.toIso8601String(),
    'weight': weight,
    'waist': waist,
    'chest': chest,
  };

  factory Measurement.fromJson(Map<String, dynamic> json) => Measurement(
    date: DateTime.parse(json['date'] as String),
    weight: (json['weight'] as num).toDouble(),
    waist: (json['waist'] as num).toDouble(),
    chest: (json['chest'] as num).toDouble(),
  );
}