import 'package:isar/isar.dart';
import 'package:one_chore/chore_list/models/chore.dart';

part 'chore_collection.g.dart';

/// Isar collection for storing [Chore] objects.
///
/// This uses Isar code generation, but since isar_generator conflicts
/// with freezed (incompatible source_gen versions), we generate schemas
/// separately and commit the .g.dart files.
///
/// The collection stores all chore fields with proper indexing for
/// efficient queries:
/// - `id` (choreId): Unique index for fast lookups by UUID
/// - `isCompleted`: Index for filtering pending vs completed chores
/// - `createdAt`: Index for sorting by creation date
@collection
class ChoreCollection {
  /// Creates an Isar collection object from a [Chore] domain model.
  ///
  /// Use this constructor to convert a domain model to an Isar entity
  /// before persisting to the database.
  ChoreCollection.fromChore(Chore chore)
    : id = chore.id,
      title = chore.title,
      description = chore.description,
      createdAt = chore.createdAt,
      completedAt = chore.completedAt,
      isCompleted = chore.isCompleted;

  /// Isar auto-increment ID (primary key).
  Id isarId = Isar.autoIncrement;

  /// Unique chore identifier (UUID v4).
  ///
  /// Indexed with unique constraint for fast lookups and uniqueness
  /// enforcement.
  @Index(unique: true, type: IndexType.hash)
  late String id;

  /// The chore title (1-100 characters).
  late String title;

  /// Optional description (max 500 characters).
  String? description;

  /// Timestamp when the chore was created.
  ///
  /// Indexed for efficient sorting by creation date.
  @Index()
  late DateTime createdAt;

  /// Timestamp when marked complete (null if not completed).
  DateTime? completedAt;

  /// Whether the chore has been completed.
  ///
  /// Indexed for efficient filtering of pending vs completed chores.
  @Index()
  late bool isCompleted;

  /// Converts the Isar collection object to a [Chore] domain model.
  Chore toChore() {
    return Chore(
      id: id,
      title: title,
      createdAt: createdAt,
      description: description,
      completedAt: completedAt,
      isCompleted: isCompleted,
    );
  }
}
