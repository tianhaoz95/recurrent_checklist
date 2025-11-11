import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:recurrent_checklist/lib/models/event.dart';
import 'package:recurrent_checklist/lib/screens/events_screen.dart';
import 'package:recurrent_checklist/lib/services/event_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb_auth;

// Mock EventService
class MockEventService extends Mock implements EventService {}

// Mock FirebaseAuth for currentUserId
class MockFirebaseAuth extends Mock implements fb_auth.FirebaseAuth {}

// Mock User for currentUserId
class MockUser extends Mock implements fb_auth.User {}

void main() {
  group('EventsScreen Widget Tests', () {
    late MockEventService mockEventService;
    late MockFirebaseAuth mockFirebaseAuth;
    late MockUser mockUser;

    setUp(() {
      mockEventService = MockEventService();
      mockFirebaseAuth = MockFirebaseAuth();
      mockUser = MockUser();

      // Mock currentUserId
      when(mockFirebaseAuth.currentUser).thenReturn(mockUser);
      when(mockUser.uid).thenReturn('testUserId');

      // Mock getEvents stream
      when(mockEventService.getEvents()).thenAnswer((_) => Stream.fromIterable([
                [
                  Event(
                    id: 'event1',
                    userId: 'testUserId',
                    name: 'Morning Routine',
                    note: 'Daily tasks',
                    createdAt: Timestamp.now(),
                    updatedAt: Timestamp.now(),
                  ),
                  Event(
                    id: 'event2',
                    userId: 'testUserId',
                    name: 'Evening Chores',
                    note: null,
                    createdAt: Timestamp.now(),
                    updatedAt: Timestamp.now(),
                  ),
                ],
              ]));

      // Mock createEvent
      when(mockEventService.createEvent(name: anyNamed('name'), note: anyNamed('note')))
          .thenAnswer((_) async => Future.value());

      // Mock updateEvent
      when(mockEventService.updateEvent(
        eventId: anyNamed('eventId'),
        name: anyNamed('name'),
        note: anyNamed('note'),
      )).thenAnswer((_) async => Future.value());

      // Mock deleteEvent
      when(mockEventService.deleteEvent(any)).thenAnswer((_) async => Future.value());
    });

    Widget createWidgetUnderTest() {
      return MaterialApp(
        home: EventsScreen(),
      );
    }

    testWidgets('renders app bar and add event button', (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.text('My Events'), findsOneWidget);
      expect(find.byIcon(Icons.add), findsOneWidget);
    });

    testWidgets('displays events', (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle(); // Wait for StreamBuilder to emit data

      expect(find.text('Morning Routine'), findsOneWidget);
      expect(find.text('Daily tasks'), findsOneWidget);
      expect(find.text('Evening Chores'), findsOneWidget);
      expect(find.byType(Card), findsNWidgets(2));
    });

    testWidgets('adds a new event', (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle();

      await tester.tap(find.byIcon(Icons.add));
      await tester.pumpAndSettle(); // Show dialog

      expect(find.text('Add New Event'), findsOneWidget);

      await tester.enterText(find.widgetWithText(TextField, 'Event Name'), 'New Event');
      await tester.enterText(find.widgetWithText(TextField, 'Note (Optional)'), 'New Note');
      await tester.tap(find.widgetWithText(ElevatedButton, 'Add'));
      await tester.pumpAndSettle();

      verify(mockEventService.createEvent(name: 'New Event', note: 'New Note')).called(1);
    });

    testWidgets('edits an event', (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle();

      await tester.tap(find.byIcon(Icons.edit).first);
      await tester.pumpAndSettle(); // Show dialog

      expect(find.text('Edit Event'), findsOneWidget);

      await tester.enterText(find.widgetWithText(TextField, 'Event Name'), 'Updated Morning Routine');
      await tester.tap(find.widgetWithText(ElevatedButton, 'Save'));
      await tester.pumpAndSettle();

      verify(mockEventService.updateEvent(
        eventId: 'event1',
        name: 'Updated Morning Routine',
        note: 'Daily tasks',
      )).called(1);
    });

    testWidgets('deletes an event', (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle();

      await tester.tap(find.byIcon(Icons.delete).first);
      await tester.pump();

      verify(mockEventService.deleteEvent('event1')).called(1);
    });
  });
}