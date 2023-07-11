import 'package:auto_route/auto_route.dart';
import 'package:cocktail_app/src/config/router/app_router.dart';
import 'package:cocktail_app/src/domain/models/article.dart';
import 'package:cocktail_app/src/presentation/cubits/remote_articles/remote_articles_cubit.dart';
import 'package:cocktail_app/src/presentation/widgets/article_widget.dart';
import 'package:cocktail_app/src/utils/extensions/scroll_controller.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:ionicons/ionicons.dart';

@RoutePage()
class BreakingNewsView extends HookWidget {
  const BreakingNewsView({Key? key}) : super (key: key);

  @override
  Widget build(BuildContext context) {
    final remoteArticlesCubit = BlocProvider.of<RemoteArticlesCubit>(context);
    final scrollController = useScrollController();


    useEffect(() {
      scrollController.onScrollEndsListener(() {
        remoteArticlesCubit.getBreakingNewsArticles();
      });

      return scrollController.dispose;
    }, const []);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          tr("breaking_news.daily_news"),
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
      body: BlocBuilder<RemoteArticlesCubit, RemoteArticlesState>(
        builder: (_, state) {
          switch (state.runtimeType) {
            case RemoteArticlesLoading:
              return const Center(child: CupertinoActivityIndicator());
            case RemoteArticlesFailed:
              return const Center(child: Icon(Ionicons.refresh));
            case RemoteArticlesSuccess:
              return _buildArticles(
                scrollController,
                state.articles,
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
      List<Article> articles,
      bool noMoreData) {
    return CustomScrollView(
      controller: scrollController,
      slivers: [
        SliverList(
          delegate: SliverChildBuilderDelegate(
              (context, index) => ArticleWidget(
                article: articles[index],
                onArticlePressed: (element) => appRouter.push(ArticleDetailsRoute(article: element)),
              ),
              childCount: articles.length),
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