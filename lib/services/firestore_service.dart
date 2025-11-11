import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:recurrent_checklist/models/event.dart';
import 'package:recurrent_checklist/models/checklist_item.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String? get _currentUserId => _auth.currentUser?.uid;

  // --- Event Operations ---

  // Get a stream of events for the current user
  Stream<List<Event>> getEvents() {
    if (_currentUserId == null) {
      return Stream.value([]);
    }
    return _db
        .collection('users')
        .doc(_currentUserId)
        .collection('events')
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => Event.fromFirestore(doc.data(), doc.id))
            .toList());
  }

  // Add a new event
  Future<void> addEvent(Event event) async {
    if (_currentUserId == null) return;
    await _db
        .collection('users')
        .doc(_currentUserId)
        .collection('events')
        .add(event.toMap());
  }

  // Update an existing event
  Future<void> updateEvent(Event event) async {
    if (_currentUserId == null) return;
    await _db
        .collection('users')
        .doc(_currentUserId)
        .collection('events')
        .doc(event.id)
        .update(event.toMap());
  }

  // Delete an event and its associated checklist items
  Future<void> deleteEvent(String eventId) async {
    if (_currentUserId == null) return;

    // Delete associated checklist items
    final checklistItemsSnapshot = await _db
        .collection('users')
        .doc(_currentUserId)
        .collection('checklistItems')
        .where('eventId', isEqualTo: eventId)
        .get();

    for (var doc in checklistItemsSnapshot.docs) {
      await doc.reference.delete();
    }

    // Delete the event itself
    await _db
        .collection('users')
        .doc(_currentUserId)
        .collection('events')
        .doc(eventId)
        .delete();
  }

  // --- ChecklistItem Operations ---

  // Get a stream of all checklist items for the current user (daily pool)
  Stream<List<ChecklistItem>> getChecklistItems() {
    if (_currentUserId == null) {
      return Stream.value([]);
    }
    return _db
        .collection('users')
        .doc(_currentUserId)
        .collection('checklistItems')
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => ChecklistItem.fromFirestore(doc.data(), doc.id))
            .toList());
  }

  // Get a stream of checklist items for a specific event
  Stream<List<ChecklistItem>> getChecklistItemsForEvent(String eventId) {
    if (_currentUserId == null) {
      return Stream.value([]);
    }
    return _db
        .collection('users')
        .doc(_currentUserId)
        .collection('checklistItems')
        .where('eventId', isEqualTo: eventId)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => ChecklistItem.fromFirestore(doc.data(), doc.id))
            .toList());
  }

  // Add a new checklist item
  Future<void> addChecklistItem(ChecklistItem item) async {
    if (_currentUserId == null) return;
    await _db
        .collection('users')
        .doc(_currentUserId)
        .collection('checklistItems')
        .add(item.toMap());
  }

  // Update an existing checklist item (e.g., status)
  Future<void> updateChecklistItem(ChecklistItem item) async {
    if (_currentUserId == null) return;
    await _db
        .collection('users')
        .doc(_currentUserId)
        .collection('checklistItems')
        .doc(item.id)
        .update(item.toMap());
  }

  // Delete a checklist item
  Future<void> deleteChecklistItem(String itemId) async {
    if (_currentUserId == null) return;
    await _db
        .collection('users')
        .doc(_currentUserId)
        .collection('checklistItems')
        .doc(itemId)
        .delete();
  }

  // Delete multiple checklist items (e.g., all checked items)
  Future<void> deleteMultipleChecklistItems(List<String> itemIds) async {
    if (_currentUserId == null) return;
    WriteBatch batch = _db.batch();
    for (String itemId in itemIds) {
      batch.delete(_db
          .collection('users')
          .doc(_currentUserId)
          .collection('checklistItems')
          .doc(itemId));
    }
    await batch.commit();
  }

  // Delete all user data
  Future<void> deleteAllUserData() async {
    if (_currentUserId == null) return;

    // Delete all events
    final eventsSnapshot = await _db
        .collection('users')
        .doc(_currentUserId)
        .collection('events')
        .get();
    for (var doc in eventsSnapshot.docs) {
      await doc.reference.delete();
    }

    // Delete all checklist items
    final checklistItemsSnapshot = await _db
        .collection('users')
        .doc(_currentUserId)
        .collection('checklistItems')
        .get();
    for (var doc in checklistItemsSnapshot.docs) {
      await doc.reference.delete();
    }
  }
}