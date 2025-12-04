import 'package:isar/isar.dart';
import 'package:one_chore/core/database/database.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'isar_provider.g.dart';

/// Provider for accessing the Isar database instance.
///
/// This provider returns the singleton Isar instance that was initialized
/// in bootstrap.dart. Use this provider in repositories and other providers
/// that need database access.
///
/// Example:
/// ```dart
/// @riverpod
/// class ChoresRepository extends _$ChoresRepository {
///   @override
///   Future<void> build() async {}
///
///   Future<void> addChore(Chore chore) async {
///     final isar = ref.read(isarProvider);
///     await isar.writeTxn(() async {
///       await isar.choreCollections.put(ChoreCollection.fromChore(chore));
///     });
///   }
/// }
/// ```
@Riverpod(keepAlive: true)
Isar isar(Ref ref) {
  return IsarDatabase.instance;
}
