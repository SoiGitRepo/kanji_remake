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

  /// `Level`
  String get level {
    return Intl.message(
      'Level',
      name: 'level',
      desc: '',
      args: [],
    );
  }

  /// `JLPT`
  String get jlpt {
    return Intl.message(
      'JLPT',
      name: 'jlpt',
      desc: '',
      args: [],
    );
  }

  /// `Need Review`
  String get need_review {
    return Intl.message(
      'Need Review',
      name: 'need_review',
      desc: '',
      args: [],
    );
  }

  /// `Review Past Due`
  String get review {
    return Intl.message(
      'Review Past Due',
      name: 'review',
      desc: '',
      args: [],
    );
  }

  /// `Custom Review`
  String get custom_review {
    return Intl.message(
      'Custom Review',
      name: 'custom_review',
      desc: '',
      args: [],
    );
  }

  /// `Ready To Learn`
  String get ready_to_learn {
    return Intl.message(
      'Ready To Learn',
      name: 'ready_to_learn',
      desc: '',
      args: [],
    );
  }

  /// `Learned`
  String get learned {
    return Intl.message(
      'Learned',
      name: 'learned',
      desc: '',
      args: [],
    );
  }

  /// `Memorize This Word...`
  String get memorize_this_word {
    return Intl.message(
      'Memorize This Word...',
      name: 'memorize_this_word',
      desc: '',
      args: [],
    );
  }

  /// `Which of this is...`
  String get which_is {
    return Intl.message(
      'Which of this is...',
      name: 'which_is',
      desc: '',
      args: [],
    );
  }

  /// `Select the kanji...`
  String get select_kanji {
    return Intl.message(
      'Select the kanji...',
      name: 'select_kanji',
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
      Locale.fromSubtags(languageCode: 'zh'),
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
