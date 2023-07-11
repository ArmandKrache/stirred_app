import 'package:auto_route/auto_route.dart';
import 'package:cocktail_app/src/config/router/app_router.dart';
import 'package:cocktail_app/src/domain/models/article.dart';
import 'package:cocktail_app/src/presentation/cubits/local_articles/local_articles_cubit.dart';
import 'package:cocktail_app/src/presentation/widgets/article_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:ionicons/ionicons.dart';

@RoutePage()
class SavedArticlesView extends HookWidget {
  const SavedArticlesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => appRouter.pop(),
          child: const Icon(Ionicons.chevron_back, color: Colors.black,),
        ),
        title: Text(
          tr("saved_articles.saved_articles"),
          style: const TextStyle(color: Colors.black),
        ),
      ),
      body: BlocBuilder<LocalArticlesCubit, LocalArticlesState>(
        builder: (_, state) {
          switch (state.runtimeType) {
            case LocalArticlesLoading:
              return const Center(child: CupertinoActivityIndicator());
            case LocalArticlesSuccess:
              return _buildArticlesList(state.articles);
            default:
              return const SizedBox();
          }
        },
      ),
    );
  }

  Widget _buildArticlesList(List<Article> articles) {
    if (articles.isEmpty) {
      return Center(
        child: Text(
          tr("saved_articles.no_saved_articles_disclaimer"),
          style: const TextStyle(color: Colors.black),
      ),);
    }

    return ListView.builder(
      itemCount: articles.length,
      itemBuilder: (context, index) {
        return ArticleWidget(
          article: articles[index],
          isRemovable: true,
          onRemove: (article) => BlocProvider.of<LocalArticlesCubit>(context)
            .removeArticles(article: article),
          onArticlePressed: (article) => appRouter.push(
            ArticleDetailsRoute(article: article)
          ),
        );
    });
  }

}