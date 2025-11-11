import 'package:cloud_firestore/cloud_firestore.dart';

class Event {
  final String id;
  final String userId;
  final String name;
  final String? note;
  final Timestamp createdAt;
  final Timestamp updatedAt;

  Event({
    required this.id,
    required this.userId,
    required this.name,
    this.note,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Event.fromFirestore(DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options) {
    final data = snapshot.data();
    return Event(
      id: snapshot.id,
      userId: data?['userId'],
      name: data?['name'],
      note: data?['note'],
      createdAt: data?['createdAt'],
      updatedAt: data?['updatedAt'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'userId': userId,
      'name': name,
      'note': note,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  Event copyWith({
    String? id,
    String? userId,
    String? name,
    String? note,
    Timestamp? createdAt,
    Timestamp? updatedAt,
  }) {
    return Event(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      name: name ?? this.name,
      note: note ?? this.note,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}