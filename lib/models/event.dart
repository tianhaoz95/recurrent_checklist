import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:recurrent_checklist/models/checklist_item.dart';

class Event {
  String id;
  String name;
  String note;
  List<ChecklistItem> checklistItems;
  String userId;
  bool isRecurring; // New field
  int repeatInterval; // New field (e.g., 3 for every 3 days)
  String repeatFrequency; // New field (e.g., 'days', 'weeks', 'months')
  String scheduledTime; // New field (e.g., "04:00")
  DateTime? lastRunDate; // New field
  DateTime? nextRunDate; // New field

  Event({
    required this.id,
    required this.name,
    this.note = '',
    required this.checklistItems,
    required this.userId,
    this.isRecurring = false, // Default to false
    this.repeatInterval = 0, // Default to 0
    this.repeatFrequency = '', // Default to empty
    this.scheduledTime = '', // Default to empty
    this.lastRunDate,
    this.nextRunDate,
  });

  // Convert an Event object into a Map object
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'note': note,
      'checklistItems': checklistItems.map((item) => item.toMap()).toList(),
      'userId': userId,
      'isRecurring': isRecurring,
      'repeatInterval': repeatInterval,
      'repeatFrequency': repeatFrequency,
      'scheduledTime': scheduledTime,
      'lastRunDate': lastRunDate?.toIso8601String(),
      'nextRunDate': nextRunDate?.toIso8601String(),
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
      isRecurring: map['isRecurring'] ?? false,
      repeatInterval: map['repeatInterval'] ?? 0,
      repeatFrequency: map['repeatFrequency'] ?? '',
      scheduledTime: map['scheduledTime'] ?? '',
      lastRunDate: map['lastRunDate'] != null
          ? DateTime.parse(map['lastRunDate'])
          : null,
      nextRunDate: map['nextRunDate'] != null
          ? DateTime.parse(map['nextRunDate'])
          : null,
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
      isRecurring: data['isRecurring'] ?? false,
      repeatInterval: data['repeatInterval'] ?? 0,
      repeatFrequency: data['repeatFrequency'] ?? '',
      scheduledTime: data['scheduledTime'] ?? '',
      lastRunDate: data['lastRunDate'] != null
          ? DateTime.parse(data['lastRunDate'])
          : null,
      nextRunDate: data['nextRunDate'] != null
          ? DateTime.parse(data['nextRunDate'])
          : null,
    );
  }

  // For creating a copy with optional new values
  Event copyWith({
    String? id,
    String? name,
    String? note,
    List<ChecklistItem>? checklistItems,
    String? userId,
    bool? isRecurring,
    int? repeatInterval,
    String? repeatFrequency,
    String? scheduledTime,
    DateTime? lastRunDate,
    DateTime? nextRunDate,
  }) {
    return Event(
      id: id ?? this.id,
      name: name ?? this.name,
      note: note ?? this.note,
      checklistItems: checklistItems ?? this.checklistItems,
      userId: userId ?? this.userId,
      isRecurring: isRecurring ?? this.isRecurring,
      repeatInterval: repeatInterval ?? this.repeatInterval,
      repeatFrequency: repeatFrequency ?? this.repeatFrequency,
      scheduledTime: scheduledTime ?? this.scheduledTime,
      lastRunDate: lastRunDate ?? this.lastRunDate,
      nextRunDate: nextRunDate ?? this.nextRunDate,
    );
  }
}