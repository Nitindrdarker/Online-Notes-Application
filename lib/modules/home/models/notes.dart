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

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'content': content,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  factory Notes.fromJson(Map<String, dynamic> json) {
    return Notes(
      id: json['id'].toString(),
      title: json['title'],
      content: json['content'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
  Notes copyWith({
    String? id,
    String? title,
    String? content,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Notes(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class NotesResponse {
  final List<Notes> notes;

  NotesResponse({required this.notes});

  factory NotesResponse.fromJson(Map<String, dynamic> json) {
    return NotesResponse(
      notes: (json['notes'] as List).map((e) => Notes.fromJson(e)).toList(),
    );
  }
}
