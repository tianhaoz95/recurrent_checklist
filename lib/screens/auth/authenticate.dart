import 'package:flutter/material.dart';
import 'package:recurrent_checklist/screens/auth/sign_in_screen.dart';
import 'package:recurrent_checklist/screens/auth/sign_up_screen.dart';

class Authenticate extends StatefulWidget {
  const Authenticate({super.key});

  @override
  State<Authenticate> createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showSignIn = true;

  void toggleView() {
    setState(() => showSignIn = !showSignIn);
  }

  @override
  Widget build(BuildContext context) {
    if (showSignIn) {
      return SignInScreen(toggleView: toggleView);
    } else {
      return SignUpScreen(toggleView: toggleView);
    }
  }
}