import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ttfa/utils/app_colors.dart';
import 'package:ttfa/widgets/subScreenTopBar.dart';

class ChampionsDetailsView extends StatefulWidget {
  const ChampionsDetailsView({super.key});

  @override
  State<ChampionsDetailsView> createState() => _ChampionsDetailsViewState();
}

class _ChampionsDetailsViewState extends State<ChampionsDetailsView> {

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      /// TODO: Champion's name
      appBar: SubScreenTopBar(title: "Zac"),
      backgroundColor: AppColors.secondary,
      body: Center(
        child: Text(
          'Champion Infos : ',
        ),
      ),
    );
  }
}
