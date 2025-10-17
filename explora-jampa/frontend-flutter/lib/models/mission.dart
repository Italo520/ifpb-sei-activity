class Mission {
  final int id;
  final String name;
  final String description;
  final int points;

  Mission({required this.id, required this.name, required this.description, required this.points});

  factory Mission.fromJson(Map<String, dynamic> json) {
    return Mission(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      points: json['points'],
    );
  }
}
