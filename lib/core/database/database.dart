// coverage:ignore-file
// This file contains platform-specific initialization code that requires
// native libraries (Isar, path_provider) which are not available in the
// Dart VM test environment. See test/core/database/database_test.dart for
// tests covering the error handling and lifecycle management.

import 'package:isar/isar.dart';
import 'package:one_chore/chore_list/models/chore_collection.dart';
import 'package:path_provider/path_provider.dart';

/// Global singleton for accessing the Isar database instance.
///
/// This class provides a simple way to initialize and access the Isar
/// database throughout the app. It must be initialized in bootstrap.dart
/// before the app starts.
///
/// Usage:
/// ```dart
/// // Initialize in bootstrap.dart
/// await IsarDatabase.initialize();
///
/// // Access in providers/repositories
/// final isar = IsarDatabase.instance;
/// ```
class IsarDatabase {
  IsarDatabase._();

  static Isar? _instance;

  /// Returns the initialized Isar instance.
  ///
  /// Throws [StateError] if the database hasn't been initialized yet.
  /// Always call [initialize] in bootstrap.dart before accessing this.
  static Isar get instance {
    if (_instance == null) {
      throw StateError(
        'IsarDatabase has not been initialized. '
        'Call IsarDatabase.initialize() in bootstrap.dart before using.',
      );
    }
    return _instance!;
  }

  /// Initializes the Isar database with all required schemas.
  ///
  /// This must be called once in bootstrap.dart before the app starts.
  /// Uses `path_provider` to get the application documents directory for
  /// persistent storage on iOS/Android.
  ///
  /// Throws [IsarError] if initialization fails.
  static Future<void> initialize() async {
    if (_instance != null) {
      // Already initialized, skip
      return;
    }

    try {
      // Get the application documents directory for persistent storage
      final dir = await getApplicationDocumentsDirectory();

      // Open Isar with all collection schemas
      _instance = await Isar.open(
        [ChoreCollectionSchema],
        directory: dir.path,
        name: 'one_chore_db',
      );
    } catch (e) {
      throw IsarError('Failed to initialize Isar database: $e');
    }
  }

  /// Closes the database and clears the instance.
  ///
  /// Only use this for testing or when shutting down the app.
  static Future<void> close() async {
    await _instance?.close();
    _instance = null;
  }
}
