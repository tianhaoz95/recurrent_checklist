import 'package:firebase_auth/firebase_auth.dart';
import 'package:recurrent_checklist/models/user.dart' as app_user; // Alias to avoid conflict with firebase_auth.User

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Stream to listen to authentication state changes
  Stream<app_user.User?> get user {
    return _auth.authStateChanges().map((firebaseUser) {
      if (firebaseUser == null) {
        return null;
      } else {
        return app_user.User.fromFirebaseUser(firebaseUser);
      }
    });
  }

  // Sign up with email and password
  Future<app_user.User?> signUpWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User? firebaseUser = result.user;
      if (firebaseUser != null) {
        return app_user.User.fromFirebaseUser(firebaseUser);
      }
      return null;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // Sign in with email and password
  Future<app_user.User?> signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User? firebaseUser = result.user;
      if (firebaseUser != null) {
        return app_user.User.fromFirebaseUser(firebaseUser);
      }
      return null;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // Sign out
  Future<void> signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // Delete user
  Future<void> deleteUser() async {
    try {
      await _auth.currentUser?.delete();
    } catch (e) {
      print(e.toString());
      // Re-authenticate if necessary, as per Firebase documentation
      // For simplicity, this example doesn't include re-authentication logic
      return null;
    }
  }
}