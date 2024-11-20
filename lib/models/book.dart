class Book {
  final int id;
  final String name;
  final String link;
  final String category;

  Book({required this.id, required this.name, required this.link, required this.category});

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      id: json['id'],
      name: json['name'],
      link: json['link'],
      category: json['category'],
    );
  }
}
