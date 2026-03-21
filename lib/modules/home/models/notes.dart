class Notes {
  final String id;
  final String title;
  final String content;
  final DateTime createdAt;
  final DateTime updatedAt;

  Notes({
    required this.id,
    required this.title,
    required this.content,
    required this.createdAt,
    required this.updatedAt,
  });
  String getId() {
    return id;
  }

  String getTitle() {
    return title;
  }

  String getContent() {
    return content;
  }

  DateTime getCreatedAt() {
    return createdAt;
  }

  DateTime getUpdatedAt() {
    return updatedAt;
  }
}
