import 'package:cloud_firestore/cloud_firestore.dart';

class ChecklistItem {
  final String id;
  final String userId;
  final String? eventId;
  final String content;
  final bool isChecked;
  final Timestamp createdAt;
  final Timestamp updatedAt;

  ChecklistItem({
    required this.id,
    required this.userId,
    this.eventId,
    required this.content,
    required this.isChecked,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ChecklistItem.fromFirestore(DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options) {
    final data = snapshot.data();
    return ChecklistItem(
      id: snapshot.id,
      userId: data?['userId'],
      eventId: data?['eventId'],
      content: data?['content'],
      isChecked: data?['isChecked'] ?? false,
      createdAt: data?['createdAt'],
      updatedAt: data?['updatedAt'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'userId': userId,
      'eventId': eventId,
      'content': content,
      'isChecked': isChecked,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  ChecklistItem copyWith({
    String? id,
    String? userId,
    String? eventId,
    String? content,
    bool? isChecked,
    Timestamp? createdAt,
    Timestamp? updatedAt,
  }) {
    return ChecklistItem(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      eventId: eventId ?? this.eventId,
      content: content ?? this.content,
      isChecked: isChecked ?? this.isChecked,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}