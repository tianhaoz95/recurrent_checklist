class User {
  final String uid;
  final String email;

  User({required this.uid, required this.email});

  // Factory constructor to create a User from a Firebase User object
  factory User.fromFirebaseUser(dynamic firebaseUser) {
    return User(
      uid: firebaseUser.uid,
      email: firebaseUser.email ?? '', // Email might be null for some providers
    );
  }

  // Method to convert User object to a map for Firestore (if needed, though Firebase Auth handles user data)
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
    };
  }
}