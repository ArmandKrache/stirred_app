import 'package:flutter/material.dart';
import 'package:template_app/utils/app_colors.dart';

class PopInDisclaimer extends StatelessWidget {
  final String bodyText;
  final String? cancelText;
  final String? confirmText;
  final GestureTapCallback cancelTap;
  final GestureTapCallback confirmTap;

  PopInDisclaimer(
      {Key? key,
        required this.bodyText,
        required this.cancelTap,
        required this.confirmTap,
        this.cancelText,
        this.confirmText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      contentPadding: const EdgeInsets.only(
        top: 16,
      ),
      backgroundColor: AppColors.background,
      title: const Text(
        "Caution",
        style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22.0,
            color: AppColors.onBackground),
        textAlign: TextAlign.center,
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.only(
              bottom: 24,
              right: 16,
              left: 16,
            ),
            child: Text(
              bodyText,
              style: const TextStyle(color: AppColors.secondaryText, fontSize: 16.0),
              textAlign: TextAlign.center,
            ),
          ),
          Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
            Expanded(
              child: Container(
                height: 48,
                child: TextButton(
                  onPressed: cancelTap,
                  child: Text(
                    cancelText ??
                        "Cancel",
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.black,
                        fontSize: 16.0),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                height: 48,
                child: TextButton(
                  onPressed: confirmTap,
                  child: Text(
                    confirmText ??
                        "Confirm",
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                        color: AppColors.alert),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ])
        ],
      ),
    );
  }
}
