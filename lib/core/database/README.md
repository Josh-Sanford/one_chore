# Isar Database Setup

This directory contains the Isar database initialization and provider for the OneChore app.

## Files

- `database.dart` - Singleton wrapper for Isar instance initialization
- `isar_provider.dart` - Riverpod provider for accessing Isar instance
- `isar_provider.g.dart` - Generated provider code (via riverpod_generator)

## Manual Schema Generation

**Important:** This project uses **manual schema generation** for Isar collections due to dependency conflicts.

### Why Manual Schemas?

The `isar_generator` package depends on `source_gen ^1.x`, while `freezed`, `riverpod_generator`, and `riverpod_lint` all depend on `source_gen ^3.x` or `^4.x`. These versions are incompatible and cannot coexist in the same project.

### Approach

1. **Collection classes** (like `ChoreCollection`) are written manually with `@collection` and `@Index()` annotations
2. **Schema files** (`.g.dart`) are created manually based on Isar 3.x schema format
3. **Schema files are committed** to the repository (not ignored in `.gitignore`)
4. When adding new collections or modifying existing ones, the `.g.dart` schema file must be updated manually

### Adding a New Isar Collection

If you need to add a new Isar collection:

1. Create the collection class (e.g., `daily_chore_collection.dart`)
2. Add the `@collection` annotation and define fields with appropriate indexes
3. Add `part 'daily_chore_collection.g.dart';` directive
4. Manually create the `.g.dart` schema file using the pattern from `chore_collection.g.dart`
5. Register the schema in `database.dart` by adding it to the `Isar.open()` schemas list

### Schema File Template

See `lib/chore_list/models/chore_collection.g.dart` for the manual schema template. Key components:

- `CollectionSchema` constant with properties, indexes, and metadata
- Serialization/deserialization functions
- Query extensions for type-safe querying

## Usage

### Initialization

The Isar database is initialized in `lib/bootstrap.dart` before the app starts:

```dart
await IsarDatabase.initialize();
```

This must complete successfully before the app can run.

### Accessing Isar in Repositories

Use the `isarProvider` to access the Isar instance in your repositories:

```dart
@riverpod
class ChoresRepository extends _$ChoresRepository {
  @override
  Future<void> build() async {}

  Future<void> addChore(Chore chore) async {
    final isar = ref.read(isarProvider);
    await isar.writeTxn(() async {
      await isar.choreCollections.put(ChoreCollection.fromChore(chore));
    });
  }
}
```

### Direct Access

For non-Riverpod code, you can access the Isar instance directly:

```dart
final isar = IsarDatabase.instance;
```

## Testing

For tests, you can create in-memory Isar instances:

```dart
setUp(() async {
  final isar = await Isar.open(
    [ChoreCollectionSchema],
    directory: '', // Empty = in-memory
    name: 'test_${DateTime.now().millisecondsSinceEpoch}',
  );
});
```

## Troubleshooting

### Build Runner Conflicts

If you encounter build runner issues:

1. Ensure `isar_generator` is **NOT** in `pubspec.yaml` dev_dependencies
2. Make sure all `.g.dart` schema files are present and not in `.gitignore`
3. Run `dart run build_runner clean` then `dart run build_runner build --delete-conflicting-outputs`

### Schema Validation Errors

If you get schema validation errors at runtime:

1. Ensure the schema ID in the `.g.dart` file matches the collection structure
2. Verify all indexed fields are properly defined in both the class and schema
3. Check that property IDs are sequential and match the schema definition
