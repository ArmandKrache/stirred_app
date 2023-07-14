import 'dart:developer';
import 'package:auto_route/auto_route.dart';
import 'package:cocktail_app/src/config/router/app_router.dart';
import 'package:cocktail_app/src/domain/models/drink.dart';
import 'package:cocktail_app/src/domain/models/drink_details.dart';
import 'package:cocktail_app/src/presentation/cubits/local_articles/local_articles_cubit.dart';
import 'package:cocktail_app/src/presentation/cubits/local_details/local_details_cubit.dart';
import 'package:cocktail_app/src/presentation/cubits/remote_details/remote_details_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:ionicons/ionicons.dart';
import 'package:oktoast/oktoast.dart';

@RoutePage()
class DrinkDetailsView extends HookWidget {
  final Drink drink;

  const DrinkDetailsView({Key? key, required this.drink}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final localDetailsCubit = BlocProvider.of<LocalDrinkCubit>(context);
    final remoteDetailsCubit = BlocProvider.of<RemoteDetailsCubit>(context);

    useEffect(() {
      remoteDetailsCubit.handleEvent(LookupDetailsEvent(drinkId: drink.idDrink));
      return;
    }, []);

    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => appRouter.pop(),
          child: const Icon(Ionicons.chevron_back, color: Colors.black,),
        ),
      ),
      body: BlocBuilder<RemoteDetailsCubit, RemoteDetailsState>(
      builder: (_, state) {
        switch (state.runtimeType) {
          case RemoteDetailsLoading:
            return const Center(child: CupertinoActivityIndicator());
          case RemoteDetailsFailed:
            return const Center(child: Icon(Ionicons.refresh));
          case RemoteDetailsSuccess:
            return SingleChildScrollView(
              child: Column(
              children: [
                _buildTitle(state.drinksDetails.last),
                _buildImage(state.drinksDetails.last),
                _buildIngredientsAndPreparation(state.drinksDetails.last),
              ],
            ),
          );
          default:
           return const SizedBox();
        }
      }
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          localDetailsCubit.saveDrink(drink: drink);
          showToast(tr("article_details.article_saved_confirm"));
        },
        child: const Icon(Ionicons.bookmark, color: Colors.white,),
      ),
    );
  }

  Widget _buildTitle(DrinkDetails details) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            details.title ?? "",
            style: const TextStyle(
                fontFamily: "Butler",
                fontSize: 20,
                fontWeight: FontWeight.w900
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImage(DrinkDetails details) {
    return Container(
      width: double.maxFinite,
      height: 256,
      margin: const EdgeInsets.only(top: 12, bottom: 12),
      child: Image.network(
        details.thumb ?? '',
        fit: BoxFit.cover,
        alignment: Alignment.topCenter,
      ),
    );
  }

  Widget _buildIngredientsAndPreparation(DrinkDetails details) {
    if (details.ingredients ==  null || details.measures == null) {
      return const SizedBox();
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Ingredients",
            style: TextStyle(
                fontFamily: "Butler",
                fontSize: 18,
                fontWeight: FontWeight.w900
            ),
          ),
          const SizedBox(height: 8,),
          for (int i = 0; i < details.ingredients!.length && i < details.measures!.length; i++)
            Text("${details.measures![i] ?? ""} ${details.ingredients![i]}"),
          const SizedBox(height: 16,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Preparation",
                style: TextStyle(
                    fontFamily: "Butler",
                    fontSize: 18,
                    fontWeight: FontWeight.w900
                ),
              ),
              Row(
                children: [
                  const Icon(Ionicons.wine_outline, size: 16,),
                  const SizedBox(width: 4,),
                  Text(
                    details.glass ?? '',
                    style: const TextStyle(fontSize: 14),
                  )
                ],
              ),
            ],
          ),
          const SizedBox(height: 8,),
          Text('${details.instructions}',
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}