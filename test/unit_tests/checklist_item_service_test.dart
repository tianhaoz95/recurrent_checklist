import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:recurrent_checklist/lib/models/checklist_item.dart';
import 'package:recurrent_checklist/lib/services/checklist_item_service.dart';

// Mocks
class MockFirebaseFirestore extends Mock implements FirebaseFirestore {}
class MockCollectionReference extends Mock implements CollectionReference<Map<String, dynamic>> {}
class MockQuery extends Mock implements Query<Map<String, dynamic>> {}
class MockQuerySnapshot extends Mock implements QuerySnapshot<Map<String, dynamic>> {}
class MockDocumentReference extends Mock implements DocumentReference<Map<String, dynamic>> {}
class MockDocumentSnapshot extends Mock implements DocumentSnapshot<Map<String, dynamic>> {}
class MockFirebaseAuth extends Mock implements FirebaseAuth {}
class MockUser extends Mock implements User {}

void main() {
  group('ChecklistItemService Unit Tests', () {
    late ChecklistItemService service;
    late MockFirebaseFirestore mockFirestore;
    late MockFirebaseAuth mockFirebaseAuth;
    late MockCollectionReference mockCollectionRef;
    late MockQuery mockQuery;
    late MockQuerySnapshot mockQuerySnapshot;
    late MockDocumentReference mockDocumentRef;
    late MockUser mockUser;

    setUp(() {
      mockFirestore = MockFirebaseFirestore();
      mockFirebaseAuth = MockFirebaseAuth();
      mockCollectionRef = MockCollectionReference();
      mockQuery = MockQuery();
      mockQuerySnapshot = MockQuerySnapshot();
      mockDocumentRef = MockDocumentReference();
      mockUser = MockUser();

      // Mock FirebaseAuth.instance.currentUser
      when(mockFirebaseAuth.currentUser).thenReturn(mockUser);
      when(mockUser.uid).thenReturn('testUserId');

      // Mock FirebaseFirestore.instance.collection('checklistItems')
      when(mockFirestore.collection('checklistItems')).thenReturn(mockCollectionRef);

      // Inject mocks into service (assuming a refactored service for testability)
      // For this exercise, we'll simulate the interaction.
      service = ChecklistItemService(); // Using the actual service, but mocking its dependencies' behavior
    });

    test('createChecklistItem adds a new item to Firestore', () async {
      when(mockCollectionRef.add(any)).thenAnswer((_) async => mockDocumentRef);

      await service.createChecklistItem(content: 'New Task');

      verify(mockCollectionRef.add(argThat(
        isA<Map<String, dynamic>>()
            .having((map) => map['content'], 'content', 'New Task')
            .having((map) => map['userId'], 'userId', 'testUserId')
            .having((map) => map['isChecked'], 'isChecked', false),
      ))).called(1);
    });

    test('getChecklistItems returns a stream of items', () async {
      final mockDoc1 = MockDocumentSnapshot();
      final mockDoc2 = MockDocumentSnapshot();

      when(mockDoc1.id).thenReturn('item1');
      when(mockDoc1.data()).thenReturn({
        'userId': 'testUserId',
        'content': 'Task 1',
        'isChecked': false,
        'createdAt': Timestamp.now(),
        'updatedAt': Timestamp.now(),
      });
      when(mockDoc2.id).thenReturn('item2');
      when(mockDoc2.data()).thenReturn({
        'userId': 'testUserId',
        'content': 'Task 2',
        'isChecked': true,
        'createdAt': Timestamp.now(),
        'updatedAt': Timestamp.now(),
      });

      when(mockQuerySnapshot.docs).thenReturn([mockDoc1, mockDoc2]);
      when(mockCollectionRef.where('userId', isEqualTo: 'testUserId')).thenReturn(mockQuery);
      when(mockQuery.where('eventId', isNull: true)).thenReturn(mockQuery);
      when(mockQuery.snapshots()).thenAnswer((_) => Stream.fromIterable([mockQuerySnapshot]));

      final items = await service.getChecklistItems().first;

      expect(items.length, 2);
      expect(items[0].content, 'Task 1');
      expect(items[1].content, 'Task 2');
    });

    test('updateChecklistItem updates an existing item in Firestore', () async {
      when(mockCollectionRef.doc('item1')).thenReturn(mockDocumentRef);
      when(mockDocumentRef.update(any)).thenAnswer((_) async => Future.value());

      await service.updateChecklistItem(checklistItemId: 'item1', isChecked: true);

      verify(mockDocumentRef.update(argThat(
        isA<Map<String, dynamic>>()
            .having((map) => map['isChecked'], 'isChecked', true),
      ))).called(1);
    });

    test('deleteChecklistItem deletes an item from Firestore', () async {
      when(mockCollectionRef.doc('item1')).thenReturn(mockDocumentRef);
      when(mockDocumentRef.delete()).thenAnswer((_) async => Future.value());

      await service.deleteChecklistItem('item1');

      verify(mockDocumentRef.delete()).called(1);
    });

    test('deleteAllCheckedChecklistItems deletes all checked items', () async {
      final mockDoc1 = MockDocumentSnapshot();
      final mockDoc2 = MockDocumentSnapshot();

      when(mockDoc1.reference).thenReturn(mockDocumentRef);
      when(mockDoc2.reference).thenReturn(mockDocumentRef);
      when(mockDocumentRef.delete()).thenAnswer((_) async => Future.value());

      when(mockQuerySnapshot.docs).thenReturn([mockDoc1, mockDoc2]);
      when(mockCollectionRef.where('userId', isEqualTo: 'testUserId')).thenReturn(mockQuery);
      when(mockQuery.where('isChecked', isEqualTo: true)).thenReturn(mockQuery);
      when(mockQuery.get()).thenAnswer((_) async => mockQuerySnapshot);

      await service.deleteAllCheckedChecklistItems();

      verify(mockDocumentRef.delete()).called(2);
    });
  });
}