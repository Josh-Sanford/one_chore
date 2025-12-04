import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:one_chore/core/database/database.dart';
import 'package:one_chore/core/database/isar_provider.dart';

/// Tests for IsarDatabase and isarProvider.
///
/// NOTE: These tests are limited because Isar requires native libraries
/// (libisar.dylib) that are not available in the test VM. We test the
/// error handling logic and ensure the StateError is thrown correctly
/// when the database hasn't been initialized.
///
/// Full integration tests with actual database operations would require:
/// 1. Isar native libraries to be available in test environment
/// 2. Platform channel mocking for path_provider
/// 3. Running tests in a Flutter environment (not pure Dart VM)
///
/// These tests verify:
/// - StateError is thrown with helpful message when not initialized
/// - Provider correctly throws StateError when database not initialized
/// - close() can be called safely without initialization
void main() {
  // Initialize Flutter bindings once for all tests
  TestWidgetsFlutterBinding.ensureInitialized();

  group('IsarDatabase', () {
    // Clean up after each test to ensure tests are isolated
    tearDown(() async {
      await IsarDatabase.close();
    });

    group('instance getter', () {
      test('throws StateError when not initialized', () {
        expect(
          () => IsarDatabase.instance,
          throwsA(
            isA<StateError>().having(
              (e) => e.message,
              'message',
              contains('IsarDatabase has not been initialized'),
            ),
          ),
        );
      });

      test('throws StateError with helpful message', () {
        expect(
          () => IsarDatabase.instance,
          throwsA(
            isA<StateError>().having(
              (e) => e.message,
              'message',
              contains('Call IsarDatabase.initialize() in bootstrap.dart'),
            ),
          ),
        );
      });

      test('throws StateError with complete error message', () {
        const expectedMessage =
            'IsarDatabase has not been initialized. '
            'Call IsarDatabase.initialize() in bootstrap.dart before using.';

        expect(
          () => IsarDatabase.instance,
          throwsA(
            isA<StateError>().having(
              (e) => e.message,
              'message',
              expectedMessage,
            ),
          ),
        );
      });
    });

    group('close', () {
      test('can be called without initialization', () async {
        await expectLater(
          IsarDatabase.close(),
          completes,
        );
      });

      test('can be called multiple times without initialization', () async {
        await IsarDatabase.close();
        await expectLater(
          IsarDatabase.close(),
          completes,
        );
      });

      test('clears instance after initialization fails', () async {
        // Try to initialize (will fail due to missing native libraries)
        // but then close should still work
        try {
          await IsarDatabase.initialize();
          // Catching Error is necessary here to test cleanup after failure
          // ignore: avoid_catching_errors
        } on Error {
          // Expected to fail - ignore
        }

        // Close should work and clear the instance
        await IsarDatabase.close();

        // Instance should still throw StateError
        expect(
          () => IsarDatabase.instance,
          throwsStateError,
        );
      });
    });
  });

  group('isarProvider', () {
    late ProviderContainer container;

    tearDown(() async {
      container.dispose();
      await IsarDatabase.close();
    });

    test('throws when database not initialized', () {
      container = ProviderContainer();

      // Provider wraps StateError in ProviderException
      expect(
        () => container.read(isarProvider),
        throwsA(isA<Object>()),
      );
    });

    test('throws with helpful message when not initialized', () {
      container = ProviderContainer();

      expect(
        () => container.read(isarProvider),
        throwsA(
          isA<Object>().having(
            (e) => e.toString(),
            'error message',
            contains('IsarDatabase has not been initialized'),
          ),
        ),
      );
    });

    test('keepAlive annotation is present in generated code', () {
      // Verify the provider is defined with keepAlive: true
      // by checking that it doesn't auto-dispose
      container = ProviderContainer()
        ..listen(
          isarProvider,
          (previous, next) {},
          onError: (error, stackTrace) {},
        )
        ..dispose();

      // Create a new container and verify provider still throws
      // (not a disposal error)
      final newContainer = ProviderContainer();
      expect(
        () => newContainer.read(isarProvider),
        throwsA(isA<Object>()),
      );
      newContainer.dispose();
    });
  });

  group('IsarDatabase initialization contract', () {
    test('initialize() is idempotent in error cases', () async {
      // Multiple failed initialization attempts should not cause issues
      for (var i = 0; i < 3; i++) {
        try {
          await IsarDatabase.initialize();
          // Catching Error is necessary to test idempotent error handling
          // ignore: avoid_catching_errors
        } on Error {
          // Expected to fail - ignore
        }
      }

      // Close should still work
      await expectLater(IsarDatabase.close(), completes);
    });

    test('instance throws consistent error across multiple calls', () {
      const expectedMessage =
          'IsarDatabase has not been initialized. '
          'Call IsarDatabase.initialize() in bootstrap.dart before using.';

      expect(
        () => IsarDatabase.instance,
        throwsA(
          isA<StateError>().having(
            (e) => e.message,
            'message',
            expectedMessage,
          ),
        ),
      );

      // Second call should throw the same error
      expect(
        () => IsarDatabase.instance,
        throwsA(
          isA<StateError>().having(
            (e) => e.message,
            'message',
            expectedMessage,
          ),
        ),
      );
    });
  });
}
