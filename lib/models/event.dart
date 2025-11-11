class Event {
  final String id;
  final String userId;
  final String name;
  final String? note;
  final List<String> checklistItemIds; // List of ChecklistItem IDs

  Event({
    required this.id,
    required this.userId,
    required this.name,
    this.note,
    this.checklistItemIds = const [],
  });

  // Factory constructor to create an Event from a Firestore document
  factory Event.fromFirestore(Map<String, dynamic> data, String id) {
    return Event(
      id: id,
      userId: data['userId'] as String,
      name: data['name'] as String,
      note: data['note'] as String?,
      checklistItemIds: List<String>.from(data['checklistItemIds'] ?? []),
    );
  }

  // Method to convert Event object to a map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'name': name,
      'note': note,
      'checklistItemIds': checklistItemIds,
    };
  }

  // For validation (can be expanded with more complex logic)
  bool isValid() {
    return name.isNotEmpty;
  }
  // Method to create a copy of the Event with updated fields
  Event copyWith({
    String? id,
    String? userId,
    String? name,
    String? note,
    List<String>? checklistItemIds,
  }) {
    return Event(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      name: name ?? this.name,
      note: note ?? this.note,
      checklistItemIds: checklistItemIds ?? this.checklistItemIds,
    );
  }
}