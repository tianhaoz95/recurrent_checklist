// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Recurrent Checklist';

  @override
  String get signIn => 'Sign In';

  @override
  String get signUp => 'Sign Up';

  @override
  String get register => 'Register';

  @override
  String get emailHint => 'Email';

  @override
  String get passwordHint => 'Password';

  @override
  String get passwordLengthError => 'Enter a password 6+ chars long';

  @override
  String get signInError => 'Could not sign in with those credentials';

  @override
  String get emailEmptyError => 'Enter an email';

  @override
  String get homeScreenTitle => 'Recurrent Checklist';

  @override
  String get logout => 'Logout';

  @override
  String get checklistTab => 'Checklist';

  @override
  String get eventsTab => 'Events';

  @override
  String get settingsTab => 'Settings';

  @override
  String get dailyChecklistTitle => 'Daily Checklist';

  @override
  String get noChecklistItems => 'No checklist items for today.';

  @override
  String get sortChecklistItems => 'Sort checklist items';

  @override
  String get deleteAllCheckedItems => 'Delete all checked items';

  @override
  String toggleStatus(Object itemContent, Object newValue) {
    return 'Toggle status for $itemContent to $newValue';
  }

  @override
  String get eventsScreenTitle => 'Events';

  @override
  String get noEventsYet => 'No events yet. Add one!';

  @override
  String editEvent(Object eventName) {
    return 'Edit event: $eventName';
  }

  @override
  String deleteEvent(Object eventName) {
    return 'Delete event: $eventName';
  }

  @override
  String addChecklistItemToEvent(Object eventName) {
    return 'Add checklist item to event: $eventName';
  }

  @override
  String get addEvent => 'Add new event';

  @override
  String get addEditEventDialogTitleAdd => 'Add New Event';

  @override
  String get addEditEventDialogTitleEdit => 'Edit Event';

  @override
  String get eventNameLabel => 'Event Name';

  @override
  String get eventNameEmptyError => 'Please enter an event name';

  @override
  String get noteLabel => 'Note (Optional)';

  @override
  String get cancel => 'Cancel';

  @override
  String get add => 'Add';

  @override
  String get save => 'Save';

  @override
  String get addChecklistItemDialogTitle => 'Add Checklist Item';

  @override
  String get itemContentLabel => 'Item Content';

  @override
  String get itemContentEmptyError => 'Please enter item content';

  @override
  String get settingsScreenTitle => 'Settings';

  @override
  String get signOut => 'Sign Out';

  @override
  String get delete => 'Delete';

  @override
  String get deleteAccount => 'Delete Account';

  @override
  String get deleteAccountConfirmationTitle => 'Delete Account';

  @override
  String get deleteAccountConfirmationMessage =>
      'Are you sure you want to delete your account? This action is irreversible and will delete all your data.';

  @override
  String get language => 'Language';

  @override
  String get english => 'English';

  @override
  String get chinese => 'Chinese';

  @override
  String get systemDefault => 'System Default';

  @override
  String errorLoadingChecklistItems(Object error) {
    return 'Error loading checklist items: $error';
  }

  @override
  String get noChecklistItemsForEvent => 'No checklist items for this event.';

  @override
  String get checklistItems => 'Checklist Items:';

  @override
  String get deletedCheckedItems => 'Deleted checked items';

  @override
  String get noItemsCheckedToDelete => 'No items checked to delete';

  @override
  String get deleteEventConfirmationTitle => 'Delete Event';

  @override
  String deleteEventConfirmationMessage(Object eventName) {
    return 'Are you sure you want to delete \"$eventName\"? This will also delete all associated checklist items.';
  }

  @override
  String get pleaseSignInToViewEvents => 'Please sign in to view events.';
}
