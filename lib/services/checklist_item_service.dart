import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:recurrent_checklist/models/checklist_item.dart';

class ChecklistItemService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String? get currentUserId => _auth.currentUser?.uid;

  // Create Checklist Item
  Future<void> createChecklistItem({
    required String content,
    String? eventId,
  }) async {
    if (currentUserId == null) {
      throw Exception('User not logged in.');
    }
    await _firestore.collection('checklistItems').add({
      'userId': currentUserId,
      'eventId': eventId,
      'content': content,
      'isChecked': false,
      'createdAt': Timestamp.now(),
      'updatedAt': Timestamp.now(),
    });
  }

  // Read Checklist Items
  Stream<List<ChecklistItem>> getChecklistItems({String? eventId}) {
    if (currentUserId == null) {
      return Stream.value([]);
    }
    Query query = _firestore.collection('checklistItems').where('userId', isEqualTo: currentUserId);
    if (eventId != null) {
      query = query.where('eventId', isEqualTo: eventId);
    } else {
      query = query.where('eventId', isNull: true); // For standalone items
    }
    return query.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return ChecklistItem.fromFirestore(doc as DocumentSnapshot<Map<String, dynamic>>, null);
      }).toList();
    });
  }

  // Update Checklist Item
  Future<void> updateChecklistItem({
    required String checklistItemId,
    String? content,
    bool? isChecked,
    String? eventId, // Added eventId parameter
  }) async {
    if (currentUserId == null) {
      throw Exception('User not logged in.');
    }
    Map<String, dynamic> updateData = {
      'updatedAt': Timestamp.now(),
    };
    if (content != null) {
      updateData['content'] = content;
    }
    if (isChecked != null) {
      updateData['isChecked'] = isChecked;
    }
    if (eventId != null) { // Update eventId if provided
      updateData['eventId'] = eventId;
    }
    await _firestore.collection('checklistItems').doc(checklistItemId).update(updateData);
  }

  // Delete Checklist Item
  Future<void> deleteChecklistItem(String checklistItemId) async {
    if (currentUserId == null) {
      throw Exception('User not logged in.');
    }
    await _firestore.collection('checklistItems').doc(checklistItemId).delete();
  }

  // Delete All Checked Checklist Items
  Future<void> deleteAllCheckedChecklistItems() async {
    if (currentUserId == null) {
      throw Exception('User not logged in.');
    }
    final QuerySnapshot snapshot = await _firestore
        .collection('checklistItems')
        .where('userId', isEqualTo: currentUserId)
        .where('isChecked', isEqualTo: true)
        .get();

    for (DocumentSnapshot doc in snapshot.docs) {
      await doc.reference.delete();
    }
  }
}