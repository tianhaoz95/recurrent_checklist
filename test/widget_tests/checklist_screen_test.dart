import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:recurrent_checklist/lib/models/checklist_item.dart';
import 'package:recurrent_checklist/lib/screens/checklist_screen.dart';
import 'package:recurrent_checklist/lib/services/checklist_item_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb_auth;

// Mock ChecklistItemService
class MockChecklistItemService extends Mock implements ChecklistItemService {}

// Mock FirebaseAuth for currentUserId
class MockFirebaseAuth extends Mock implements fb_auth.FirebaseAuth {}

// Mock User for currentUserId
class MockUser extends Mock implements fb_auth.User {}

void main() {
  group('ChecklistScreen Widget Tests', () {
    late MockChecklistItemService mockChecklistItemService;
    late MockFirebaseAuth mockFirebaseAuth;
    late MockUser mockUser;

    final List<ChecklistItem> testItems = [
      ChecklistItem(
        id: '1',
        userId: 'testUserId',
        content: 'Zebra',
        isChecked: false,
        createdAt: Timestamp.fromDate(DateTime(2023, 1, 3)),
        updatedAt: Timestamp.fromDate(DateTime(2023, 1, 3)),
      ),
      ChecklistItem(
        id: '2',
        userId: 'testUserId',
        content: 'Apple',
        isChecked: true,
        createdAt: Timestamp.fromDate(DateTime(2023, 1, 1)),
        updatedAt: Timestamp.fromDate(DateTime(2023, 1, 1)),
      ),
      ChecklistItem(
        id: '3',
        userId: 'testUserId',
        content: 'Banana',
        isChecked: false,
        createdAt: Timestamp.fromDate(DateTime(2023, 1, 2)),
        updatedAt: Timestamp.fromDate(DateTime(2023, 1, 2)),
      ),
    ];

    setUp(() {
      mockChecklistItemService = MockChecklistItemService();
      mockFirebaseAuth = MockFirebaseAuth();
      mockUser = MockUser();

      // Mock currentUserId
      when(mockFirebaseAuth.currentUser).thenReturn(mockUser);
      when(mockUser.uid).thenReturn('testUserId');

      // Mock getChecklistItems stream
      when(mockChecklistItemService.getChecklistItems(eventId: anyNamed('eventId')))
          .thenAnswer((_) => Stream.fromIterable([testItems]));

      // Mock createChecklistItem
      when(mockChecklistItemService.createChecklistItem(content: anyNamed('content'), eventId: anyNamed('eventId')))
          .thenAnswer((_) async => Future.value());

      // Mock updateChecklistItem
      when(mockChecklistItemService.updateChecklistItem(
        checklistItemId: anyNamed('checklistItemId'),
        content: anyNamed('content'),
        isChecked: anyNamed('isChecked'),
      )).thenAnswer((_) async => Future.value());

      // Mock deleteAllCheckedChecklistItems
      when(mockChecklistItemService.deleteAllCheckedChecklistItems()).thenAnswer((_) async => Future.value());
    });

    Widget createWidgetUnderTest() {
      return MaterialApp(
        home: ChecklistScreen(),
      );
    }

    testWidgets('renders app bar and add item field', (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.text('My Checklist'), findsOneWidget);
      expect(find.widgetWithText(TextField, 'Add new item'), findsOneWidget);
      expect(find.byIcon(Icons.add), findsOneWidget);
    });

    testWidgets('displays checklist items', (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle(); // Wait for StreamBuilder to emit data

      expect(find.text('Zebra'), findsOneWidget);
      expect(find.text('Apple'), findsOneWidget);
      expect(find.text('Banana'), findsOneWidget);
      expect(find.byType(CheckboxListTile), findsNWidgets(3));
    });

    testWidgets('adds a new checklist item', (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle();

      await tester.enterText(find.widgetWithText(TextField, 'Add new item'), 'New Item');
      await tester.tap(find.byIcon(Icons.add));
      await tester.pump();

      verify(mockChecklistItemService.createChecklistItem(content: 'New Item')).called(1);
      expect(find.widgetWithText(TextField, 'Add new item'), findsOneWidget); // Text field should be cleared
    });

    testWidgets('toggles checklist item status', (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle();

      // Tap on 'Zebra' (initially unchecked)
      await tester.tap(find.text('Zebra'));
      await tester.pump();

      verify(mockChecklistItemService.updateChecklistItem(
        checklistItemId: '1',
        isChecked: true,
      )).called(1);
    });

    testWidgets('sorts items alphabetically', (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle();

      await tester.tap(find.byIcon(Icons.sort));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Alphabetical'));
      await tester.pumpAndSettle();

      final listTiles = tester.widgetList(find.byType(ListTile)).toList();
      expect((listTiles[0] as ListTile).title.toString(), contains('Apple'));
      expect((listTiles[1] as ListTile).title.toString(), contains('Banana'));
      expect((listTiles[2] as ListTile).title.toString(), contains('Zebra'));
    });

    testWidgets('sorts items by completion status', (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle();

      await tester.tap(find.byIcon(Icons.sort));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Completion Status'));
      await tester.pumpAndSettle();

      final listTiles = tester.widgetList(find.byType(ListTile)).toList();
      expect((listTiles[0] as ListTile).title.toString(), contains('Banana')); // Incomplete
      expect((listTiles[1] as ListTile).title.toString(), contains('Zebra')); // Incomplete
      expect((listTiles[2] as ListTile).title.toString(), contains('Apple')); // Complete
    });

    testWidgets('sorts items by creation date (newest first)', (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle();

      await tester.tap(find.byIcon(Icons.sort));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Creation Date'));
      await tester.pumpAndSettle();

      final listTiles = tester.widgetList(find.byType(ListTile)).toList();
      expect((listTiles[0] as ListTile).title.toString(), contains('Zebra')); // Newest
      expect((listTiles[1] as ListTile).title.toString(), contains('Banana'));
      expect((listTiles[2] as ListTile).title.toString(), contains('Apple')); // Oldest
    });

    testWidgets('deletes all checked items when button is tapped', (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle();

      await tester.tap(find.byIcon(Icons.delete_sweep));
      await tester.pump();

      verify(mockChecklistItemService.deleteAllCheckedChecklistItems()).called(1);
    });
  });
}