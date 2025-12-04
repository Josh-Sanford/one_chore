# Isar Schema Generation Guide

This document explains how to work with Isar schemas in the OneChore project, which uses manual schema generation due to dependency conflicts.

## Background

The OneChore project cannot use `isar_generator` for automatic schema generation because:

- `isar_generator` depends on `source_gen ^1.x`
- `freezed`, `riverpod_generator`, and `riverpod_lint` depend on `source_gen ^3.x` or `^4.x`
- These versions are fundamentally incompatible and cannot coexist

## Solution: Manual Schema Files

We write collection classes normally with annotations, but manually create the `.g.dart` schema files instead of using code generation.

## Current Collections

1. **ChoreCollection** (`lib/chore_list/models/chore_collection.dart`)
   - Stores chore data with indexes on `id`, `createdAt`, and `isCompleted`
   - Schema: `lib/chore_list/models/chore_collection.g.dart` (manual)

## How to Add a New Collection

### Step 1: Create the Collection Class

```dart
import 'package:isar/isar.dart';
import 'package:one_chore/your_feature/models/your_model.dart';

part 'your_collection.g.dart';

@collection
class YourCollection {
  YourCollection.fromModel(YourModel model)
      : field1 = model.field1,
        field2 = model.field2;

  Id isarId = Isar.autoIncrement;

  @Index(unique: true, type: IndexType.hash)
  late String field1;

  @Index()
  late DateTime field2;

  YourModel toModel() {
    return YourModel(
      field1: field1,
      field2: field2,
    );
  }
}
```

### Step 2: Create the Manual Schema File

Create `your_collection.g.dart` based on the template in `chore_collection.g.dart`:

1. Copy `chore_collection.g.dart` as a starting point
2. Update the collection name, properties, and indexes to match your class
3. Update serialization/deserialization logic
4. Ensure property IDs are sequential (0, 1, 2, ...)
5. Add unique index IDs (generate a random negative int64)

**Key sections to update:**

```dart
const YourCollectionSchema = CollectionSchema(
  name: r'YourCollection',
  id: -1234567890123456789, // Random unique negative int64
  properties: {
    r'field1': PropertySchema(
      id: 0,
      name: r'field1',
      type: IsarType.string,
    ),
    r'field2': PropertySchema(
      id: 1,
      name: r'field2',
      type: IsarType.dateTime,
    ),
  },
  // ... rest of schema
);
```

### Step 3: Register the Schema

In `lib/core/database/database.dart`, add the new schema:

```dart
_instance = await Isar.open(
  [
    ChoreCollectionSchema,
    YourCollectionSchema, // Add here
  ],
  directory: dir.path,
  name: 'one_chore_db',
);
```

### Step 4: Verify

Run analysis to ensure everything compiles:

```bash
flutter analyze
```

## Schema Properties Reference

### Field Types

```dart
IsarType.bool
IsarType.byte
IsarType.int
IsarType.float
IsarType.long
IsarType.double
IsarType.dateTime
IsarType.string
IsarType.object
IsarType.json
IsarType.boolList
IsarType.byteList
IsarType.intList
IsarType.floatList
IsarType.longList
IsarType.doubleList
IsarType.dateTimeList
IsarType.stringList
```

### Index Types

```dart
IndexType.value // Default, allows range queries
IndexType.hash // Faster for exact matches, no range queries
IndexType.hashElements // For list fields
```

### Index Options

```dart
@Index(
  unique: true, // Enforce uniqueness
  replace: false, // Replace on conflict vs error
  type: IndexType.hash, // Index type
  caseSensitive: true, // For string indexes
)
```

## Helper Script

The `generate_isar_schemas.sh` script in the project root can theoretically generate schemas, but due to the extreme dependency conflicts, it's not reliable. **Manual creation is the recommended approach.**

## Testing Collections

For unit tests, use in-memory Isar instances:

```dart
test('my collection test', () async {
  final isar = await Isar.open(
    [YourCollectionSchema],
    directory: '', // Empty string = in-memory
    name: 'test_${DateTime.now().millisecondsSinceEpoch}',
  );

  // Test your collection operations

  await isar.close(deleteFromDisk: true);
});
```

## Troubleshooting

### "Target of URI hasn't been generated" Error

- Ensure the `.g.dart` file exists in the same directory as the collection class
- Verify the `part` directive matches the filename exactly

### "Undefined name 'YourCollectionSchema'" Error

- Check that the schema constant is defined in the `.g.dart` file
- Ensure the const is exported (not private with `_`)

### Schema Validation Errors at Runtime

- Verify property IDs are sequential starting from 0
- Check that all indexed fields are defined in the schema
- Ensure the schema ID is unique (different from other collections)
- Validate that index IDs are unique

### Build Runner Conflicts

If you accidentally add `isar_generator` to `pubspec.yaml`:

1. Remove it immediately: `flutter pub remove isar_generator`
2. Restore dependencies: `flutter pub get`
3. Clean build: `dart run build_runner clean`
4. Rebuild: `dart run build_runner build --delete-conflicting-outputs`

## Future Improvements

If the Isar team releases a version compatible with modern `source_gen` versions, we can migrate to automatic schema generation. Monitor:

- https://github.com/isar/isar/issues
- Isar changelog for `source_gen` dependency updates

Until then, manual schemas are the reliable approach.
