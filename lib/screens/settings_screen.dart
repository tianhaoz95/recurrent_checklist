import 'package:flutter/material.dart';
import 'package:recurrent_checklist/services/auth_service.dart';
import 'package:recurrent_checklist/services/firestore_service.dart';
import 'package:recurrent_checklist/generated/l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Added import
import 'package:recurrent_checklist/main.dart'; // Added import

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final AuthService _auth = AuthService();
  final FirestoreService _firestoreService = FirestoreService();
  String? _selectedLanguageDisplayName; // Display name for the selected language

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _updateSelectedLanguageDisplayName();
  }

  void _updateSelectedLanguageDisplayName() async {
    final l10n = AppLocalizations.of(context)!;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? languageCode = prefs.getString('languageCode');

    setState(() {
      if (languageCode == null) {
        _selectedLanguageDisplayName = l10n.systemDefault;
      }
      else if (languageCode == 'en') {
        _selectedLanguageDisplayName = l10n.english;
      }
      else if (languageCode == 'zh') {
        _selectedLanguageDisplayName = l10n.chinese;
      }
      else {
        _selectedLanguageDisplayName = l10n.systemDefault;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.settings),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                await _auth.signOut();
              },
              child: Text(l10n.signOut),
            ),
            ElevatedButton(
              onPressed: () async {
                // Show confirmation dialog
                bool confirm = await showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Confirm Delete Account'),
                      content: const Text(
                          'Are you sure you want to delete your account? This action cannot be undone.'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(false),
                          child: const Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(true),
                          child: const Text('Delete'),
                        ),
                      ],
                    );
                  },
                );

                if (confirm) {
                  await _firestoreService.deleteAllUserData();
                  await _auth.deleteAccount();
                }
              },
              child: Text(l10n.deleteAccount),
            ),
            DropdownButton<String>(
              value: _selectedLanguageDisplayName,
              onChanged: (String? newValue) {
                if (newValue != null) {
                  setState(() {
                    _selectedLanguageDisplayName = newValue;
                  });
                  Locale? newLocale; // Changed to nullable Locale
                  if (newValue == l10n.english) {
                    newLocale = const Locale('en');
                  }
                  else if (newValue == l10n.chinese) {
                    newLocale = const Locale('zh');
                  }
                  else {
                    // System Default - set to null to use system locale
                    newLocale = null;
                  }
                  MyApp.setLocale(context, newLocale);
                }
              },
              items: <String>[
                l10n.english,
                l10n.chinese,
                l10n.systemDefault
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}