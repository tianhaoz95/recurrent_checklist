import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:recurrent_checklist/services/auth_service.dart';
import 'package:recurrent_checklist/models/user.dart' as app_user;
import 'package:recurrent_checklist/screens/auth/authenticate.dart';
import 'package:recurrent_checklist/screens/home_screen.dart';
import 'firebase_options.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:recurrent_checklist/l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:recurrent_checklist/utils/locale_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  } catch (e) {
    print('Error initializing Firebase: $e');
    // Optionally, display an error screen or dialog to the user
  }
  runApp(
    ChangeNotifierProvider(
      create: (context) => LocaleProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Recurrent Checklist',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // Internationalization configuration
      locale: Provider.of<LocaleProvider>(context).locale, // Use locale from provider
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'), // English
        Locale('zh'), // Chinese
      ],
      home: StreamBuilder<app_user.User?>(
        stream: AuthService().user,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            final app_user.User? user = snapshot.data;
            if (user == null) {
              return Authenticate();
            } else {
              return HomeScreen();
            }
          }
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        },
      ),
    );
  }
}
