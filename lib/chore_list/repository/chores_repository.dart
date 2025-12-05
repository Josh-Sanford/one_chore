import 'package:one_chore/chore_list/models/chore.dart';

/// Repository interface for managing chores in the OneChore app.
///
/// This repository provides CRUD operations for chores and reactive streams
/// for watching chore collections. Implementations should use Isar for
/// local persistence.
///
/// The repository separates pending and completed chores for efficient
/// querying and UI updates:
/// - Pending chores: `isCompleted == false`, sorted by `createdAt`
///   descending
/// - Completed chores: `isCompleted == true`, sorted by `completedAt`
///   descending
abstract class ChoresRepository {
  /// Stream of all pending (not completed) chores.
  ///
  /// Chores are sorted by creation date in descending order (newest first).
  /// The stream emits a new list whenever the underlying data changes.
  ///
  /// Use this for reactive UI updates in the chore list screen.
  Stream<List<Chore>> watchPendingChores();

  /// Stream of all completed chores.
  ///
  /// Chores are sorted by completion date in descending order (most recently
  /// completed first). The stream emits a new list whenever the underlying
  /// data changes.
  ///
  /// Use this for the history screen to show completed chores.
  Stream<List<Chore>> watchCompletedChores();

  /// Gets a single chore by its unique ID.
  ///
  /// Returns the chore if found, or `null` if no chore exists with the
  /// given [id].
  ///
  /// Example:
  /// ```dart
  /// final chore = await repository.getChoreById('uuid-123');
  /// if (chore != null) {
  ///   print('Found chore: ${chore.title}');
  /// }
  /// ```
  Future<Chore?> getChoreById(String id);

  /// Adds a new chore to the repository.
  ///
  /// The [chore] must have a unique ID. If a chore with the same ID already
  /// exists, it will be replaced (upsert behavior).
  ///
  /// Example:
  /// ```dart
  /// final chore = Chore(
  ///   id: uuid.v4(),
  ///   title: 'New chore',
  ///   createdAt: DateTime.now(),
  /// );
  /// await repository.addChore(chore);
  /// ```
  Future<void> addChore(Chore chore);

  /// Updates an existing chore.
  ///
  /// The [chore]'s ID is used to find and update the existing record.
  /// If no chore exists with that ID, this behaves like [addChore].
  ///
  /// Example:
  /// ```dart
  /// final updated = chore.copyWith(title: 'Updated title');
  /// await repository.updateChore(updated);
  /// ```
  Future<void> updateChore(Chore chore);

  /// Deletes a chore by its unique ID.
  ///
  /// If no chore exists with the given [id], this operation does nothing.
  ///
  /// Example:
  /// ```dart
  /// await repository.deleteChore('uuid-123');
  /// ```
  Future<void> deleteChore(String id);

  /// Marks a chore as complete.
  ///
  /// Sets `isCompleted` to `true` and `completedAt` to the current timestamp.
  /// Throws [StateError] if the chore is not found.
  ///
  /// Example:
  /// ```dart
  /// await repository.markChoreComplete('uuid-123');
  /// ```
  Future<void> markChoreComplete(String id);

  /// Unmarks a chore (marks it as incomplete).
  ///
  /// Sets `isCompleted` to `false` and clears `completedAt`.
  /// Throws [StateError] if the chore is not found.
  ///
  /// Example:
  /// ```dart
  /// await repository.unmarkChoreComplete('uuid-123');
  /// ```
  Future<void> unmarkChoreComplete(String id);
}
