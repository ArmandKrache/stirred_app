import 'package:auto_route/auto_route.dart';
import 'package:cocktail_app/src/config/router/app_router.dart';
import 'package:cocktail_app/src/domain/models/article.dart';
import 'package:cocktail_app/src/domain/models/drink.dart';
import 'package:cocktail_app/src/domain/models/drink_details.dart';
import 'package:cocktail_app/src/presentation/cubits/remote_articles/remote_articles_cubit.dart';
import 'package:cocktail_app/src/presentation/cubits/remote_drinks/remote_drinks_cubit.dart';
import 'package:cocktail_app/src/presentation/widgets/article_widget.dart';
import 'package:cocktail_app/src/presentation/widgets/drink_widget.dart';
import 'package:cocktail_app/src/utils/extensions/scroll_controller.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:ionicons/ionicons.dart';

@RoutePage()
class HomepageView extends HookWidget {
  const HomepageView({Key? key}) : super (key: key);

  @override
  Widget build(BuildContext context) {
    final remoteDrinksCubit = BlocProvider.of<RemoteDrinksCubit>(context);
    final scrollController = useScrollController();

    useEffect(() {
      scrollController.onScrollEndsListener(() {
        remoteDrinksCubit.getFilteredCocktails(filters: {"ingredients" : "Vodka"});
      });

      return scrollController.dispose;
    }, const []);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          tr("homepage.popular_cocktails"),
        style: const TextStyle(color: Colors.black),
        ),
        actions: [
          GestureDetector(
            onTap: () => appRouter.push(const SavedArticlesRoute()),
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: Icon(Ionicons.bookmark, color: Colors.amber,),
            ),
          ),
        ],
      ),
      body: BlocBuilder<RemoteDrinksCubit, RemoteDrinksState>(
        builder: (_, state) {
          switch (state.runtimeType) {
            case RemoteDrinksLoading:
              return const Center(child: CupertinoActivityIndicator());
            case RemoteDrinksFailed:
              return const Center(child: Icon(Ionicons.refresh));
            case RemoteDrinksSuccess:
              return _buildArticles(
                scrollController,
                state.drinks,
                state.noMoreData,
              );
            default:
              return const SizedBox();
          }
        }
      )
    );
  }

  Widget _buildArticles(
      ScrollController scrollController,
      List<Drink> drinks,
      bool noMoreData) {
    return CustomScrollView(
      controller: scrollController,
      slivers: [
        SliverList(
          delegate: SliverChildBuilderDelegate(
              (context, index) => DrinkWidget(
                drink: drinks[index],
                onArticlePressed: (element) =>
                    appRouter.push(DrinkDetailsRoute(drinkId: drinks[index].idDrink)),
              ),
              childCount: drinks.length),
        ),

        if (!noMoreData)
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.only(top: 12, bottom: 32),
              child: CupertinoActivityIndicator(),
            ),
          ),
      ],
    );
  }

}