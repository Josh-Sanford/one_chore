// dart format off
// coverage:ignore-file

// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get counterAppBarTitle => 'Counter';

  @override
  String get navToday => 'Today';

  @override
  String get navChores => 'Chores';

  @override
  String get navHistory => 'History';

  @override
  String get navProgress => 'Progress';

  @override
  String get navSettings => 'Settings';

  @override
  String get todayScreenTitle => 'Today\'s Chore';

  @override
  String get choresScreenTitle => 'My Chores';

  @override
  String get historyScreenTitle => 'History';

  @override
  String get progressScreenTitle => 'Progress';

  @override
  String get settingsScreenTitle => 'Settings';

  @override
  String get noChoreSelectedTitle => 'No chore selected';

  @override
  String get noChoreSelectedMessage => 'Select a chore from your list to focus on today.';

  @override
  String get selectChoreAction => 'Select a Chore';

  @override
  String get noChoresTitle => 'No chores yet';

  @override
  String get noChoresMessage => 'Add your first chore to get started. Remember, just one at a time!';

  @override
  String get addChoreAction => 'Add a Chore';

  @override
  String get noHistoryTitle => 'No history yet';

  @override
  String get noHistoryMessage => 'Complete your first chore to start building your streak!';

  @override
  String get noProgressTitle => 'No progress yet';

  @override
  String get noProgressMessage => 'Complete some chores to see your progress over time.';

  @override
  String get settingsNotificationsSection => 'Notifications';

  @override
  String get settingsDailyReminder => 'Daily Reminder';

  @override
  String get settingsAppearanceSection => 'Appearance';

  @override
  String get settingsTheme => 'Theme';

  @override
  String get settingsAboutSection => 'About';

  @override
  String get settingsVersion => 'Version';

  @override
  String get comingSoon => 'Coming soon';
}
