import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:mdedit_api/document_manager/document_manager.dart';
import 'package:mdedit_api/generated/l10n.dart';
import 'package:mdedit_api/file_saver/file_saver_stub.dart'
if (dart.library.io) 'package:mdedit_api/file_saver/file_saver_desktop.dart'
if (dart.library.html) 'package:mdedit_api/file_saver/file_saver_web.dart';
import 'package:mdedit_api/home/home_view_model.dart';
import 'package:window_manager/window_manager.dart';

initApi() async {
  WidgetsFlutterBinding.ensureInitialized();
  await S.load(const Locale.fromSubtags(languageCode: 'en'));
  _registerDependencies();
  await _attachToWindowManager();
}

initApiWeb() async {
  WidgetsFlutterBinding.ensureInitialized();
  await S.load(const Locale.fromSubtags(languageCode: 'en'));
  _registerDependencies();
}

_registerDependencies() {
  _registerManagers();
  _registerViewModels();
}

_registerManagers() {
  final i = GetIt.I;
  i.registerSingleton(DocumentManager());
  i.registerSingleton(getFileSaver());
}

_registerViewModels() {
  final i = GetIt.I;
  i.registerFactory(() => HomeViewModel(i.get(), i.get()));
}

_attachToWindowManager() async {
  final i = GetIt.I;
  await WindowManager.instance.ensureInitialized();
  const name = "MDEdit";
  windowManager.waitUntilReadyToShow().then((_) async {
    await windowManager.setMinimumSize(const Size(500, 600));
    await windowManager.setTitle("$name - Untitled");
    await windowManager.setPreventClose(true);
    await windowManager.show();
    i
        .get<DocumentManager>()
        .docStream
        .stream
        .listen((event) async {
      final document = switch (event) {
        ContentChanged() => event.document,
        FileLoaded() => event.document,
      };
      final fileName =
          document.path
              ?.split(Platform.pathSeparator)
              .last ?? "Untitled";
      final String changedSymbol;
      if (document.hasContentChanged) {
        changedSymbol = "*";
      } else {
        changedSymbol = "";
      }
      final title = "$name - $fileName$changedSymbol";
      await windowManager.setTitle(title);
    });
  });
}