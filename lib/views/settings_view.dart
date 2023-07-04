import 'package:easy_localization/easy_localization.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:template_app/router.dart';
import 'package:template_app/utils/app_colors.dart';
import 'package:template_app/widgets/languagePickerDialog.dart';
import 'package:template_app/widgets/popInDisclaimer.dart';

class SettingsView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _SettingsView();
  }
}

class _SettingsView extends State<SettingsView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        top: false,
        child: _bodyContainer(),
      ),
    );
  }

  Container _bodyContainer() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: ListView(
        /// controller: ModalScrollController.of(context),
        scrollDirection: Axis.vertical,
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        children: [
          _settingsContainer(
              title: "Contact us",
              iconData: Icons.mail_outline_rounded,
              /*onTap: () {
                AppRouter.push(context, NavPosition.inWebview,
                    navDetails: {"webview_id": "contact_us"},
                    replace: false,
                    durationInMilliseconds: 200,
                    transition: TransitionType.inFromRight,
                    routeSettings: RouteSettings(arguments: {
                      "path":
                          '${FlutterI18n.translate(context, "strings.localizedUrl.contactUs")}?clean=1',
                      "title":
                          "${FlutterI18n.translate(context, "strings.v1.contactUs")}"
                    }));
              },*/
              trailingArrow: true),
          _languagePickerContainer(),
          /*_settingsContainer(
            title: FlutterI18n.translate(context, "strings.v3.giveUsARate"),
            iconData: Icons.star,
            iconColor: AppColors.gold,
            onTap: () {
              AppStoreReview.openStoreReview();
            },
          ),*/
          const Divider(
            color: AppColors.grayBackground,
            thickness: 2,
          ),
          /*Center(
            child: Container(
              margin: const EdgeInsets.only(top: 16),
              child: SocialMediaButtons(),
            ),
          ),*/
          const SizedBox(
            height: 16,
          ),
          // _cgvAndPrivacyPolicyContainer(),
          _disconnectContainer(),
          Center(
            child: Container(
              child: const Text(
                "Version" +
                    " : X.Y.Z",
                style: TextStyle(
                    color: AppColors.disabledElement,
                    fontWeight: FontWeight.bold,
                    fontSize: 12.0),
              ),
            ),
          ),
        ],
      ),
    );
  }

  GestureDetector _settingsContainer(
      {required String title,
      IconData? iconData,
      GestureTapCallback? onTap,
      bool trailingArrow = false,
      Color? iconColor}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: Colors.transparent,
        margin: const EdgeInsets.symmetric(
          vertical: 8,
        ),
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(
                  iconData,
                  size: 24,
                  color: iconColor ?? AppColors.onBackground,
                ),
                const SizedBox(
                  width: 8,
                ),
                Text(
                  title,
                  style: const TextStyle(fontSize: 14),
                ),
              ],
            ),
            trailingArrow
                ? const Icon(
                    Icons.keyboard_arrow_right_rounded,
                    size: 24,
                  )
                : Container()
          ],
        ),
      ),
    );
  }

  GestureDetector _languagePickerContainer() {
    return GestureDetector(
      onTap: () async {
        await showDialog(
            context: context,
            builder: (_) {
              return LanguagePickerDialog();
            });
        setState(() {});
      },
      child: Container(
        color: Colors.transparent,
        margin: const EdgeInsets.symmetric(
          vertical: 8,
        ),
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Text(
                  tr("locale.flag_emoji"),
                  style: const TextStyle(fontSize: 24),
                ),
                const SizedBox(
                  width: 8,
                ),
                Text(
                  tr("locale.language"),
                  style: const TextStyle(fontSize: 14),
                ),
              ],
            ),
            const Icon(
              Icons.keyboard_arrow_right_rounded,
              size: 24,
            )
          ],
        ),
      ),
    );
  }

  Widget _disconnectContainer() {
    return Center(
      child: GestureDetector(
        onTap: () {
          showDialog(
              context: context,
              builder: (_) {
                return PopInDisclaimer(
                    bodyText: tr("settings.disconnect_disclaimer"),
                    cancelTap: () {
                      AppRouter.pop(context);
                    },
                    confirmTap: () {
                      AppRouter.logout(context);
                    });
              });
        },
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 16),
          child: Text(
            tr("settings.disconnect"),
            style: const TextStyle(
                color: AppColors.alert,
                fontWeight: FontWeight.bold,
                fontSize: 16.0),
          ),
        ),
      ),
    );
  }
}
