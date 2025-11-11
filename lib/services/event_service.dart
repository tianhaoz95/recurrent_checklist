import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:recurrent_checklist/models/event.dart';

class EventService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String? get currentUserId => _auth.currentUser?.uid;

  // Create Event
  Future<void> createEvent({
    required String name,
    String? note,
  }) async {
    if (currentUserId == null) {
      throw Exception('User not logged in.');
    }
    await _firestore.collection('events').add({
      'userId': currentUserId,
      'name': name,
      'note': note,
      'createdAt': Timestamp.now(),
      'updatedAt': Timestamp.now(),
    });
  }

  // Read Events
  Stream<List<Event>> getEvents() {
    if (currentUserId == null) {
      return Stream.value([]);
    }
    return _firestore
        .collection('events')
        .where('userId', isEqualTo: currentUserId)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return Event.fromFirestore(doc as DocumentSnapshot<Map<String, dynamic>>, null);
      }).toList();
    });
  }

  // Update Event
  Future<void> updateEvent({
    required String eventId,
    String? name,
    String? note,
  }) async {
    if (currentUserId == null) {
      throw Exception('User not logged in.');
    }
    Map<String, dynamic> updateData = {
      'updatedAt': Timestamp.now(),
    };
    if (name != null) {
      updateData['name'] = name;
    }
    if (note != null) {
      updateData['note'] = note;
    }
    await _firestore.collection('events').doc(eventId).update(updateData);
  }

  // Delete Event
  Future<void> deleteEvent(String eventId) async {
    if (currentUserId == null) {
      throw Exception('User not logged in.');
    }
    await _firestore.collection('events').doc(eventId).delete();
  }
}