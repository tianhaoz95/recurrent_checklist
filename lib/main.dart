import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:recurrent_checklist/firebase_options.dart';
import 'package:recurrent_checklist/screens/main_screen.dart';
import 'package:recurrent_checklist/screens/sign_in_screen.dart';
import 'package:recurrent_checklist/screens/sign_up_screen.dart'; // Added import
import 'package:recurrent_checklist/generated/l10n/app_localizations.dart';
import 'package:workmanager/workmanager.dart'; // Import workmanager
import 'package:recurrent_checklist/services/background_service.dart'; // Import background service
import 'package:shared_preferences/shared_preferences.dart'; // Added import

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Initialize Workmanager
  Workmanager().initialize(
    callbackDispatcher, // The top-level function to be called
    isInDebugMode: true, // Set to false in production
  );

  // Register a periodic task
  Workmanager().registerPeriodicTask(
    "1", // Unique ID for the task
    RECURRING_EVENT_TASK, // Task name
    frequency: const Duration(hours: 1), // Run every hour
    initialDelay: const Duration(minutes: 5), // Start after 5 minutes
    constraints: Constraints(
      networkType: NetworkType.connected,
    ),
  );

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  static void setLocale(BuildContext context, Locale? newLocale) {
    _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();
    state?.setLocale(newLocale);
  }

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale? _locale;

  @override
  void initState() {
    super.initState();
    _loadLocale();
  }

  _loadLocale() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? languageCode = prefs.getString('languageCode');
    if (languageCode != null) {
      setState(() {
        _locale = _getLocaleFromLanguageCode(languageCode);
      });
    } else {
      setState(() {
        _locale = null; // Use system default
      });
    }
  }

  static Locale _getLocaleFromLanguageCode(String languageCode) {
    switch (languageCode) {
      case 'en':
        return const Locale('en');
      case 'zh':
        return const Locale('zh');
      default:
        return const Locale('en'); // Default to English
    }
  }

  void setLocale(Locale? newLocale) {
    setState(() {
      _locale = newLocale;
    });
    if (newLocale == null) {
      _saveLocale(null);
    } else {
      _saveLocale(newLocale.languageCode);
    }
  }

  _saveLocale(String? languageCode) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (languageCode == null) {
      await prefs.remove('languageCode');
    } else {
      await prefs.setString('languageCode', languageCode);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Recurrent Checklist',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      locale: _locale, // Use the managed locale
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'), // English
        Locale('zh'), // Chinese
      ],
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasData) {
            return const MainScreen();
          }
          return const SignInScreen();
        },
      ),
      routes: {
        '/signin': (context) => const SignInScreen(),
        '/signup': (context) => SignUpScreen(),
        '/main': (context) => const MainScreen(),
      },
    );
  }
}
