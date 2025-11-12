import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:recurrent_checklist/models/checklist_item.dart';

class Event {
  String id;
  String name;
  String note;
  List<ChecklistItem> checklistItems;
  String userId;

  Event({
    required this.id,
    required this.name,
    this.note = '',
    required this.checklistItems,
    required this.userId,
  });

  // Convert an Event object into a Map object
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'note': note,
      'checklistItems': checklistItems.map((item) => item.toMap()).toList(),
      'userId': userId,
    };
  }

  // Convert a Map object into an Event object
  factory Event.fromMap(Map<String, dynamic> map) {
    return Event(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      note: map['note'] ?? '',
      checklistItems: (map['checklistItems'] as List<dynamic>?)
              ?.map((itemMap) => ChecklistItem.fromMap(itemMap))
              .toList() ??
          [],
      userId: map['userId'] ?? '',
    );
  }

  // Convert a DocumentSnapshot into an Event object
  factory Event.fromDocumentSnapshot(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Event(
      id: doc.id,
      name: data['name'] ?? '',
      note: data['note'] ?? '',
      checklistItems: (data['checklistItems'] as List<dynamic>?)
              ?.map((itemMap) => ChecklistItem.fromMap(itemMap))
              .toList() ??
          [],
      userId: data['userId'] ?? '',
    );
  }

  // For creating a copy with optional new values
  Event copyWith({
    String? id,
    String? name,
    String? note,
    List<ChecklistItem>? checklistItems,
    String? userId,
  }) {
    return Event(
      id: id ?? this.id,
      name: name ?? this.name,
      note: note ?? this.note,
      checklistItems: checklistItems ?? this.checklistItems,
      userId: userId ?? this.userId,
    );
  }
}