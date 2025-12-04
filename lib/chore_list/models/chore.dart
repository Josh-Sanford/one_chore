import 'package:freezed_annotation/freezed_annotation.dart';

part 'chore.freezed.dart';
part 'chore.g.dart';

/// Represents a chore/task in the OneChore app.
///
/// A chore is a single task that the user needs to complete. It includes
/// a title, optional description, creation timestamp, and completion status.
///
/// Fields:
/// - [id]: Unique identifier (UUID v4)
/// - [title]: The chore title (1-100 characters)
/// - [createdAt]: Timestamp when the chore was created
/// - [description]: Optional description (max 500 characters)
/// - [completedAt]: Timestamp when marked complete (null if not completed)
/// - [isCompleted]: Whether the chore has been marked as complete
@freezed
abstract class Chore with _$Chore {
  factory Chore({
    required String id,
    required String title,
    required DateTime createdAt,
    String? description,
    DateTime? completedAt,
    @Default(false) bool isCompleted,
  }) = _Chore;

  /// Creates a Chore from JSON.
  factory Chore.fromJson(Map<String, dynamic> json) => _$ChoreFromJson(json);
}
