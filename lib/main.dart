import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:mdedit/app/app.dart';
import 'package:mdedit/dependencies.dart';
import 'package:mdedit/generated/l10n.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await S.load(const Locale.fromSubtags(languageCode: 'en'));
  registerDependencies();

  final App app = await GetIt.I.getAsync();
  runApp(app);
}
