class ChecklistItem {
  String id;
  String content;
  bool isChecked;

  ChecklistItem({
    required this.id,
    required this.content,
    this.isChecked = false,
  });

  // Convert a ChecklistItem object into a Map object
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'content': content,
      'isChecked': isChecked,
    };
  }

  // Convert a Map object into a ChecklistItem object
  factory ChecklistItem.fromMap(Map<String, dynamic> map) {
    return ChecklistItem(
      id: map['id'] ?? '',
      content: map['content'] ?? '',
      isChecked: map['isChecked'] ?? false,
    );
  }

  // For creating a copy with optional new values
  ChecklistItem copyWith({
    String? id,
    String? content,
    bool? isChecked,
  }) {
    return ChecklistItem(
      id: id ?? this.id,
      content: content ?? this.content,
      isChecked: isChecked ?? this.isChecked,
    );
  }
}