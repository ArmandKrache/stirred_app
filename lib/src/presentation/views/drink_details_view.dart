import 'package:auto_route/auto_route.dart';
import 'package:cocktail_app/src/config/router/app_router.dart';
import 'package:cocktail_app/src/domain/models/article.dart';
import 'package:cocktail_app/src/presentation/cubits/local_articles/local_articles_cubit.dart';
import 'package:cocktail_app/src/presentation/cubits/remote_drinks/remote_drinks_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:ionicons/ionicons.dart';
import 'package:oktoast/oktoast.dart';

@RoutePage()
class DrinkDetailsView extends HookWidget {
  final String? drinkId;

  const DrinkDetailsView({Key? key, required this.drinkId}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    final localArticlesCubit = BlocProvider.of<LocalArticlesCubit>(context);
    final remoteDrinksCubit = BlocProvider.of<RemoteDrinksCubit>(context);

    useEffect(() {
      /// remoteDrinksCubit.getDrinkDetails(filters: {"id" : drinkId});
    }, const []);

    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => appRouter.pop(),
          child: const Icon(Ionicons.chevron_back, color: Colors.black,),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildArticleTitleAndDate(),
            _buildArticleImage(),
            _buildArticleDescription(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          /// localArticlesCubit.saveArticle(article: article);
          showToast(tr("article_details.article_saved_confirm"));
        },
        child: const Icon(Ionicons.bookmark, color: Colors.white,),
      ),
    );
  }

  Widget _buildArticleTitleAndDate() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'title', /// article.title ?? "",
            style: const TextStyle(
                fontFamily: "Butler",
                fontSize: 20,
                fontWeight: FontWeight.w900
            ),
          ),
          const SizedBox(height: 12,),
          Row(
            children: [
              const Icon(Ionicons.time_outline, size: 16,),
              const SizedBox(width: 4,),
              Text(
                'publishedAt', /// article.publishedAt ?? '',
                style: const TextStyle(fontSize: 12),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildArticleImage() {
    return Container(
      width: double.maxFinite,
      height: 256,
      margin: const EdgeInsets.only(top: 12),
      child: Image.network(
        "", /// article.urlToImage ?? '',
        fit: BoxFit.cover,
        alignment: Alignment.topCenter,
      ),
    );
  }

  Widget _buildArticleDescription() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      child: Text('Description',
      /// child: Text('${article.description}\n\n${article.content}',
        style: const TextStyle(fontSize: 16),
      ),
    );
  }
}