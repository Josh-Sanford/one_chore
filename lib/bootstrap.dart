import 'dart:async';
import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:one_chore/core/database/database.dart';

final class ProviderLogger extends ProviderObserver {
  const ProviderLogger();

  @override
  void didUpdateProvider(
    ProviderObserverContext context,
    Object? previousValue,
    Object? newValue,
  ) {
    log('Provider updated: ${context.provider.runtimeType}');
  }

  @override
  void providerDidFail(
    ProviderObserverContext context,
    Object error,
    StackTrace stackTrace,
  ) {
    log(
      'Provider failed: ${context.provider.runtimeType}',
      error: error,
      stackTrace: stackTrace,
    );
  }
}

Future<void> bootstrap(FutureOr<Widget> Function() builder) async {
  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  // Initialize Isar database before running the app
  try {
    await IsarDatabase.initialize();
    log('Isar database initialized successfully');
  } catch (error, stackTrace) {
    log(
      'Failed to initialize Isar database',
      error: error,
      stackTrace: stackTrace,
    );
    // Rethrow to prevent app from starting with broken database
    rethrow;
  }

  runApp(
    ProviderScope(
      observers: const [ProviderLogger()],
      child: await builder(),
    ),
  );
}
