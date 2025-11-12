import 'package:flutter/material.dart';
import 'package:recurrent_checklist/services/auth_service.dart';
import 'package:recurrent_checklist/services/firestore_service.dart';
import 'package:recurrent_checklist/generated/l10n/app_localizations.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final AuthService _auth = AuthService();
  final FirestoreService _firestoreService = FirestoreService();
  String? _selectedLanguage;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Initialize _selectedLanguage based on current locale
    final locale = Localizations.localeOf(context);
    if (locale.languageCode == 'en') {
      _selectedLanguage = AppLocalizations.of(context)!.english;
    } else if (locale.languageCode == 'zh') {
      _selectedLanguage = AppLocalizations.of(context)!.chinese;
    } else {
      _selectedLanguage = AppLocalizations.of(context)!.systemDefault;
    }
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
              value: _selectedLanguage,
              onChanged: (String? newValue) {
                setState(() {
                  _selectedLanguage = newValue;
                  // TODO: Implement actual language change logic
                  // This would typically involve a package like provider or bloc
                  // to update the MaterialApp's locale.
                });
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