class ChecklistItem {
  String id;
  String content;
  bool isChecked;
  DateTime createdAt; // New field

  ChecklistItem({
    required this.id,
    required this.content,
    this.isChecked = false,
    DateTime? createdAt, // Make it optional for existing items, but default to now
  }) : createdAt = createdAt ?? DateTime.now();

  // Convert a ChecklistItem object into a Map object
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'content': content,
      'isChecked': isChecked,
      'createdAt': createdAt.toIso8601String(), // Store as ISO 8601 string
    };
  }

  // Convert a Map object into a ChecklistItem object
  factory ChecklistItem.fromMap(Map<String, dynamic> map) {
    return ChecklistItem(
      id: map['id'] ?? '',
      content: map['content'] ?? '',
      isChecked: map['isChecked'] ?? false,
      createdAt: map['createdAt'] != null
          ? DateTime.parse(map['createdAt'])
          : DateTime.now(), // Parse from ISO 8601 string, default to now if not present
    );
  }

  // For creating a copy with optional new values
  ChecklistItem copyWith({
    String? id,
    String? content,
    bool? isChecked,
    DateTime? createdAt,
  }) {
    return ChecklistItem(
      id: id ?? this.id,
      content: content ?? this.content,
      isChecked: isChecked ?? this.isChecked,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}