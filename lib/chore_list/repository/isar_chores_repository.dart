import 'package:isar/isar.dart';
import 'package:one_chore/chore_list/models/chore.dart';
import 'package:one_chore/chore_list/models/chore_collection.dart';
import 'package:one_chore/chore_list/repository/chores_repository.dart';

/// Isar-based implementation of [ChoresRepository].
///
/// This implementation uses Isar for local persistence with reactive queries.
/// All write operations are wrapped in transactions for data consistency.
///
/// Note: This implementation uses manual Isar schemas (no code generation)
/// due to dependency conflicts with riverpod_generator. As a result, we use
/// the generic filter API instead of generated query methods.
///
/// Example usage:
/// ```dart
/// final isar = ref.read(isarProvider);
/// final repository = IsarChoresRepository(isar);
///
/// // Watch pending chores reactively
/// repository.watchPendingChores().listen((chores) {
///   print('${chores.length} pending chores');
/// });
///
/// // Add a new chore
/// await repository.addChore(newChore);
/// ```
class IsarChoresRepository implements ChoresRepository {
  /// Creates an [IsarChoresRepository] with the given Isar instance.
  IsarChoresRepository(this._isar);

  final Isar _isar;

  @override
  Stream<List<Chore>> watchPendingChores() {
    // Watch all chores and filter in-memory
    // Note: We can't use generated query methods with manual schemas
    return _isar.choreCollections.where().watch(fireImmediately: true).map((
      List<ChoreCollection> collections,
    ) {
      // Filter pending chores and sort by createdAt descending
      final pending = collections.where((c) => !c.isCompleted).toList()
        ..sort((a, b) => b.createdAt.compareTo(a.createdAt));

      return pending.map((c) => c.toChore()).toList();
    });
  }

  @override
  Stream<List<Chore>> watchCompletedChores() {
    // Watch all chores and filter in-memory
    // Note: We can't use generated query methods with manual schemas
    return _isar.choreCollections.where().watch(fireImmediately: true).map((
      List<ChoreCollection> collections,
    ) {
      // Filter completed chores and sort by completedAt descending
      final completed = collections.where((c) => c.isCompleted).toList()
        ..sort((a, b) {
          if (a.completedAt == null && b.completedAt == null) return 0;
          if (a.completedAt == null) return 1;
          if (b.completedAt == null) return -1;
          return b.completedAt!.compareTo(a.completedAt!);
        });

      return completed.map((c) => c.toChore()).toList();
    });
  }

  @override
  Future<Chore?> getChoreById(String id) async {
    // Get all chores and find the one with matching id
    // Note: We can't use generated query methods with manual schemas
    final allChores = await _isar.choreCollections.where().findAll();
    final collection = allChores.where((c) => c.id == id).firstOrNull;

    return collection?.toChore();
  }

  @override
  Future<void> addChore(Chore chore) async {
    await _isar.writeTxn(() async {
      final collection = ChoreCollection.fromChore(chore);
      await _isar.choreCollections.put(collection);
    });
  }

  @override
  Future<void> updateChore(Chore chore) async {
    await _isar.writeTxn(() async {
      // Find existing collection by id (not isarId)
      final allChores = await _isar.choreCollections.where().findAll();
      final existing = allChores.where((c) => c.id == chore.id).firstOrNull;

      if (existing == null) {
        // If not found, treat as add
        final collection = ChoreCollection.fromChore(chore);
        await _isar.choreCollections.put(collection);
      } else {
        // Update existing record, preserving isarId
        final collection = ChoreCollection.fromChore(chore)
          ..isarId = existing.isarId;
        await _isar.choreCollections.put(collection);
      }
    });
  }

  @override
  Future<void> deleteChore(String id) async {
    await _isar.writeTxn(() async {
      // Find the collection by id (not isarId)
      final allChores = await _isar.choreCollections.where().findAll();
      final collection = allChores.where((c) => c.id == id).firstOrNull;

      if (collection != null) {
        await _isar.choreCollections.delete(collection.isarId);
      }
    });
  }

  @override
  Future<void> markChoreComplete(String id) async {
    await _isar.writeTxn(() async {
      final allChores = await _isar.choreCollections.where().findAll();
      final collection = allChores.where((c) => c.id == id).firstOrNull;

      if (collection == null) {
        throw StateError('Chore not found with id: $id');
      }

      // Mark as complete with current timestamp
      collection
        ..isCompleted = true
        ..completedAt = DateTime.now();

      await _isar.choreCollections.put(collection);
    });
  }

  @override
  Future<void> unmarkChoreComplete(String id) async {
    await _isar.writeTxn(() async {
      final allChores = await _isar.choreCollections.where().findAll();
      final collection = allChores.where((c) => c.id == id).firstOrNull;

      if (collection == null) {
        throw StateError('Chore not found with id: $id');
      }

      // Unmark as complete, clear completion timestamp
      collection
        ..isCompleted = false
        ..completedAt = null;

      await _isar.choreCollections.put(collection);
    });
  }
}
