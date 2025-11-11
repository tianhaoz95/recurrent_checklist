import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String id;
  final String email;
  final String? displayName;
  final Timestamp createdAt;
  final Timestamp updatedAt;

  User({
    required this.id,
    required this.email,
    this.displayName,
    required this.createdAt,
    required this.updatedAt,
  });

  // Factory constructor for creating a new User instance from a Firestore document
  factory User.fromFirestore(DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options) {
    final data = snapshot.data();
    return User(
      id: snapshot.id,
      email: data?['email'],
      displayName: data?['displayName'],
      createdAt: data?['createdAt'],
      updatedAt: data?['updatedAt'],
    );
  }

  // Method for converting a User instance to a Firestore document
  Map<String, dynamic> toFirestore() {
    return {
      'email': email,
      'displayName': displayName,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}