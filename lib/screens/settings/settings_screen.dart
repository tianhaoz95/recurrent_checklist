import 'package:flutter/material.dart';
import 'package:recurrent_checklist/services/auth_service.dart';
import 'package:recurrent_checklist/services/firestore_service.dart';
import 'package:recurrent_checklist/utils/locale_provider.dart';
import 'package:provider/provider.dart'; // Add this import
import 'package:recurrent_checklist/l10n/app_localizations.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final localeProvider = Provider.of<LocaleProvider>(context);
    final appLocalizations = AppLocalizations.of(context)!;

    String currentLanguage = 'System Default';
    if (localeProvider.locale != null) {
      if (localeProvider.locale!.languageCode == 'en') {
        currentLanguage = appLocalizations.english;
      } else if (localeProvider.locale!.languageCode == 'zh') {
        currentLanguage = appLocalizations.chinese;
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(appLocalizations.settingsScreenTitle),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text(appLocalizations.signOut),
            leading: const Icon(Icons.logout),
            onTap: () async {
              await AuthService().signOut();
            },
          ),
          ListTile(
            title: Text(appLocalizations.deleteAccount),
            leading: const Icon(Icons.delete_forever),
            onTap: () async {
              // Show confirmation dialog
              final confirmDelete = await showDialog<bool>(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text(appLocalizations.deleteAccountConfirmationTitle),
                  content: Text(appLocalizations.deleteAccountConfirmationMessage),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(false),
                      child: Text(appLocalizations.cancel),
                    ),
                    ElevatedButton(
                      onPressed: () => Navigator.of(context).pop(true),
                      child: Text(appLocalizations.delete),
                    ),
                  ],
                ),
              );

              if (confirmDelete == true) {
                // Delete user data from Firestore first
                await FirestoreService().deleteAllUserData();
                // Then delete the user account from Firebase Auth
                await AuthService().deleteUser();
              }
            },
          ),
          ListTile(
            title: Text(appLocalizations.language),
            leading: const Icon(Icons.language),
            trailing: DropdownButton<String>(
              value: currentLanguage,
              onChanged: (String? newValue) {
                if (newValue == appLocalizations.english) {
                  localeProvider.setLocale(const Locale('en'));
                } else if (newValue == appLocalizations.chinese) {
                  localeProvider.setLocale(const Locale('zh'));
                } else {
                  localeProvider.clearLocale(); // System Default
                }
              },
              items: <String>[
                appLocalizations.english,
                appLocalizations.chinese,
                appLocalizations.systemDefault,
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}