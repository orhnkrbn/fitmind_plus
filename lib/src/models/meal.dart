class MealItem {
  final String name;
  final int calories;
  final int protein;
  MealItem({required this.name, required this.calories, required this.protein});

  Map<String, dynamic> toJson() => {'name': name, 'calories': calories, 'protein': protein};
  factory MealItem.fromJson(Map<String, dynamic> json) =>
      MealItem(name: json['name'], calories: json['calories'], protein: json['protein']);
}