class ChecklistItem {
  final String id;
  final String eventId;
  final String content;
  final bool status;

  ChecklistItem({
    required this.id,
    required this.eventId,
    required this.content,
    this.status = false,
  });

  // Factory constructor to create a ChecklistItem from a Firestore document
  factory ChecklistItem.fromFirestore(Map<String, dynamic> data, String id) {
    return ChecklistItem(
      id: id,
      eventId: data['eventId'] as String,
      content: data['content'] as String,
      status: data['status'] as bool? ?? false, // Default to false if null
    );
  }

  // Method to convert ChecklistItem object to a map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'eventId': eventId,
      'content': content,
      'status': status,
    };
  }

  // For validation (can be expanded with more complex logic)
  bool isValid() {
    return content.isNotEmpty;
  }

  // Method to create a copy of the ChecklistItem with updated status
  ChecklistItem copyWith({
    String? id,
    String? eventId,
    String? content,
    bool? status,
  }) {
    return ChecklistItem(
      id: id ?? this.id,
      eventId: eventId ?? this.eventId,
      content: content ?? this.content,
      status: status ?? this.status,
    );
  }
}