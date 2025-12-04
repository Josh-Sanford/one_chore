import 'package:flutter_test/flutter_test.dart';
import 'package:one_chore/chore_list/models/chore.dart';
import 'package:one_chore/chore_list/models/chore_collection.dart';

void main() {
  group('Chore', () {
    group('constructor', () {
      test('creates chore with required fields', () {
        final now = DateTime.now();
        final chore = Chore(
          id: 'test-id-1',
          title: 'Test Chore',
          createdAt: now,
        );

        expect(chore.id, 'test-id-1');
        expect(chore.title, 'Test Chore');
        expect(chore.createdAt, now);
      });

      test('sets default value for isCompleted to false', () {
        final chore = Chore(
          id: 'test-id-1',
          title: 'Test Chore',
          createdAt: DateTime.now(),
        );

        expect(chore.isCompleted, false);
      });

      test('handles optional description field', () {
        final chore = Chore(
          id: 'test-id-1',
          title: 'Test Chore',
          createdAt: DateTime.now(),
          description: 'This is a description',
        );

        expect(chore.description, 'This is a description');
      });

      test('handles null description field', () {
        final chore = Chore(
          id: 'test-id-1',
          title: 'Test Chore',
          createdAt: DateTime.now(),
        );

        expect(chore.description, isNull);
      });

      test('handles optional completedAt field', () {
        final now = DateTime.now();
        final completedTime = now.add(const Duration(hours: 1));
        final chore = Chore(
          id: 'test-id-1',
          title: 'Test Chore',
          createdAt: now,
          completedAt: completedTime,
        );

        expect(chore.completedAt, completedTime);
      });

      test('handles null completedAt field', () {
        final chore = Chore(
          id: 'test-id-1',
          title: 'Test Chore',
          createdAt: DateTime.now(),
        );

        expect(chore.completedAt, isNull);
      });

      test('accepts custom isCompleted value', () {
        final chore = Chore(
          id: 'test-id-1',
          title: 'Test Chore',
          createdAt: DateTime.now(),
          isCompleted: true,
        );

        expect(chore.isCompleted, true);
      });
    });

    group('copyWith', () {
      test('creates new instance with updated id', () {
        final original = Chore(
          id: 'original-id',
          title: 'Original Title',
          createdAt: DateTime.now(),
        );

        final updated = original.copyWith(id: 'new-id');

        expect(updated.id, 'new-id');
        expect(updated.title, 'Original Title');
        expect(original.id, 'original-id'); // Original unchanged
      });

      test('creates new instance with updated title', () {
        final original = Chore(
          id: 'test-id',
          title: 'Original Title',
          createdAt: DateTime.now(),
        );

        final updated = original.copyWith(title: 'New Title');

        expect(updated.title, 'New Title');
        expect(updated.id, 'test-id');
        expect(original.title, 'Original Title'); // Original unchanged
      });

      test('creates new instance with updated createdAt', () {
        final originalTime = DateTime(2023);
        final newTime = DateTime(2024);
        final original = Chore(
          id: 'test-id',
          title: 'Test Title',
          createdAt: originalTime,
        );

        final updated = original.copyWith(createdAt: newTime);

        expect(updated.createdAt, newTime);
        expect(original.createdAt, originalTime); // Original unchanged
      });

      test('creates new instance with updated description', () {
        final original = Chore(
          id: 'test-id',
          title: 'Test Title',
          createdAt: DateTime.now(),
        );

        final updated = original.copyWith(description: 'New description');

        expect(updated.description, 'New description');
        expect(original.description, isNull); // Original unchanged
      });

      test('creates new instance with updated completedAt', () {
        final now = DateTime.now();
        final completedTime = now.add(const Duration(hours: 1));
        final original = Chore(
          id: 'test-id',
          title: 'Test Title',
          createdAt: now,
        );

        final updated = original.copyWith(completedAt: completedTime);

        expect(updated.completedAt, completedTime);
        expect(original.completedAt, isNull); // Original unchanged
      });

      test('creates new instance with updated isCompleted', () {
        final original = Chore(
          id: 'test-id',
          title: 'Test Title',
          createdAt: DateTime.now(),
        );

        final updated = original.copyWith(isCompleted: true);

        expect(updated.isCompleted, true);
        expect(original.isCompleted, false); // Original unchanged
      });

      test('creates new instance with multiple updated fields', () {
        final originalTime = DateTime(2023);
        final completedTime = DateTime(2023, 1, 2);
        final original = Chore(
          id: 'original-id',
          title: 'Original Title',
          createdAt: originalTime,
        );

        final updated = original.copyWith(
          title: 'Updated Title',
          description: 'Added description',
          completedAt: completedTime,
          isCompleted: true,
        );

        expect(updated.id, 'original-id'); // Unchanged field preserved
        expect(updated.title, 'Updated Title');
        expect(updated.description, 'Added description');
        expect(updated.completedAt, completedTime);
        expect(updated.isCompleted, true);
      });
    });

    group('equality', () {
      test('two chores with same values are equal', () {
        final now = DateTime(2023);
        final chore1 = Chore(
          id: 'test-id',
          title: 'Test Chore',
          createdAt: now,
          description: 'Description',
        );
        final chore2 = Chore(
          id: 'test-id',
          title: 'Test Chore',
          createdAt: now,
          description: 'Description',
        );

        expect(chore1, equals(chore2));
      });

      test('two chores with different ids are not equal', () {
        final now = DateTime.now();
        final chore1 = Chore(
          id: 'test-id-1',
          title: 'Test Chore',
          createdAt: now,
        );
        final chore2 = Chore(
          id: 'test-id-2',
          title: 'Test Chore',
          createdAt: now,
        );

        expect(chore1, isNot(equals(chore2)));
      });

      test('two chores with different titles are not equal', () {
        final now = DateTime.now();
        final chore1 = Chore(
          id: 'test-id',
          title: 'Chore 1',
          createdAt: now,
        );
        final chore2 = Chore(
          id: 'test-id',
          title: 'Chore 2',
          createdAt: now,
        );

        expect(chore1, isNot(equals(chore2)));
      });

      test('two chores with different completedAt are not equal', () {
        final now = DateTime.now();
        final chore1 = Chore(
          id: 'test-id',
          title: 'Test Chore',
          createdAt: now,
          completedAt: now,
        );
        final chore2 = Chore(
          id: 'test-id',
          title: 'Test Chore',
          createdAt: now,
          completedAt: now.add(const Duration(hours: 1)),
        );

        expect(chore1, isNot(equals(chore2)));
      });

      test('chore with null completedAt is not equal to chore with completedAt',
          () {
        final now = DateTime.now();
        final chore1 = Chore(
          id: 'test-id',
          title: 'Test Chore',
          createdAt: now,
        );
        final chore2 = Chore(
          id: 'test-id',
          title: 'Test Chore',
          createdAt: now,
          completedAt: now,
        );

        expect(chore1, isNot(equals(chore2)));
      });
    });

    group('hashCode', () {
      test('same chores have same hashCode', () {
        final now = DateTime(2023);
        final chore1 = Chore(
          id: 'test-id',
          title: 'Test Chore',
          createdAt: now,
          description: 'Description',
          isCompleted: true,
        );
        final chore2 = Chore(
          id: 'test-id',
          title: 'Test Chore',
          createdAt: now,
          description: 'Description',
          isCompleted: true,
        );

        expect(chore1.hashCode, equals(chore2.hashCode));
      });

      test('different chores have different hashCode', () {
        final now = DateTime.now();
        final chore1 = Chore(
          id: 'test-id-1',
          title: 'Test Chore',
          createdAt: now,
        );
        final chore2 = Chore(
          id: 'test-id-2',
          title: 'Test Chore',
          createdAt: now,
        );

        expect(chore1.hashCode, isNot(equals(chore2.hashCode)));
      });
    });

    group('JSON serialization', () {
      test('fromJson creates chore from JSON map with all fields', () {
        final json = <String, dynamic>{
          'id': 'test-id',
          'title': 'Test Chore',
          'createdAt': '2023-01-01T12:00:00.000Z',
          'description': 'Test description',
          'completedAt': '2023-01-02T12:00:00.000Z',
          'isCompleted': true,
        };

        final chore = Chore.fromJson(json);

        expect(chore.id, 'test-id');
        expect(chore.title, 'Test Chore');
        expect(chore.createdAt, DateTime.parse('2023-01-01T12:00:00.000Z'));
        expect(chore.description, 'Test description');
        expect(chore.completedAt, DateTime.parse('2023-01-02T12:00:00.000Z'));
        expect(chore.isCompleted, true);
      });

      test('fromJson creates chore from JSON map without optional fields', () {
        final json = <String, dynamic>{
          'id': 'test-id',
          'title': 'Test Chore',
          'createdAt': '2023-01-01T12:00:00.000Z',
        };

        final chore = Chore.fromJson(json);

        expect(chore.id, 'test-id');
        expect(chore.title, 'Test Chore');
        expect(chore.createdAt, DateTime.parse('2023-01-01T12:00:00.000Z'));
        expect(chore.description, isNull);
        expect(chore.completedAt, isNull);
        expect(chore.isCompleted, false);
      });

      test('fromJson handles null optional fields explicitly', () {
        final json = <String, dynamic>{
          'id': 'test-id',
          'title': 'Test Chore',
          'createdAt': '2023-01-01T12:00:00.000Z',
          'description': null,
          'completedAt': null,
        };

        final chore = Chore.fromJson(json);

        expect(chore.description, isNull);
        expect(chore.completedAt, isNull);
      });

      test('toJson creates correct JSON map with all fields', () {
        final chore = Chore(
          id: 'test-id',
          title: 'Test Chore',
          createdAt: DateTime.parse('2023-01-01T12:00:00.000Z'),
          description: 'Test description',
          completedAt: DateTime.parse('2023-01-02T12:00:00.000Z'),
          isCompleted: true,
        );

        final json = chore.toJson();

        expect(json['id'], 'test-id');
        expect(json['title'], 'Test Chore');
        expect(json['createdAt'], '2023-01-01T12:00:00.000Z');
        expect(json['description'], 'Test description');
        expect(json['completedAt'], '2023-01-02T12:00:00.000Z');
        expect(json['isCompleted'], true);
      });

      test('toJson creates correct JSON map without optional fields', () {
        final chore = Chore(
          id: 'test-id',
          title: 'Test Chore',
          createdAt: DateTime.parse('2023-01-01T12:00:00.000Z'),
        );

        final json = chore.toJson();

        expect(json['id'], 'test-id');
        expect(json['title'], 'Test Chore');
        expect(json['createdAt'], '2023-01-01T12:00:00.000Z');
        expect(json['description'], isNull);
        expect(json['completedAt'], isNull);
        expect(json['isCompleted'], false);
      });

      test('JSON round-trip returns equal object', () {
        final original = Chore(
          id: 'test-id',
          title: 'Test Chore',
          createdAt: DateTime.parse('2023-01-01T12:00:00.000Z'),
          description: 'Test description',
          completedAt: DateTime.parse('2023-01-02T12:00:00.000Z'),
          isCompleted: true,
        );

        final json = original.toJson();
        final restored = Chore.fromJson(json);

        expect(restored, equals(original));
      });

      test('JSON round-trip with null optional fields returns equal object',
          () {
        final original = Chore(
          id: 'test-id',
          title: 'Test Chore',
          createdAt: DateTime.parse('2023-01-01T12:00:00.000Z'),
        );

        final json = original.toJson();
        final restored = Chore.fromJson(json);

        expect(restored, equals(original));
      });
    });
  });

  group('ChoreCollection', () {
    group('fromChore constructor', () {
      test('correctly copies all required fields from Chore', () {
        final now = DateTime.now();
        final chore = Chore(
          id: 'test-id',
          title: 'Test Chore',
          createdAt: now,
        );

        final collection = ChoreCollection.fromChore(chore);

        expect(collection.id, 'test-id');
        expect(collection.title, 'Test Chore');
        expect(collection.createdAt, now);
        expect(collection.isCompleted, false);
      });

      test('correctly copies optional description field', () {
        final chore = Chore(
          id: 'test-id',
          title: 'Test Chore',
          createdAt: DateTime.now(),
          description: 'Test description',
        );

        final collection = ChoreCollection.fromChore(chore);

        expect(collection.description, 'Test description');
      });

      test('correctly handles null description field', () {
        final chore = Chore(
          id: 'test-id',
          title: 'Test Chore',
          createdAt: DateTime.now(),
        );

        final collection = ChoreCollection.fromChore(chore);

        expect(collection.description, isNull);
      });

      test('correctly copies optional completedAt field', () {
        final now = DateTime.now();
        final completedTime = now.add(const Duration(hours: 1));
        final chore = Chore(
          id: 'test-id',
          title: 'Test Chore',
          createdAt: now,
          completedAt: completedTime,
        );

        final collection = ChoreCollection.fromChore(chore);

        expect(collection.completedAt, completedTime);
      });

      test('correctly handles null completedAt field', () {
        final chore = Chore(
          id: 'test-id',
          title: 'Test Chore',
          createdAt: DateTime.now(),
        );

        final collection = ChoreCollection.fromChore(chore);

        expect(collection.completedAt, isNull);
      });

      test('correctly copies isCompleted field when true', () {
        final chore = Chore(
          id: 'test-id',
          title: 'Test Chore',
          createdAt: DateTime.now(),
          isCompleted: true,
        );

        final collection = ChoreCollection.fromChore(chore);

        expect(collection.isCompleted, true);
      });

      test('correctly copies all fields including optional ones', () {
        final now = DateTime(2023);
        final completedTime = DateTime(2023, 1, 2);
        final chore = Chore(
          id: 'test-id-123',
          title: 'Complete Test Chore',
          createdAt: now,
          description: 'Full description here',
          completedAt: completedTime,
          isCompleted: true,
        );

        final collection = ChoreCollection.fromChore(chore);

        expect(collection.id, 'test-id-123');
        expect(collection.title, 'Complete Test Chore');
        expect(collection.createdAt, now);
        expect(collection.description, 'Full description here');
        expect(collection.completedAt, completedTime);
        expect(collection.isCompleted, true);
      });

      test('initializes isarId with Isar.autoIncrement', () {
        final chore = Chore(
          id: 'test-id',
          title: 'Test Chore',
          createdAt: DateTime.now(),
        );

        final collection = ChoreCollection.fromChore(chore);

        // Isar.autoIncrement is a special value used by Isar
        expect(collection.isarId, isNotNull);
      });
    });

    group('toChore method', () {
      test('correctly creates Chore with all required fields', () {
        final now = DateTime.now();
        final chore = Chore(
          id: 'test-id',
          title: 'Test Chore',
          createdAt: now,
        );
        final collection = ChoreCollection.fromChore(chore);

        final convertedChore = collection.toChore();

        expect(convertedChore.id, 'test-id');
        expect(convertedChore.title, 'Test Chore');
        expect(convertedChore.createdAt, now);
        expect(convertedChore.isCompleted, false);
      });

      test('correctly creates Chore with optional description', () {
        final chore = Chore(
          id: 'test-id',
          title: 'Test Chore',
          createdAt: DateTime.now(),
          description: 'Test description',
        );
        final collection = ChoreCollection.fromChore(chore);

        final convertedChore = collection.toChore();

        expect(convertedChore.description, 'Test description');
      });

      test('correctly handles null description', () {
        final chore = Chore(
          id: 'test-id',
          title: 'Test Chore',
          createdAt: DateTime.now(),
        );
        final collection = ChoreCollection.fromChore(chore);

        final convertedChore = collection.toChore();

        expect(convertedChore.description, isNull);
      });

      test('correctly creates Chore with optional completedAt', () {
        final now = DateTime.now();
        final completedTime = now.add(const Duration(hours: 1));
        final chore = Chore(
          id: 'test-id',
          title: 'Test Chore',
          createdAt: now,
          completedAt: completedTime,
        );
        final collection = ChoreCollection.fromChore(chore);

        final convertedChore = collection.toChore();

        expect(convertedChore.completedAt, completedTime);
      });

      test('correctly handles null completedAt', () {
        final chore = Chore(
          id: 'test-id',
          title: 'Test Chore',
          createdAt: DateTime.now(),
        );
        final collection = ChoreCollection.fromChore(chore);

        final convertedChore = collection.toChore();

        expect(convertedChore.completedAt, isNull);
      });

      test('correctly creates Chore with isCompleted true', () {
        final chore = Chore(
          id: 'test-id',
          title: 'Test Chore',
          createdAt: DateTime.now(),
          isCompleted: true,
        );
        final collection = ChoreCollection.fromChore(chore);

        final convertedChore = collection.toChore();

        expect(convertedChore.isCompleted, true);
      });

      test('correctly creates Chore with all fields including optional ones',
          () {
        final now = DateTime(2023);
        final completedTime = DateTime(2023, 1, 2);
        final chore = Chore(
          id: 'test-id-456',
          title: 'Full Test Chore',
          createdAt: now,
          description: 'Complete description',
          completedAt: completedTime,
          isCompleted: true,
        );
        final collection = ChoreCollection.fromChore(chore);

        final convertedChore = collection.toChore();

        expect(convertedChore.id, 'test-id-456');
        expect(convertedChore.title, 'Full Test Chore');
        expect(convertedChore.createdAt, now);
        expect(convertedChore.description, 'Complete description');
        expect(convertedChore.completedAt, completedTime);
        expect(convertedChore.isCompleted, true);
      });
    });

    group('round-trip conversion', () {
      test('fromChore then toChore returns equal Chore', () {
        final original = Chore(
          id: 'test-id',
          title: 'Test Chore',
          createdAt: DateTime.parse('2023-01-01T12:00:00.000Z'),
          description: 'Test description',
          completedAt: DateTime.parse('2023-01-02T12:00:00.000Z'),
          isCompleted: true,
        );

        final collection = ChoreCollection.fromChore(original);
        final restored = collection.toChore();

        expect(restored, equals(original));
      });

      test('round-trip with null optional fields returns equal Chore', () {
        final original = Chore(
          id: 'test-id',
          title: 'Test Chore',
          createdAt: DateTime.parse('2023-01-01T12:00:00.000Z'),
        );

        final collection = ChoreCollection.fromChore(original);
        final restored = collection.toChore();

        expect(restored, equals(original));
      });

      test('round-trip with only description returns equal Chore', () {
        final original = Chore(
          id: 'test-id',
          title: 'Test Chore',
          createdAt: DateTime.parse('2023-01-01T12:00:00.000Z'),
          description: 'Only description, no completedAt',
        );

        final collection = ChoreCollection.fromChore(original);
        final restored = collection.toChore();

        expect(restored, equals(original));
      });

      test('round-trip with only completedAt returns equal Chore', () {
        final original = Chore(
          id: 'test-id',
          title: 'Test Chore',
          createdAt: DateTime.parse('2023-01-01T12:00:00.000Z'),
          completedAt: DateTime.parse('2023-01-02T12:00:00.000Z'),
          isCompleted: true,
        );

        final collection = ChoreCollection.fromChore(original);
        final restored = collection.toChore();

        expect(restored, equals(original));
      });

      test('multiple round-trips maintain equality', () {
        final original = Chore(
          id: 'test-id',
          title: 'Test Chore',
          createdAt: DateTime.parse('2023-01-01T12:00:00.000Z'),
          description: 'Test description',
        );

        final collection1 = ChoreCollection.fromChore(original);
        final restored1 = collection1.toChore();
        final collection2 = ChoreCollection.fromChore(restored1);
        final restored2 = collection2.toChore();

        expect(restored2, equals(original));
        expect(restored2, equals(restored1));
      });
    });
  });
}
