import 'package:flutter/material.dart';
import 'package:stirred_app/core/l10n/app_localizations.dart';

extension BuildContextExtensions on BuildContext {
  AppLocalizations get localizations => AppLocalizations.of(this)!;

  bool get isLandscape => MediaQuery.of(this).orientation == Orientation.landscape;
}
