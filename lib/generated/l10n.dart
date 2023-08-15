// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Markdown Edit`
  String get app_name {
    return Intl.message(
      'Markdown Edit',
      name: 'app_name',
      desc: '',
      args: [],
    );
  }

  /// `File`
  String get menu_file {
    return Intl.message(
      'File',
      name: 'menu_file',
      desc: '',
      args: [],
    );
  }

  /// `New`
  String get menu_file_new {
    return Intl.message(
      'New',
      name: 'menu_file_new',
      desc: '',
      args: [],
    );
  }

  /// `Open`
  String get menu_file_open {
    return Intl.message(
      'Open',
      name: 'menu_file_open',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get menu_file_save {
    return Intl.message(
      'Save',
      name: 'menu_file_save',
      desc: '',
      args: [],
    );
  }

  /// `Save as...`
  String get menu_file_save_as {
    return Intl.message(
      'Save as...',
      name: 'menu_file_save_as',
      desc: '',
      args: [],
    );
  }

  /// `Exit`
  String get menu_file_exit {
    return Intl.message(
      'Exit',
      name: 'menu_file_exit',
      desc: '',
      args: [],
    );
  }

  /// `Create new file`
  String get file_picker_new_title {
    return Intl.message(
      'Create new file',
      name: 'file_picker_new_title',
      desc: '',
      args: [],
    );
  }

  /// `Open file`
  String get file_picker_open_title {
    return Intl.message(
      'Open file',
      name: 'file_picker_open_title',
      desc: '',
      args: [],
    );
  }

  /// `Save file`
  String get file_picker_save_as_title {
    return Intl.message(
      'Save file',
      name: 'file_picker_save_as_title',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
