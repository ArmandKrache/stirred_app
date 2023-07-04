import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:template_app/router.dart';

class LanguagePickerDialog extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LanguagePickerDialogState();
  }
}

class LanguagePickerDialogState extends State<LanguagePickerDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        height: 128,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _languageContainer("en", "🇺🇸", "English"),
            _languageContainer("fr", "🇫🇷", "French"),
          ],
        ),
      ),
    );
  }

  GestureDetector _languageContainer(String languageCode, String flag, String name) {
    return GestureDetector(
      onTap: () async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString("languageCode", languageCode);
        ///TODO : Set current Locale
        setState(() {
          context.setLocale(Locale(languageCode));
        });
        AppRouter.pop(context);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        color: Colors.transparent,
        height: 48,
        child: Row(
          children: [
            Text(
              flag,
              style: const TextStyle(fontSize: 32),
            ),
            const SizedBox(
              width: 16,
            ),
            Text(
              name,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
