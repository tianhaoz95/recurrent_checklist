import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:recurrent_checklist/models/checklist_item.dart';
import 'package:recurrent_checklist/models/event.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String? get _userId => _auth.currentUser?.uid;

  // --- Checklist Item Operations ---

  // Get all checklist items for the current user
  Stream<List<ChecklistItem>> getChecklistItems() {
    if (_userId == null) return Stream.value([]);
    return _db
        .collection('users')
        .doc(_userId)
        .collection('checklistItems')
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => ChecklistItem.fromMap(doc.data()))
            .toList());
  }

  // Add a new checklist item
  Future<void> addChecklistItem(ChecklistItem item) async {
    if (_userId == null) return;
    await _db
        .collection('users')
        .doc(_userId)
        .collection('checklistItems')
        .doc(item.id)
        .set(item.toMap());
  }

  // Update an existing checklist item
  Future<void> updateChecklistItem(ChecklistItem item) async {
    if (_userId == null) return;
    await _db
        .collection('users')
        .doc(_userId)
        .collection('checklistItems')
        .doc(item.id)
        .update(item.toMap());
  }

  // Delete a checklist item
  Future<void> deleteChecklistItem(String itemId) async {
    if (_userId == null) return;
    await _db
        .collection('users')
        .doc(_userId)
        .collection('checklistItems')
        .doc(itemId)
        .delete();
  }

  // Delete all checked checklist items
  Future<void> deleteCheckedChecklistItems() async {
    if (_userId == null) return;
    final snapshot = await _db
        .collection('users')
        .doc(_userId)
        .collection('checklistItems')
        .where('isChecked', isEqualTo: true)
        .get();

    for (var doc in snapshot.docs) {
      await doc.reference.delete();
    }
  }

  // --- Event Operations ---

  // Get all events for the current user
  Stream<List<Event>> getEvents() {
    if (_userId == null) return Stream.value([]);
    return _db
        .collection('users')
        .doc(_userId)
        .collection('events')
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Event.fromDocumentSnapshot(doc)).toList());
  }

  // Add a new event
  Future<void> addEvent(Event event) async {
    if (_userId == null) return;
    await _db
        .collection('users')
        .doc(_userId)
        .collection('events')
        .doc(event.id)
        .set(event.toMap());
  }

  // Update an existing event
  Future<void> updateEvent(Event event) async {
    if (_userId == null) return;
    await _db
        .collection('users')
        .doc(_userId)
        .collection('events')
        .doc(event.id)
        .update(event.toMap());
  }

  // Delete an event
  Future<void> deleteEvent(String eventId) async {
    if (_userId == null) return;
    await _db
        .collection('users')
        .doc(_userId)
        .collection('events')
        .doc(eventId)
        .delete();
  }

  // Delete all user data
  Future<void> deleteAllUserData() async {
    if (_userId == null) return;

    // Delete all checklist items
    final checklistItemsSnapshot = await _db
        .collection('users')
        .doc(_userId)
        .collection('checklistItems')
        .get();
    for (var doc in checklistItemsSnapshot.docs) {
      await doc.reference.delete();
    }

    // Delete all events
    final eventsSnapshot = await _db
        .collection('users')
        .doc(_userId)
        .collection('events')
        .get();
    for (var doc in eventsSnapshot.docs) {
      await doc.reference.delete();
    }

    // Optionally, delete the user document itself if it exists
    await _db.collection('users').doc(_userId).delete();
  }
}