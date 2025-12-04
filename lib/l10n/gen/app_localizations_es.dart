// dart format off
// coverage:ignore-file

// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get counterAppBarTitle => 'Contador';

  @override
  String get navToday => 'Hoy';

  @override
  String get navChores => 'Tareas';

  @override
  String get navHistory => 'Historial';

  @override
  String get navProgress => 'Progreso';

  @override
  String get navSettings => 'Ajustes';

  @override
  String get todayScreenTitle => 'Tarea de Hoy';

  @override
  String get choresScreenTitle => 'Mis Tareas';

  @override
  String get historyScreenTitle => 'Historial';

  @override
  String get progressScreenTitle => 'Progreso';

  @override
  String get settingsScreenTitle => 'Ajustes';

  @override
  String get noChoreSelectedTitle => 'Sin tarea seleccionada';

  @override
  String get noChoreSelectedMessage => 'Selecciona una tarea de tu lista para enfocarte hoy.';

  @override
  String get selectChoreAction => 'Seleccionar Tarea';

  @override
  String get noChoresTitle => 'Sin tareas aún';

  @override
  String get noChoresMessage => 'Agrega tu primera tarea para comenzar. ¡Recuerda, una a la vez!';

  @override
  String get addChoreAction => 'Agregar Tarea';

  @override
  String get noHistoryTitle => 'Sin historial aún';

  @override
  String get noHistoryMessage => '¡Completa tu primera tarea para comenzar tu racha!';

  @override
  String get noProgressTitle => 'Sin progreso aún';

  @override
  String get noProgressMessage => 'Completa algunas tareas para ver tu progreso.';

  @override
  String get settingsNotificationsSection => 'Notificaciones';

  @override
  String get settingsDailyReminder => 'Recordatorio Diario';

  @override
  String get settingsDailyReminderSubtitle => 'Recibe un recordatorio para completar tu tarea';

  @override
  String get settingsAppearanceSection => 'Apariencia';

  @override
  String get settingsTheme => 'Tema';

  @override
  String get settingsThemeDark => 'Oscuro';

  @override
  String get settingsAboutSection => 'Acerca de';

  @override
  String get settingsVersion => 'Versión';

  @override
  String get comingSoon => 'Coming soon';
}
