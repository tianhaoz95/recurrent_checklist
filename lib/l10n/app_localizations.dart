import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_zh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('zh'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Recurrent Checklist'**
  String get appTitle;

  /// No description provided for @signIn.
  ///
  /// In en, this message translates to:
  /// **'Sign In'**
  String get signIn;

  /// No description provided for @signUp.
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get signUp;

  /// No description provided for @register.
  ///
  /// In en, this message translates to:
  /// **'Register'**
  String get register;

  /// No description provided for @emailHint.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get emailHint;

  /// No description provided for @passwordHint.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get passwordHint;

  /// No description provided for @passwordLengthError.
  ///
  /// In en, this message translates to:
  /// **'Enter a password 6+ chars long'**
  String get passwordLengthError;

  /// No description provided for @signInError.
  ///
  /// In en, this message translates to:
  /// **'Could not sign in with those credentials'**
  String get signInError;

  /// No description provided for @emailEmptyError.
  ///
  /// In en, this message translates to:
  /// **'Enter an email'**
  String get emailEmptyError;

  /// No description provided for @homeScreenTitle.
  ///
  /// In en, this message translates to:
  /// **'Recurrent Checklist'**
  String get homeScreenTitle;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// No description provided for @checklistTab.
  ///
  /// In en, this message translates to:
  /// **'Checklist'**
  String get checklistTab;

  /// No description provided for @eventsTab.
  ///
  /// In en, this message translates to:
  /// **'Events'**
  String get eventsTab;

  /// No description provided for @settingsTab.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsTab;

  /// No description provided for @dailyChecklistTitle.
  ///
  /// In en, this message translates to:
  /// **'Daily Checklist'**
  String get dailyChecklistTitle;

  /// No description provided for @noChecklistItems.
  ///
  /// In en, this message translates to:
  /// **'No checklist items for today.'**
  String get noChecklistItems;

  /// No description provided for @sortChecklistItems.
  ///
  /// In en, this message translates to:
  /// **'Sort checklist items'**
  String get sortChecklistItems;

  /// No description provided for @deleteAllCheckedItems.
  ///
  /// In en, this message translates to:
  /// **'Delete all checked items'**
  String get deleteAllCheckedItems;

  /// No description provided for @toggleStatus.
  ///
  /// In en, this message translates to:
  /// **'Toggle status for {itemContent} to {newValue}'**
  String toggleStatus(Object itemContent, Object newValue);

  /// No description provided for @eventsScreenTitle.
  ///
  /// In en, this message translates to:
  /// **'Events'**
  String get eventsScreenTitle;

  /// No description provided for @noEventsYet.
  ///
  /// In en, this message translates to:
  /// **'No events yet. Add one!'**
  String get noEventsYet;

  /// No description provided for @editEvent.
  ///
  /// In en, this message translates to:
  /// **'Edit event: {eventName}'**
  String editEvent(Object eventName);

  /// No description provided for @deleteEvent.
  ///
  /// In en, this message translates to:
  /// **'Delete event: {eventName}'**
  String deleteEvent(Object eventName);

  /// No description provided for @addChecklistItemToEvent.
  ///
  /// In en, this message translates to:
  /// **'Add checklist item to event: {eventName}'**
  String addChecklistItemToEvent(Object eventName);

  /// No description provided for @addEvent.
  ///
  /// In en, this message translates to:
  /// **'Add new event'**
  String get addEvent;

  /// No description provided for @addEditEventDialogTitleAdd.
  ///
  /// In en, this message translates to:
  /// **'Add New Event'**
  String get addEditEventDialogTitleAdd;

  /// No description provided for @addEditEventDialogTitleEdit.
  ///
  /// In en, this message translates to:
  /// **'Edit Event'**
  String get addEditEventDialogTitleEdit;

  /// No description provided for @eventNameLabel.
  ///
  /// In en, this message translates to:
  /// **'Event Name'**
  String get eventNameLabel;

  /// No description provided for @eventNameEmptyError.
  ///
  /// In en, this message translates to:
  /// **'Please enter an event name'**
  String get eventNameEmptyError;

  /// No description provided for @noteLabel.
  ///
  /// In en, this message translates to:
  /// **'Note (Optional)'**
  String get noteLabel;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @add.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get add;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @addChecklistItemDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'Add Checklist Item'**
  String get addChecklistItemDialogTitle;

  /// No description provided for @itemContentLabel.
  ///
  /// In en, this message translates to:
  /// **'Item Content'**
  String get itemContentLabel;

  /// No description provided for @itemContentEmptyError.
  ///
  /// In en, this message translates to:
  /// **'Please enter item content'**
  String get itemContentEmptyError;

  /// No description provided for @settingsScreenTitle.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsScreenTitle;

  /// No description provided for @signOut.
  ///
  /// In en, this message translates to:
  /// **'Sign Out'**
  String get signOut;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @deleteAccount.
  ///
  /// In en, this message translates to:
  /// **'Delete Account'**
  String get deleteAccount;

  /// No description provided for @deleteAccountConfirmationTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete Account'**
  String get deleteAccountConfirmationTitle;

  /// No description provided for @deleteAccountConfirmationMessage.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete your account? This action is irreversible and will delete all your data.'**
  String get deleteAccountConfirmationMessage;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @english.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get english;

  /// No description provided for @chinese.
  ///
  /// In en, this message translates to:
  /// **'Chinese'**
  String get chinese;

  /// No description provided for @systemDefault.
  ///
  /// In en, this message translates to:
  /// **'System Default'**
  String get systemDefault;

  /// No description provided for @errorLoadingChecklistItems.
  ///
  /// In en, this message translates to:
  /// **'Error loading checklist items: {error}'**
  String errorLoadingChecklistItems(Object error);

  /// No description provided for @noChecklistItemsForEvent.
  ///
  /// In en, this message translates to:
  /// **'No checklist items for this event.'**
  String get noChecklistItemsForEvent;

  /// No description provided for @checklistItems.
  ///
  /// In en, this message translates to:
  /// **'Checklist Items:'**
  String get checklistItems;

  /// No description provided for @deletedCheckedItems.
  ///
  /// In en, this message translates to:
  /// **'Deleted checked items'**
  String get deletedCheckedItems;

  /// No description provided for @noItemsCheckedToDelete.
  ///
  /// In en, this message translates to:
  /// **'No items checked to delete'**
  String get noItemsCheckedToDelete;

  /// No description provided for @deleteEventConfirmationTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete Event'**
  String get deleteEventConfirmationTitle;

  /// No description provided for @deleteEventConfirmationMessage.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete \"{eventName}\"? This will also delete all associated checklist items.'**
  String deleteEventConfirmationMessage(Object eventName);

  /// No description provided for @pleaseSignInToViewEvents.
  ///
  /// In en, this message translates to:
  /// **'Please sign in to view events.'**
  String get pleaseSignInToViewEvents;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'zh'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'zh':
      return AppLocalizationsZh();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
