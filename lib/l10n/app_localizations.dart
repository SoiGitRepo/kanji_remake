import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_zh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('zh')
  ];

  /// No description provided for @level.
  ///
  /// In en, this message translates to:
  /// **'Level'**
  String get level;

  /// No description provided for @jlpt.
  ///
  /// In en, this message translates to:
  /// **'JLPT'**
  String get jlpt;

  /// No description provided for @need_review.
  ///
  /// In en, this message translates to:
  /// **'Need Review'**
  String get need_review;

  /// No description provided for @review.
  ///
  /// In en, this message translates to:
  /// **'Review Past Due'**
  String get review;

  /// No description provided for @custom_review.
  ///
  /// In en, this message translates to:
  /// **'Custom Review'**
  String get custom_review;

  /// No description provided for @ready_to_learn.
  ///
  /// In en, this message translates to:
  /// **'Ready To Learn'**
  String get ready_to_learn;

  /// No description provided for @learned.
  ///
  /// In en, this message translates to:
  /// **'Learned'**
  String get learned;

  /// No description provided for @memorize_this_word.
  ///
  /// In en, this message translates to:
  /// **'Memorize This Word...'**
  String get memorize_this_word;

  /// No description provided for @which_is.
  ///
  /// In en, this message translates to:
  /// **'Which of this is...'**
  String get which_is;

  /// No description provided for @select_kanji.
  ///
  /// In en, this message translates to:
  /// **'Select the kanji...'**
  String get select_kanji;

  /// No description provided for @feedback_note.
  ///
  /// In en, this message translates to:
  /// **'Please let me know if you have any questions, suggestions, bug reports or feature requests.'**
  String get feedback_note;

  /// No description provided for @send.
  ///
  /// In en, this message translates to:
  /// **'Send'**
  String get send;

  /// No description provided for @empty_field_error.
  ///
  /// In en, this message translates to:
  /// **'Empty Body'**
  String get empty_field_error;

  /// No description provided for @not_email_error.
  ///
  /// In en, this message translates to:
  /// **'Not Detected As An Email'**
  String get not_email_error;

  /// No description provided for @psw_short_error.
  ///
  /// In en, this message translates to:
  /// **'Not Longer Than 8'**
  String get psw_short_error;

  /// No description provided for @optional.
  ///
  /// In en, this message translates to:
  /// **'(Optional)'**
  String get optional;

  /// No description provided for @message.
  ///
  /// In en, this message translates to:
  /// **'Message'**
  String get message;

  /// No description provided for @your_email_address.
  ///
  /// In en, this message translates to:
  /// **'Your Email Address'**
  String get your_email_address;

  /// No description provided for @dont_save.
  ///
  /// In en, this message translates to:
  /// **'Don\'t Save'**
  String get dont_save;

  /// No description provided for @yes.
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get yes;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @ask_save_edit.
  ///
  /// In en, this message translates to:
  /// **'Save Edit?'**
  String get ask_save_edit;

  /// No description provided for @speech_speed.
  ///
  /// In en, this message translates to:
  /// **'Speech Speed'**
  String get speech_speed;

  /// No description provided for @off.
  ///
  /// In en, this message translates to:
  /// **'Off'**
  String get off;

  /// No description provided for @slow.
  ///
  /// In en, this message translates to:
  /// **'Slow'**
  String get slow;

  /// No description provided for @medium.
  ///
  /// In en, this message translates to:
  /// **'Medium'**
  String get medium;

  /// No description provided for @fast.
  ///
  /// In en, this message translates to:
  /// **'Fast'**
  String get fast;

  /// No description provided for @review_order.
  ///
  /// In en, this message translates to:
  /// **'Review Question Order'**
  String get review_order;

  /// No description provided for @eng_first.
  ///
  /// In en, this message translates to:
  /// **'English First'**
  String get eng_first;

  /// No description provided for @jp_first.
  ///
  /// In en, this message translates to:
  /// **'Japanese First'**
  String get jp_first;

  /// No description provided for @random.
  ///
  /// In en, this message translates to:
  /// **'Random'**
  String get random;

  /// No description provided for @review_fre.
  ///
  /// In en, this message translates to:
  /// **'Review Frequency'**
  String get review_fre;

  /// No description provided for @less.
  ///
  /// In en, this message translates to:
  /// **'Less'**
  String get less;

  /// No description provided for @more.
  ///
  /// In en, this message translates to:
  /// **'More'**
  String get more;

  /// No description provided for @send_feedback.
  ///
  /// In en, this message translates to:
  /// **'Send FeedBack'**
  String get send_feedback;

  /// No description provided for @lesson.
  ///
  /// In en, this message translates to:
  /// **'Lesson'**
  String get lesson;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'zh'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'zh':
      return AppLocalizationsZh();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
