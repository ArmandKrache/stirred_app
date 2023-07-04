import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart' as CustomModalSheet;
import 'package:template_app/utils/app_colors.dart';
import 'package:template_app/views/settings_view.dart';

class SettingsButtonWidget extends StatelessWidget {
  final Function? onClose;

  SettingsButtonWidget({Key? key, this.onClose});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await showCustomBarModalBottomSheet(context, SettingsView());
        if (onClose != null) onClose!.call();
      },
      child: Container(
        width: 32,
        height: 32,
        margin: EdgeInsets.only(right: 8),
        child: const Icon(
          Icons.settings,
          size: 32,
          color: AppColors.gray700,
        ),
      ),
    );
  }

  Future<void> showCustomBarModalBottomSheet(
      BuildContext context, Widget child) async {
    return await CustomModalSheet.showBarModalBottomSheet(
      context: context,
      builder: (context) => child,
      expand: false,
      backgroundColor: AppColors.transparent,
      barrierColor: AppColors.black.withOpacity(0.4),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    );
  }
}
