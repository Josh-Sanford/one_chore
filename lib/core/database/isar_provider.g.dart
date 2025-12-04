// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file

part of 'isar_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
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

@ProviderFor(isar)
const isarProvider = IsarProvider._();

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

final class IsarProvider extends $FunctionalProvider<Isar, Isar, Isar>
    with $Provider<Isar> {
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
  const IsarProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'isarProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$isarHash();

  @$internal
  @override
  $ProviderElement<Isar> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  Isar create(Ref ref) {
    return isar(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Isar value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Isar>(value),
    );
  }
}

String _$isarHash() => r'bbc902779f9149e6294552f14a7c3314499f4357';
