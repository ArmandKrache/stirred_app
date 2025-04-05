// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get unexpectedErrorTitle => 'Unexpected error';

  @override
  String get unexpectedErrorBody => 'An unexpected error occurred. Please try again later.';

  @override
  String get unexpectedErrorActionRetry => 'Retry';

  @override
  String get checkYourConnectivity => 'Check your connectivity';
}
