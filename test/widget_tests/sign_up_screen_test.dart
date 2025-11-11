import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:recurrent_checklist/lib/screens/sign_up_screen.dart';
import 'package:recurrent_checklist/lib/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

// Mock AuthService
class MockAuthService extends Mock implements AuthService {}

// Mock FirebaseAuthException
class MockFirebaseAuthException extends Mock implements FirebaseAuthException {}

void main() {
  group('SignUpScreen Widget Tests', () {
    late MockAuthService mockAuthService;

    setUp(() {
      mockAuthService = MockAuthService();
    });

    Widget createWidgetUnderTest() {
      return Provider<AuthService>(
        create: (_) => mockAuthService,
        child: const MaterialApp(
          home: SignUpScreen(),
        ),
      );
    }

    testWidgets('renders email and password text fields and sign up button', (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.widgetWithText(TextField, 'Email'), findsOneWidget);
      expect(find.widgetWithText(TextField, 'Password'), findsOneWidget);
      expect(find.widgetWithText(ElevatedButton, 'Sign Up'), findsOneWidget);
      expect(find.widgetWithText(TextButton, 'Already have an account? Sign In'), findsOneWidget);
    });

    testWidgets('shows error message on failed sign up', (WidgetTester tester) async {
      when(mockAuthService.signUp(any, any)).thenThrow(
        MockFirebaseAuthException(),
      );

      await tester.pumpWidget(createWidgetUnderTest());

      await tester.enterText(find.widgetWithText(TextField, 'Email'), 'test@example.com');
      await tester.enterText(find.widgetWithText(TextField, 'Password'), 'password123');
      await tester.tap(find.widgetWithText(ElevatedButton, 'Sign Up'));
      await tester.pumpAndSettle();

      expect(find.byType(SnackBar), findsOneWidget);
    });

    testWidgets('navigates back on successful sign up', (WidgetTester tester) async {
      when(mockAuthService.signUp(any, any)).thenAnswer((_) async => mockUserCredential());

      await tester.pumpWidget(createWidgetUnderTest());

      await tester.enterText(find.widgetWithText(TextField, 'Email'), 'test@example.com');
      await tester.enterText(find.widgetWithText(TextField, 'Password'), 'password123');
      await tester.tap(find.widgetWithText(ElevatedButton, 'Sign Up'));
      await tester.pumpAndSettle();

      // Verify that pop was called (navigated back)
      // This is a simplified check, in a real app you might check the route stack
      expect(find.byType(SignUpScreen), findsNothing);
    });
  });
}

// Helper function to create a mock UserCredential
UserCredential mockUserCredential() {
  return MockUserCredential();
}

class MockUserCredential extends Mock implements UserCredential {}