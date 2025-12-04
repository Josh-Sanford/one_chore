import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:one_chore/settings/providers/app_version_provider.dart';

void main() {
  // Set up method channel mocking for package_info_plus
  TestWidgetsFlutterBinding.ensureInitialized();

  const channel = MethodChannel('dev.fluttercommunity.plus/package_info');

  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, (MethodCall methodCall) async {
      if (methodCall.method == 'getAll') {
        return <String, dynamic>{
          'appName': 'one_chore',
          'packageName': 'com.example.one_chore',
          'version': '1.0.0',
          'buildNumber': '1',
        };
      }
      return null;
    });
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, null);
  });

  group('appVersionProvider', () {
    test('returns version string', () async {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      // Wait for the future to complete
      final version = await container.read(appVersionProvider.future);

      // The version should be a non-empty string
      expect(version, isNotEmpty);
      expect(version, isA<String>());
    });

    test('version matches expected format', () async {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final version = await container.read(appVersionProvider.future);

      // Version should follow semantic versioning pattern (e.g., "1.0.0")
      final versionPattern = RegExp(r'^\d+\.\d+\.\d+$');
      expect(versionPattern.hasMatch(version), isTrue);
    });

    test('can be overridden for testing', () async {
      final container = ProviderContainer(
        overrides: [
          appVersionProvider.overrideWith((_) async => '9.9.9'),
        ],
      );
      addTearDown(container.dispose);

      final version = await container.read(appVersionProvider.future);

      expect(version, '9.9.9');
    });
  });
}
