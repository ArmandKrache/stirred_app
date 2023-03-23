import 'package:flutter/material.dart';
import 'package:ttfa/router.dart';
import 'package:ttfa/utils/app_colors.dart';

class SubScreenTopBar extends StatelessWidget implements PreferredSizeWidget {
  final List<Widget>? actions;
  final String title;
  final GestureTapCallback? onBackPressed;
  final Icon? leadingIcon;
  final Color backgroundColor;

  const SubScreenTopBar(
      {Key? key,
        this.title = "",
        this.actions,
        this.onBackPressed,
        this.leadingIcon,
        this.backgroundColor = AppColors.background})
      : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(48.0);

  @override
  Widget build(BuildContext context) {
    GestureTapCallback leadingOnPressed = onBackPressed ??
            () {
          AppRouter.pop(context);
        };

    return PreferredSize(
        preferredSize: preferredSize,
        child: AppBar(
            title: Text(title,
                style: const TextStyle(
                    color: AppColors.onBackground,
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0)),
            automaticallyImplyLeading: true,
            leading: IconButton(
              icon: leadingIcon ??
                  const Icon(
                    Icons.keyboard_arrow_left_rounded,
                    color: AppColors.onBackground,
                    size: 32.0,
                  ),
              onPressed: leadingOnPressed,
            ),
            elevation: 0.0,
            centerTitle: true,
            actions: actions,
            backgroundColor: backgroundColor));
  }
}
