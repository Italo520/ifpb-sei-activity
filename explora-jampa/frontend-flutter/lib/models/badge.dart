class Badge {
  final int id;
  final String name;
  final String description;
  final String iconUrl;

  Badge({required this.id, required this.name, required this.description, required this.iconUrl});

  factory Badge.fromJson(Map<String, dynamic> json) {
    return Badge(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      iconUrl: json['iconUrl'],
    );
  }
}
