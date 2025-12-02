import 'package:one_chore/app/app.dart';
import 'package:one_chore/bootstrap.dart';

Future<void> main() async {
  await bootstrap(() => const App());
}
