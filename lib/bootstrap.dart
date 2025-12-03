import 'dart:async';
import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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

  // Isar initialization will be added in Phase 2

  runApp(
    ProviderScope(
      observers: const [ProviderLogger()],
      child: await builder(),
    ),
  );
}
