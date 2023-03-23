import 'dart:math';

import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ttfa/router.dart';
import 'package:ttfa/utils/app_colors.dart';

class ChampionsView extends StatefulWidget {
  const ChampionsView({super.key});

  @override
  State<ChampionsView> createState() => _ChampionsViewState();
}

class _ChampionsViewState extends State<ChampionsView> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Go to Champion details : ',
            ),
            TextButton(
              onPressed: () {
                AppRouter.push(context, NavPosition.inChampionDetails,
                    transition: TransitionType.fadeIn,
                    durationInMilliseconds: 200);
              },
              child: Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: AppColors.secondary,
                ),
                child: Text("Zac"),
            ),
            ),
          ],
        ),
      ),
    );
  }
}
