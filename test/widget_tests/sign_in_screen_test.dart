import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:recurrent_checklist/lib/screens/sign_in_screen.dart';
import 'package:recurrent_checklist/lib/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

// Mock AuthService
class MockAuthService extends Mock implements AuthService {}

// Mock FirebaseAuthException
class MockFirebaseAuthException extends Mock implements FirebaseAuthException {}

void main() {
  group('SignInScreen Widget Tests', () {
    late MockAuthService mockAuthService;

    setUp(() {
      mockAuthService = MockAuthService();
    });

    Widget createWidgetUnderTest() {
      return Provider<AuthService>(
        create: (_) => mockAuthService,
        child: const MaterialApp(
          home: SignInScreen(),
        ),
      );
    }

    testWidgets('renders email and password text fields and sign in button', (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.widgetWithText(TextField, 'Email'), findsOneWidget);
      expect(find.widgetWithText(TextField, 'Password'), findsOneWidget);
      expect(find.widgetWithText(ElevatedButton, 'Sign In'), findsOneWidget);
      expect(find.widgetWithText(TextButton, 'Don\'t have an account? Sign Up'), findsOneWidget);
    });

    testWidgets('shows error message on failed sign in', (WidgetTester tester) async {
      when(mockAuthService.signIn(any, any)).thenThrow(
        MockFirebaseAuthException(),
      );

      await tester.pumpWidget(createWidgetUnderTest());

      await tester.enterText(find.widgetWithText(TextField, 'Email'), 'test@example.com');
      await tester.enterText(find.widgetWithText(TextField, 'Password'), 'password123');
      await tester.tap(find.widgetWithText(ElevatedButton, 'Sign In'));
      await tester.pumpAndSettle();

      expect(find.byType(SnackBar), findsOneWidget);
    });

    testWidgets('navigates to sign up screen when "Sign Up" button is tapped', (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest());

      await tester.tap(find.widgetWithText(TextButton, 'Don\'t have an account? Sign Up'));
      await tester.pumpAndSettle();

      // Verify that a new route was pushed (to SignUpScreen)
      // This is a simplified check, in a real app you might check the route stack
      expect(find.text('Sign Up'), findsOneWidget); // Assuming SignUpScreen has an AppBar with title 'Sign Up'
    });
  });
}
