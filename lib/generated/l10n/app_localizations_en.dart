// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'Recurrent Checklist';

  @override
  String get signIn => 'Sign In';

  @override
  String get signUp => 'Sign Up';

  @override
  String get email => 'Email';

  @override
  String get password => 'Password';

  @override
  String get checklist => 'Checklist';

  @override
  String get events => 'Events';

  @override
  String get settings => 'Settings';

  @override
  String get sort => 'Sort';

  @override
  String get deleteAllChecked => 'Delete All Checked';

  @override
  String get addEvent => 'Add Event';

  @override
  String get eventName => 'Event Name';

  @override
  String get eventNote => 'Event Note';

  @override
  String get createEvent => 'Create Event';

  @override
  String get editEvent => 'Edit Event';

  @override
  String get deleteEvent => 'Delete Event';

  @override
  String get addChecklistToPool => 'Add Checklist to Pool';

  @override
  String get signOut => 'Sign Out';

  @override
  String get deleteAccount => 'Delete Account';

  @override
  String get language => 'Language';

  @override
  String get english => 'English';

  @override
  String get chinese => 'Chinese';

  @override
  String get systemDefault => 'System Default';

  @override
  String get makeRecurring => 'Make Recurring';

  @override
  String get welcomeBack => 'Welcome back';

  @override
  String get enterEmailValidation => 'Enter an email';

  @override
  String get enterPasswordValidation => 'Enter a password 6+ chars long';

  @override
  String get forgetPassword => 'Forget password ?';

  @override
  String get couldNotSignIn => 'Could not sign in';

  @override
  String get dontHaveAccount => 'Don\'t have an account ?';

  @override
  String get couldNotSignUp => 'Could not sign up';

  @override
  String get alreadyHaveAccount => 'Already have an account?';

  @override
  String get confirmDeleteAccountTitle => 'Confirm Delete Account';

  @override
  String get confirmDeleteAccountContent =>
      'Are you sure you want to delete your account? This action cannot be undone.';

  @override
  String get cancelButton => 'Cancel';

  @override
  String get deleteButton => 'Delete';

  @override
  String get repeatEvery => 'Repeat Every';

  @override
  String get days => 'Days';

  @override
  String get weeks => 'Weeks';

  @override
  String get months => 'Months';

  @override
  String get scheduledTime => 'Scheduled Time:';

  @override
  String eventChecklistAdded(Object eventName) {
    return '$eventName checklist added to pool!';
  }

  @override
  String get addChecklistItemToEvent => 'Add Checklist Item to Event';

  @override
  String get itemContent => 'Item Content';

  @override
  String get add => 'Add';

  @override
  String error(Object errorMessage) {
    return 'Error: $errorMessage';
  }

  @override
  String get noEventsYet => 'No events yet!';

  @override
  String get removeChecklistItems => 'Remove Checklist Items';

  @override
  String get doneRemovingItems => 'Done Removing Items';

  @override
  String get noneSortOption => 'None';

  @override
  String get alphabeticalSortOption => 'Alphabetical';

  @override
  String get checkedStatusSortOption => 'Checked Status';

  @override
  String get addedTimeSortOption => 'Added Time';

  @override
  String get noChecklistItemsYet => 'No checklist items yet!';
}
