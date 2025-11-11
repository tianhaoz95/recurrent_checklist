import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:recurrent_checklist/lib/screens/home_screen.dart';
import 'package:recurrent_checklist/lib/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb_auth;

// Mock AuthService
class MockAuthService extends Mock implements AuthService {}

void main() {
  group('HomeScreen Widget Tests', () {
    late MockAuthService mockAuthService;

    setUp(() {
      mockAuthService = MockAuthService();
      // Mock the user stream to return a non-null user for authenticated state
      when(mockAuthService.user).thenAnswer((_) => Stream.value(MockUser()));
    });

    Widget createWidgetUnderTest() {
      return Provider<AuthService>(
        create: (_) => mockAuthService,
        child: const MaterialApp(
          home: HomeScreen(),
        ),
      );
    }

    testWidgets('renders app bar with title and logout button', (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.text('Recurrent Checklist'), findsOneWidget);
      expect(find.byIcon(Icons.logout), findsOneWidget);
    });

    testWidgets('renders bottom navigation bar with correct items', (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.byIcon(Icons.check_box), findsOneWidget);
      expect(find.text('Checklist'), findsOneWidget);
      expect(find.byIcon(Icons.event), findsOneWidget);
      expect(find.text('Events'), findsOneWidget);
      expect(find.byIcon(Icons.settings), findsOneWidget);
      expect(find.text('Settings'), findsOneWidget);
    });

    testWidgets('navigates to ChecklistScreen when Checklist item is tapped', (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle(); // Ensure initial build is complete

      await tester.tap(find.text('Checklist'));
      await tester.pumpAndSettle();

      expect(find.text('My Checklist'), findsOneWidget); // Assuming ChecklistScreen has this title
    });

    testWidgets('navigates to EventsScreen when Events item is tapped', (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle();

      await tester.tap(find.text('Events'));
      await tester.pumpAndSettle();

      expect(find.text('My Events'), findsOneWidget); // Assuming EventsScreen has this title
    });

    testWidgets('navigates to SettingsScreen when Settings item is tapped', (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle();

      await tester.tap(find.text('Settings'));
      await tester.pumpAndSettle();

      expect(find.text('Settings Screen Content'), findsOneWidget); // Assuming SettingsScreen has this content
    });

    testWidgets('calls signOut when logout button is tapped', (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest());

      await tester.tap(find.byIcon(Icons.logout));
      await tester.pump();

      verify(mockAuthService.signOut()).called(1);
    });
  });
}

class MockUser extends Mock implements fb_auth.User {}